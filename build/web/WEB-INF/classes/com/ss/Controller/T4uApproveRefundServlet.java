/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ss.Controller;

import com.google.gson.Gson;
import com.ss.DAO.T4uOrderDAO;
import com.ss.Model.T4uOrder;
import com.ss.Model.T4uUser;
import com.ss.app.T4uConstants;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

/**
 *
 * @author mengxualv2
 */
public class T4uApproveRefundServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        T4uUser user = (T4uUser)session.getAttribute(T4uConstants.T4uUser);
        if (!user.getUserGroup().equals("officer")) // Not authorised, only user himself can cancel order
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Not authorised");
        else try {
            long orderId = Long.parseLong(request.getParameter("orderId"));
            T4uOrder order = T4uOrderDAO.getOrderById(orderId);
            if (order.getOrderStatus() == 2) { // Current status is Pending
                T4uOrderDAO.changeOrderStatus(orderId, 3, user);
                T4uOrder t4uOrder = new T4uOrder();
                t4uOrder.setOrderId(orderId);
                String json = new Gson().toJson(t4uOrder);
                response.setContentType("application/json");
                // Get the printwriter object from response to write the required json object to the output stream      
                PrintWriter out = response.getWriter();
                // Assuming your json object is **jsonObject**, perform the following, it will return your json object  
                out.print(json);
                out.flush();
            } else // Not pending status
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Bad order status");
        } catch (NumberFormatException ex) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "NumberFormatException");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

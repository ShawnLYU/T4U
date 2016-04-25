/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ss.Controller;

import com.google.gson.Gson;
import com.ss.DAO.T4uOrderDAO;
import com.ss.DAO.T4uScheduleDAO;
import com.ss.Model.T4uOrder;
import com.ss.Model.T4uUser;
import com.ss.app.T4uConstants;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author mengxualv2
 */
public class T4uCartPayServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(T4uCartPay.class);
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
        if (user == null) { // User not logged in
            LOGGER.debug("User has not yet logged in.");
            String requestUri = request.getRequestURI();
            LOGGER.debug(String.format("Redirecting to /login.jsp?redirect=%s.", requestUri));
            request.setAttribute(T4uConstants.T4U_LOGINREDIRECT, requestUri);
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login.jsp");
            dispatcher.forward(request, response);
        } else if (!user.getUserGroup().equals("officer")){ // Logged in as a normal user
            request.setAttribute("error", T4uConstants.ExUserNotAuthorised);
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/error.jsp");
            dispatcher.forward(request, response);
        } else { // Logged in as officer
            int index = 0;
            try {
                index = Integer.parseInt(request.getParameter("index"));
            } catch (Exception ex) {
            }
            String action = request.getParameter("action");
            List<T4uOrder> listOfOrder;
            if(session.getAttribute(T4uConstants.T4uCart)==null)
                listOfOrder = new ArrayList<T4uOrder>();
            else
                listOfOrder = (List<T4uOrder>) session.getAttribute(T4uConstants.T4uCart);
            if (action.equals("single")) {
                String result = pay(listOfOrder.get(index));
                if (result != null)
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, result);
                listOfOrder.remove(index);
            } else if (action.equals("all")) {
                for (int i=0; i<listOfOrder.size(); i++) {
                    String result = pay(listOfOrder.get(i));
                    if (result != null)
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, result);
                }
                listOfOrder.clear();
            }
            session.setAttribute(T4uConstants.T4uCart, listOfOrder);
            // Callback
            String json = new Gson().toJson(index);
            response.setContentType("application/json");
            // Get the printwriter object from response to write the required json object to the output stream      
            PrintWriter out = response.getWriter();
            // Assuming your json object is **jsonObject**, perform the following, it will return your json object  
            out.print(json);
            out.flush();
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
    
    private String pay(T4uOrder order) {
        int userId = 15;
        int scheduleId = order.getScheduleId();
        double orderCash = order.getOrderCash();
        int orderCredit = 0;
        int len = order.getOrderSeats().length();
        List<String> allSeats = Arrays.asList(order.getOrderSeats().substring(1,len-1).replaceAll(" ","").split(","));
        // Alert database
        // Check whether the seats are occupied or unavailable in table T4U_schedule
        String oSeats = T4uScheduleDAO.getOSeatsById(scheduleId);
        boolean occupied = false;
        for (String seat: allSeats)
            if (oSeats.contains(seat)) {
                occupied = true;
                break;
            }
        if (occupied) // Seat occupied, need to buy again
            return "occupied";
        else {
            long orderId;
            // Add the seats to the Occupied List in table T4U_schedule
            String oldOSeats = oSeats;
            for (String seat: allSeats)
                oSeats += "'" + seat + "',";
            if (T4uScheduleDAO.updateOSeatsById(scheduleId, oSeats)) // Create a new order in table T4U_order
                orderId = T4uOrderDAO.placeOrder(userId, scheduleId, allSeats, orderCash, orderCredit, oldOSeats);
        }
        return null;
    }
}

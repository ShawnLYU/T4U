/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Controller;

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
import org.json.*;

/**
 *
 * @author mengxualv2
 */
public class T4uPaymentServlet extends HttpServlet {

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
        // Get request query
        int userId = 0;
        int scheduleId = 0;
        int payMethod = 0;
        List<String> seats = new ArrayList<String>();
        try {
            userId = Integer.parseInt(request.getParameter("userId"));
            scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
//            JSONArray jsonSeats = new JSONArray(request.getParameter("seats"));
//            if (jsonSeats.length() > 0)
//                for (int i=0; i<jsonSeats.length(); i++)
//                    seats.add(jsonSeats.getString(i));
            int len = request.getParameter("seats").length();
            seats = Arrays.asList(request.getParameter("seats").substring(1,len-1).split(","));
            payMethod = Integer.parseInt(request.getParameter("payMethod"));
            if (payMethod != 1 && payMethod != 2)
                throw new NumberFormatException();
        } catch (NumberFormatException ex) {
        } catch (JSONException ex) {
        }
        // Alert database
        // Check whether the seats are occupied or unavailable in table T4U_schedule
        
        // Add the seats to the Occupied List in table T4U_schedule
        if (payMethod == 1) {
            String cardNo = request.getParameter("cardNo");
            String cardPwd = request.getParameter("cardPwd");
            // Create a new refundable order in table T4U_order
        } else {
            // Create a new unrefundable order in table T4U_order
        }
        
        //after successful payment
        request.setAttribute("error", T4uConstants.ExSuccessfullyPaid);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/error.jsp");
        dispatcher.forward(request, response);
        
        
        
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

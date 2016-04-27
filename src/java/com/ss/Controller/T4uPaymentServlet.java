/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Controller;

import com.ss.DAO.T4uOrderDAO;
import com.ss.DAO.T4uScheduleDAO;
import com.ss.DAO.T4uUserDAO;
import com.ss.Model.T4uUser;
import com.ss.app.T4uConstants;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession(true);
        // Get request query
        int userId = 0;
        int scheduleId = 0;
        double orderCash = 0;
        int orderCredit = 0;
        int userCredit = 0;
        try {
            userId = Integer.parseInt(request.getParameter("userId"));
            scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
            orderCash = Double.parseDouble(request.getParameter("bankcard"));
            if (request.getParameter("demo5") != null)
                orderCredit = Integer.parseInt(request.getParameter("demo5"));
            userCredit = Integer.parseInt(request.getParameter("userCredit"));
        } catch (NumberFormatException ex) {
        } catch (NullPointerException ex) {
        }
        int len = request.getParameter("seats").length();
        List<String> allSeats = Arrays.asList(request.getParameter("seats").substring(1,len-1).replaceAll(" ","").split(","));
        String cardNo = request.getParameter("cardNo");
        String cardPwd = request.getParameter("cardPwd");
        // Alert database
        // Check whether the seats are occupied or unavailable in table T4U_schedule
        String oSeats = T4uScheduleDAO.getOSeatsById(scheduleId);
        boolean occupied = false;
        for (String seat: allSeats)
            if (oSeats.contains(seat)) {
                occupied = true;
                break;
            }
        if (occupied) {
            // Seat occupied, need to buy again
            session.setAttribute(T4uConstants.ExSeatOccupied, true);
            response.sendRedirect(request.getContextPath() + "/movie/seat?scheduleId=" + scheduleId);
        } else {
            long orderId;
            // Add the seats to the Occupied List in table T4U_schedule
            String oldOSeats = oSeats;
            for (String seat: allSeats)
                oSeats += "'" + seat + "',";
            if (T4uScheduleDAO.updateOSeatsById(scheduleId, oSeats)) {
                // Create a new order in table T4U_order
                orderId = T4uOrderDAO.placeOrder(userId, scheduleId, allSeats, orderCash, orderCredit, oldOSeats);
                // Deduct user's credit
                T4uUserDAO.deductUserCredit(userId, userCredit - orderCredit + (int)orderCash);
            }
            T4uUser user = new T4uUser();
            user.setUserId(userId);
            T4uUserDAO.injectT4uUserById(user);
            session.setAttribute(T4uConstants.T4uUser, user);
             //after successful payment
            request.setAttribute("error", T4uConstants.ExSuccessfullyPaid);
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/error.jsp");
            dispatcher.forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(T4uPaymentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(T4uPaymentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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

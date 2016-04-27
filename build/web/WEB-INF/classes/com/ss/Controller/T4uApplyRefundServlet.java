/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ss.Controller;

import com.ss.DAO.T4uOrderDAO;
import com.ss.DAO.T4uScheduleDAO;
import com.ss.Model.T4uOrder;
import com.ss.Model.T4uUser;
import com.ss.app.T4uConstants;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author Steven
 */
public class T4uApplyRefundServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(T4uApplyRefundServlet.class);
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
        } else try { // User logged in
            long orderId = Long.parseLong(request.getParameter("orderId"));
            T4uOrder order = T4uOrderDAO.getOrderById(orderId);
            if (order.getUserId() != user.getUserId()) {
                // Not authorised, only user himself can cancel order
                request.setAttribute("error", T4uConstants.ExUserNotAuthorised);
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/error.jsp");
                dispatcher.forward(request, response);
            } else if (order.getOrderCredit() > 0) {
                // Credit used, not refundable
                request.setAttribute("error", T4uConstants.ExUserNotRefundable);
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/error.jsp");
                dispatcher.forward(request, response);
            } else {
                // Get current time
                Date now = Calendar.getInstance().getTime();
                Timestamp leadTime = new Timestamp(order.getSchedule().getScheduleTimeslot().getTime()-3*60*60*1000);
                if (now.after(leadTime)) {
                    // Lead time expired, not refundable
                    request.setAttribute("error", T4uConstants.ExUserNotRefundable);
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/error.jsp");
                    dispatcher.forward(request, response);
                } else {
                    if (T4uOrderDAO.changeOrderStatus(orderId, 2, user)) { // Refund
                        // Release Seats
                        String releaseSeats = order.getOrderSeats();
                        String allSeats = order.getSchedule().getScheduleOSeats();
                        String newSeats = allSeats.replace(releaseSeats, "");
                        T4uScheduleDAO.updateOSeatsById(order.getScheduleId(), newSeats);
                        // Success
                        request.setAttribute("error", T4uConstants.ExSuccessfullyApplyRefund);
                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/error.jsp");
                        dispatcher.forward(request, response);
                    }
                }
            }
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

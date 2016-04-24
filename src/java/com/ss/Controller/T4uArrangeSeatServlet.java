/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ss.Controller;

import com.ss.DAO.T4uScheduleDAO;
import com.ss.Model.T4uSchedule;
import com.ss.Model.T4uUser;
import com.ss.app.T4uConstants;
import java.io.IOException;
import java.util.ArrayList;
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
 * @author Steven
 */
public class T4uArrangeSeatServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(T4uArrangeSeatServlet.class);
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
        // Is the current user a manager?
        HttpSession session = request.getSession(true);
        T4uUser user = (T4uUser)session.getAttribute(T4uConstants.T4uUser);
        if (user == null) { // User not logged in
            LOGGER.debug("User has not yet logged in.");
            String requestUri = request.getRequestURI();
            LOGGER.debug(String.format("Redirecting to /login.jsp?redirect=%s.", requestUri));
            request.setAttribute(T4uConstants.T4U_LOGINREDIRECT, requestUri);
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login.jsp");
            dispatcher.forward(request, response);
        } else if (!user.getUserGroup().equals("admin")){ // Logged in as a normal user
            request.setAttribute("error", T4uConstants.ExUserNotAuthorised);
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/error.jsp");
            dispatcher.forward(request, response);
        } else { // Logged in as a manager
            List<Integer> allScheduleIds = T4uScheduleDAO.getAllScheduleIds();
            List<T4uSchedule> allSchedules = new ArrayList<T4uSchedule>();
            for (int scheduleId: allScheduleIds)
                allSchedules.add(T4uScheduleDAO.getScheduleById(scheduleId));
            request.setAttribute(T4uConstants.T4U_ALLSCHEDULES, allSchedules);
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/movieSeatForManager.jsp");
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ss.Controller;

import com.ss.Model.T4uUser;
import com.ss.app.T4uConstants;
import java.io.IOException;
import java.net.URLEncoder;
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
public class T4uMovieSeatServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(T4uMovieSeatServlet.class);
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
            String requestUri = request.getRequestURI() + "?" + request.getQueryString();
            LOGGER.debug(String.format("Redirecting to /login.jsp?redirect=%s.", requestUri));
            request.setAttribute(T4uConstants.T4U_LOGINREDIRECT, requestUri);
//            response.sendRedirect(request.getContextPath() + "/login.jsp");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login.jsp");
            dispatcher.forward(request, response);
        } else { // User logged in
            LOGGER.debug(String.format("%s has logged in.", user.getUserAccount()));
            String strScheuleId = request.getParameter("scheduleId");
            int scheuleId = 0;
            try {
                scheuleId = Integer.parseInt(strScheuleId);
            } catch (NumberFormatException ex) {
                scheuleId = 0;
            }
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

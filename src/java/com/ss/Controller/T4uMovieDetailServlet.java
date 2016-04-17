/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ss.Controller;

import com.ss.DAO.T4uCinemaDAO;
import com.ss.DAO.T4uHouseDAO;
import com.ss.DAO.T4uMovieDAO;
import com.ss.DAO.T4uScheduleDAO;
import com.ss.DAO.T4uVersionDAO;
import com.ss.Model.T4uCinema;
import com.ss.Model.T4uHouse;
import com.ss.Model.T4uMovie;
import com.ss.Model.T4uSchedule;
import com.ss.Model.T4uVersion;
import com.ss.app.T4uConstants;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author Steven
 * 
 * 2016041601    SM    Implemented the servlet
 */
public class T4uMovieDetailServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(T4uMovieDetailServlet.class);
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
        String strMovieId = request.getParameter("movieId");
        int movieId = 0;
        try {
            movieId = Integer.parseInt(strMovieId);
        } catch (NumberFormatException ex) {
            movieId = 0;
        }
        // Retrive all movies
        Map<Integer,T4uMovie> allMovies = T4uMovieDAO.getAllMovies();
        request.setAttribute(T4uConstants.T4U_ALLMOVIES, allMovies); // Only for poster roller
        T4uMovie movie = allMovies.get(movieId);
        if (movie == null) { // Cannot find this movie
            LOGGER.debug(String.format("Cannot load movie whose movieId = %d.", movieId));
            LOGGER.debug("Redirecting to /index.");
            response.sendRedirect(request.getContextPath());
        } else {
            LOGGER.debug(String.format("Saving movie whose movieId = %d as %s into session.", movieId, T4uConstants.T4U_CURMOVIE));
            request.setAttribute(T4uConstants.T4U_CURMOVIE, movie);
            // Retrieve all versions
            Map<Integer,T4uVersion> allVersions = T4uVersionDAO.getAllVersions(movie);
            request.setAttribute(T4uConstants.T4U_ALLVERSIONS, allVersions); // Gor filtering versions
            // Retrieve all houses
            Map<Integer, T4uHouse> allHouses = T4uHouseDAO.getAllHouses();
            // Retrieve all schedules
            Map<Integer, T4uSchedule> allSchedules = new HashMap<Integer, T4uSchedule>();
            for (Entry<Integer, T4uVersion> entry : allVersions.entrySet())
                T4uScheduleDAO.addSchedule(entry.getValue(), allHouses, allSchedules);
            request.setAttribute(T4uConstants.T4U_SELSCHEDULES, allSchedules);
            // Dispatch to JSP
            LOGGER.debug("Redirecting to /movieDetail.jsp.");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/movieDetail.jsp");
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

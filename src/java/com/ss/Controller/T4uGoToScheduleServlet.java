/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ss.Controller;

import com.ss.DAO.T4uHouseDAO;
import com.ss.DAO.T4uMovieDAO;
import com.ss.DAO.T4uScheduleDAO;
import com.ss.DAO.T4uVersionDAO;
import com.ss.Model.T4uHouse;
import com.ss.Model.T4uMovie;
import com.ss.Model.T4uSchedule;
import com.ss.app.T4uConstants;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

/**
 *
 * @author user
 */
public class T4uGoToScheduleServlet extends HttpServlet {

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
        List<Integer> allScheduleIds = T4uScheduleDAO.getAllScheduleIds();
        List<T4uSchedule> allSchedules = new ArrayList<T4uSchedule>();
        for (int scheduleId: allScheduleIds)
            allSchedules.add(T4uScheduleDAO.getScheduleById(scheduleId));
        Map<Integer, T4uHouse> allHouses = T4uHouseDAO.getAllHouses();
        Map<Integer, T4uMovie> allMovies = T4uMovieDAO.getAllMovies();
        for(Map.Entry<Integer, T4uMovie> entry : allMovies.entrySet()) {
            Integer key = entry.getKey();
            T4uMovie value = entry.getValue();
            value.setAllVersions(T4uVersionDAO.getAllVersions(value));
        }
        HttpSession session = request.getSession(true);
        session.setAttribute(T4uConstants.T4uAllSchedules,allSchedules );
        session.setAttribute(T4uConstants.T4uAllHouses, allHouses);
        session.setAttribute(T4uConstants.T4uAllMovies, allMovies);

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/schedules.jsp");
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

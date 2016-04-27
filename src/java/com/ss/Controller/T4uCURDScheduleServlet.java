/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ss.Controller;

import com.google.gson.Gson;
import com.ss.DAO.T4uHouseDAO;
import com.ss.DAO.T4uMovieDAO;
import com.ss.DAO.T4uScheduleDAO;
import com.ss.DAO.T4uVersionDAO;
import com.ss.Model.T4uHouse;
import com.ss.Model.T4uMovie;
import com.ss.Model.T4uSchedule;
import com.ss.Model.T4uUser;
import com.ss.app.T4uConstants;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.json.JSONObject;

/**
 *
 * @author user
 */
public class T4uCURDScheduleServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(T4uCURDScheduleServlet.class);
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
        } else if (!user.getUserGroup().equals("admin")){ // Logged in as a normal user
            request.setAttribute("error", T4uConstants.ExUserNotAuthorised);
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/error.jsp");
            dispatcher.forward(request, response);
        } else { // Logged in as admin
            // Get request
            String action = request.getParameter("action");
            if(action!=null){
                String oSeats = null;
            int versionId = 0;
            int houseId = 0;
            SimpleDateFormat sourceFormat = new SimpleDateFormat("MM/dd/yyyy hh:mm a");
            Date date = null;
            java.sql.Date sqlDate = null;
            Timestamp scheduleTimeslot = null;
            //
            if (action != null) {
                switch (action) {
                    case "insert":
                        versionId = Integer.parseInt(request.getParameter("versionId"));
                        houseId = Integer.parseInt(request.getParameter("houseId"));
                        String dateInsert = request.getParameter("scheduleTimeslot");
                        try {
                            date = sourceFormat.parse(dateInsert);
                            scheduleTimeslot = new Timestamp(date.getTime());
                        } catch (ParseException ex) {
                            java.util.logging.Logger.getLogger(T4uRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        if (T4uScheduleDAO.insertSchedule(versionId, houseId, scheduleTimeslot) > 0) {
                            // Successfully insert
                            List<Integer> allScheduleIds = T4uScheduleDAO.getAllScheduleIds();
                            List<T4uSchedule> allSchedules = new ArrayList<T4uSchedule>();
                            for (int scheduleId: allScheduleIds)
                                allSchedules.add(T4uScheduleDAO.getScheduleById(scheduleId));
                            session.setAttribute(T4uConstants.T4uAllSchedules,allSchedules);
                            request.setAttribute("success", T4uConstants.ExScheduleSuccess);
                            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/schedules.jsp");
                            dispatcher.forward(request, response);
                        } else {
                            // Error
                            request.setAttribute("error", T4uConstants.ExScheduleError);
                            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/error.jsp");
                            dispatcher.forward(request, response);
                        }
                        break;
                    case "update":
                        int scheduleIdUpdate = Integer.parseInt(request.getParameter("scheduleIdUpdate"));
                        oSeats = T4uScheduleDAO.getOSeatsById(scheduleIdUpdate);
                        if (oSeats == null || oSeats.equals("")) {
                            // No seats occupied, allow update
                            versionId = Integer.parseInt(request.getParameter("versionId"));
                            houseId = Integer.parseInt(request.getParameter("houseId"));
                            String dateUpdate = request.getParameter("scheduleTimeslot");
                            try {
                                date = sourceFormat.parse(dateUpdate);
                                scheduleTimeslot = new Timestamp(date.getTime());
                            } catch (ParseException ex) {
                                java.util.logging.Logger.getLogger(T4uRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
                            }
                            if (T4uScheduleDAO.updateSchedule(scheduleIdUpdate, versionId, houseId, scheduleTimeslot)) {
                                // Successfully insert
                                List<Integer> allScheduleIds = T4uScheduleDAO.getAllScheduleIds();
                                List<T4uSchedule> allSchedules = new ArrayList<T4uSchedule>();
                                for (int scheduleId: allScheduleIds)
                                    allSchedules.add(T4uScheduleDAO.getScheduleById(scheduleId));
                                session.setAttribute(T4uConstants.T4uAllSchedules,allSchedules);
                                request.setAttribute("success", T4uConstants.ExScheduleSuccess);
                                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/schedules.jsp");
                                dispatcher.forward(request, response);
                            } else {
                                // Error
                                request.setAttribute("error", T4uConstants.ExScheduleError);
                                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/error.jsp");
                                dispatcher.forward(request, response);
                            }
                        } else {
                            // Not allow update
                            request.setAttribute("error", T4uConstants.ExScheduleAlreadyOccupied);
                            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/schedules.jsp");
                            dispatcher.forward(request, response);
                        }
                        break;
                    case "delete":
                        int scheduleIdDelete = Integer.parseInt(request.getParameter("scheduleIdDelete"));
                        oSeats = T4uScheduleDAO.getOSeatsById(scheduleIdDelete);
                        if (oSeats == null || oSeats.equals("")) {
                            // No seats occupied, allow delete
                            if (T4uScheduleDAO.deleteSchedule(scheduleIdDelete)) {
                                // Successfully insert
                                List<Integer> allScheduleIds = T4uScheduleDAO.getAllScheduleIds();
                                List<T4uSchedule> allSchedules = new ArrayList<T4uSchedule>();
                                for (int scheduleId: allScheduleIds)
                                    allSchedules.add(T4uScheduleDAO.getScheduleById(scheduleId));
                                session.setAttribute(T4uConstants.T4uAllSchedules,allSchedules);
                                request.setAttribute("success", T4uConstants.ExScheduleSuccess);
                                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/schedules.jsp");
                                dispatcher.forward(request, response);
                            } else {
                                // Error
                                request.setAttribute("error", T4uConstants.ExScheduleError);
                                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/error.jsp");
                                dispatcher.forward(request, response);
                            }
                        } else {
                            // Not allow update
                            request.setAttribute("error", T4uConstants.ExScheduleAlreadyOccupied);
                            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/schedules.jsp");
                            dispatcher.forward(request, response);
                        }
                        break;
                }
            }
            }else{
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/schedules.jsp");
                dispatcher.forward(request, response);
            }
            
        }
        
        
        
        
        
        
        
//        HttpSession session = request.getSession(true);
//        session.setAttribute(T4uConstants.T4uAllSchedules,allSchedules );
//        session.setAttribute(T4uConstants.T4uAllHouses, allHouses);
//        session.setAttribute(T4uConstants.T4uAllMovies, allMovies);
//        json.put("allMovies", allMovies);
//        json.put("allHouses", allHouses);
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

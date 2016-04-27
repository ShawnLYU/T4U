/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ss.Controller;

import com.ss.DAO.T4uScheduleDAO;
import com.ss.Model.T4uSchedule;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

/**
 *
 * @author mengxualv2
 */
public class T4uArrangeSeatPlanServlet extends HttpServlet {

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
        int scheduleId = 0;
        try {
            scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
            String[] allUSeats = request.getParameterValues("seats[]");
            // Check whether the seats are occupied or unavailable in table T4U_schedule
            boolean occupied = false;
            if (allUSeats != null) {
                String oSeats = T4uScheduleDAO.getOSeatsById(scheduleId);
                for (String seat: allUSeats)
                    if (oSeats.contains(seat)) {
                        occupied = true;
                        break;
                    }
            }
            if (occupied) {
                // Seat occupied, need to buy again
                PrintWriter out = response.getWriter();
                out.print("occupied");
                out.flush();
            } else {
                String uSeats = "";
                if (allUSeats != null)
                    for (String seat: allUSeats)
                        uSeats += "'" + seat + "',";
                if (T4uScheduleDAO.updateUSeatsById(scheduleId, uSeats)) {
                    response.setHeader("Content-Type", "text/plain");
                    PrintWriter out = response.getWriter();
                    out.print("success");
                    out.flush();
                }
            }
        } catch (NumberFormatException ex) {
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

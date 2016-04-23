/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Controller;

import com.ss.DAO.T4uScheduleDAO;
import com.ss.Model.T4uSchedule;
import com.ss.app.T4uConstants;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author mengxualv2
 */
public class T4uConfirmPaymentServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final Logger LOGGER = Logger.getLogger(T4uConfirmPaymentServlet.class);
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet T4uConfirmPaymentServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet T4uConfirmPaymentServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
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
//        processRequest(request, response);
        doPost(request, response);
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
//        processRequest(request, response);
//        String seats[] = (String[]) request.getAttribute("seats");
        String[] myJsonData = request.getParameterValues("seats[]");
        int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
        T4uSchedule schedule = T4uScheduleDAO.getScheduleById(scheduleId);
        List<String> seatsVar = Arrays.asList(request.getParameter("seats").split(","));  

        LOGGER.debug("Schedule id (to be paid) detail: " + scheduleId);
        
        request.setAttribute(T4uConstants.T4uScheduleToBePaid, schedule);
        request.setAttribute(T4uConstants.T4uSeats, seatsVar);
        double price = seatsVar.size() * schedule.getPrice();
        request.setAttribute(T4uConstants.T4uPriceToBePaidCash, price);
        request.setAttribute(T4uConstants.T4uPriceToBePaidPoints, price*10);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/moviePayment.jsp");
        dispatcher.forward(request, response);
        
        
        
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

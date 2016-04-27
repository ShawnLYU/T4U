/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Controller;

import com.ss.DAO.T4uScheduleDAO;
import com.ss.DAO.T4uUserDAO;
import com.ss.Model.T4uOrder;
import com.ss.Model.T4uSchedule;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author mengxualv2
 */
public class T4uAddToCartServlet extends HttpServlet {

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
        int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
        T4uOrder order = new T4uOrder();
        order.setUser(T4uUserDAO.getUserById(12));
        order.setSchedule(T4uScheduleDAO.getScheduleById(scheduleId));
        int len = request.getParameter("seats").length();
        List<String> allSeats = Arrays.asList(request.getParameter("seats").substring(1,len-1).replaceAll(" ","").split(","));
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (String s : allSeats)
        {
            sb.append(s);
            sb.append(",");
        }
        sb.append("]");
        order.setOrderSeats(sb.toString());
        order.setOrderCash(allSeats.size()*order.getSchedule().getPrice());
        HttpSession session = request.getSession(true);
        List<T4uOrder> listOfOrder;
        boolean isValid = true;
        if(session.getAttribute(T4uConstants.T4uCart)==null){
            listOfOrder = new ArrayList<T4uOrder>();
        }
        else{
            listOfOrder = (List<T4uOrder>) session.getAttribute(T4uConstants.T4uCart);
            if(listOfOrder.size()!=0 && listOfOrder.get(listOfOrder.size()-1).getOrderSeats().equals(order.getOrderSeats())){
                isValid = false;
            }
        }
        if(isValid)
            listOfOrder.add(order);
        session.setAttribute(T4uConstants.T4uCart, listOfOrder);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/cart.jsp");
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

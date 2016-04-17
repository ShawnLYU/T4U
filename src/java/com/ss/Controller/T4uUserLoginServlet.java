/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ss.Controller;

import com.ss.DAO.T4uUserDAO;
import com.ss.Model.T4uUser;
import com.ss.app.T4uConstants;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
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
public class T4uUserLoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static Logger logger = Logger.getLogger(T4uUserLoginServlet.class);  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        logger.debug("Enter User Login servlet");
        HttpSession session = request.getSession(true);
        String userAccount = request.getParameter("userAccount");
        String userPassword = request.getParameter("userPassword");
        T4uUser t4uUser = new T4uUser();
        t4uUser.setUserAccount(userAccount);
        t4uUser.setUserPassword(userPassword);
        boolean isUserValid = false;
//        if (ud.checkAccountExist(user) > 0 && ud.checkPassword(user))
//            result = true;
        if(T4uUserDAO.checkAccountExist(t4uUser) > 0){
            if(T4uUserDAO.checkPassword(t4uUser)){
                isUserValid = true;
            }else{
                request.setAttribute("error",T4uConstants.ExUserPasswordNotCorrect);
            }
        }else{
            request.setAttribute("error",T4uConstants.ExUserAccountNotExisted);
        }
        
        logger.debug("User authentication successfull or not: "+isUserValid);
        
        if(isUserValid){
            T4uUserDAO.injectT4uUserById(t4uUser);
            session.setAttribute(T4uConstants.T4uUser, t4uUser);
            logger.debug("User Account: "+t4uUser.getUserAccount());
            response.sendRedirect(request.getContextPath());
        }else{
            logger.debug("Error: "+ session.getAttribute("error"));
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login.jsp");
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
            java.util.logging.Logger.getLogger(T4uUserLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            java.util.logging.Logger.getLogger(T4uUserLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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

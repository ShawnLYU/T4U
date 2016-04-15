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
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
 * @author mengxualv2
 */
public class T4uRegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static Logger logger = Logger.getLogger(T4uRegisterServlet.class);  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet T4uRegisterServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet T4uRegisterServlet at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
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
        logger.debug("Enter register servlet with POST");
        
//        logger.debug("firstName: "+request.getParameter("firstName"));
//        logger.debug("lastName: "+request.getParameter("lastName"));
//        logger.debug("phone: "+request.getParameter("phone"));
//        logger.debug("gender: "+request.getParameter("gender"));
//        logger.debug("birthdate: "+request.getParameter("birthdate"));
//        logger.debug("userAccount: "+request.getParameter("userAccount"));
//        logger.debug("email: "+request.getParameter("email"));
//        logger.debug("password1: "+request.getParameter("password1"));
        T4uUser t4uUser = new T4uUser();
        t4uUser.setUserAccount(request.getParameter("userAccount"));
        t4uUser.setUserPassword(request.getParameter("password1"));
        t4uUser.setUserName(request.getParameter("lastName")+" "+request.getParameter("firstName"));
        String gender;
        if(request.getParameter("UserGender")=="true")
            gender = "M";
        else
            gender = "F";
        t4uUser.setUserGender(gender);
        
        SimpleDateFormat sourceFormat = new SimpleDateFormat("dd/MM/yyyy");
        Date birthdate = null;
        java.sql.Date sqlDate = null;
        try {
            birthdate = sourceFormat.parse(request.getParameter("birthdate"));
            sqlDate = new java.sql.Date(birthdate.getTime());
        } catch (ParseException ex) {
            java.util.logging.Logger.getLogger(T4uRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        t4uUser.setUserBirthdate(sqlDate);
        
        t4uUser.setUserPhone(request.getParameter("phone"));
        t4uUser.setUserEmail(request.getParameter("email"));
        t4uUser.setUserCredit(0);
        t4uUser.setUserGroup("user");
        HttpSession session = null;
        session = request.getSession(true);
        if(T4uUserDAO.checkAccountExist(t4uUser) > 0){
            logger.debug("Registration Error: "+T4uConstants.ExUserRegisterAccountExisted);
            session.setAttribute("error",T4uConstants.ExUserRegisterAccountExisted);
            response.sendRedirect(request.getContextPath()+"/error.jsp");
        }else{
            try {
                if(T4uUserDAO.createAccount(t4uUser)){
                    logger.debug("Registration Successfully: "+t4uUser.getUserAccount());
                    session.setAttribute(T4uConstants.T4uUser, t4uUser);
                    response.sendRedirect(request.getContextPath()+"/index.jsp");
                    
                }else{
                    session.setAttribute("error",T4uConstants.ExUserAccountNotExisted);
                    response.sendRedirect(request.getContextPath()+"/error.jsp");
                }  
            } catch (SQLException ex) {
                java.util.logging.Logger.getLogger(T4uRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        //processRequest(request, response);
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

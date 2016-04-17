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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author user
 */
public class T4uUserUpdateProfileServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static Logger logger = Logger.getLogger(T4uUserUpdateProfileServlet.class);  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet T4uUserUpdateProfileServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet T4uUserUpdateProfileServlet at " + request.getContextPath() + "</h1>");
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
HttpSession session = null;
        session = request.getSession(true);
        //processRequest(request, response);
        String action = request.getParameter("action").toString();
        if(action.equals("profile")){
            T4uUser t4uUser = new T4uUser();
            t4uUser.setUserAccount(request.getParameter("account"));
            t4uUser.setUserName(request.getParameter("name"));
            String gender;
            if(request.getParameter("gender")=="true")
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
                session.setAttribute("error",T4uConstants.ExUnknownError);
                response.sendRedirect(request.getContextPath()+"/error.jsp");
            }
            t4uUser.setUserBirthdate(sqlDate);

            t4uUser.setUserPhone(request.getParameter("phone"));
            t4uUser.setUserEmail(request.getParameter("email"));
            try {
                if(T4uUserDAO.updateUserProfile(t4uUser)){
                    logger.debug("Update Profile Successfully: "+t4uUser.getUserAccount());
                    T4uUserDAO.injectT4uUserByAccount(t4uUser);
                    session.setAttribute(T4uConstants.T4uUser, t4uUser);
                    response.sendRedirect(request.getContextPath()+"/profile.jsp");
                    
                }else{
                    session.setAttribute("error",T4uConstants.ExUnknownError);
                    response.sendRedirect(request.getContextPath()+"/error.jsp");
                }
            } catch (SQLException ex) {
                session.setAttribute("error",T4uConstants.ExUnknownError);
                response.sendRedirect(request.getContextPath()+"/error.jsp");
            }
            
        }
        else{
            T4uUser t4uUser = new T4uUser();
            t4uUser.setUserAccount(request.getParameter("account2"));
            t4uUser.setUserPassword(request.getParameter("newPwd"));
            try {
                if(T4uUserDAO.updateUserPassword(t4uUser)){
                    logger.debug("Update Password Successfully: "+t4uUser.getUserAccount());
                    T4uUserDAO.injectT4uUserByAccount(t4uUser);
                    session.setAttribute("error",T4uConstants.ExUserPasswordChanged);
                    session.invalidate();
                    response.sendRedirect(request.getContextPath()+"/error.jsp");
                    
                }else{
                    session.setAttribute("error",T4uConstants.ExUnknownError);
                    response.sendRedirect(request.getContextPath()+"/error.jsp");
                }
            } catch (SQLException ex) {
                session.setAttribute("error",T4uConstants.ExUnknownError);
                response.sendRedirect(request.getContextPath()+"/error.jsp");
            }
            
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

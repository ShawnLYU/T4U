/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.DAO;

import com.ss.Model.T4uCinema;
import com.ss.Utility.T4uJDBC;
import com.ss.app.T4uCinemaLocation;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author mengxualv2
 * 
 * 2016041701    SM    Implemented getAllCinemas()
 */
public class T4uCinemaDAO {
    public static Map<Integer,T4uCinema> getAllCinemas() {
        Map<Integer,T4uCinema> allCinemas=new HashMap<Integer,T4uCinema>();
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM [T4U_cinema]");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                T4uCinema cinema = new T4uCinema();
                cinema.setCinemaId(rs.getInt("CinemaId"));
                cinema.setCinemaName(rs.getNString("CinemaName"));
                cinema.setCinemaLocation(new T4uCinemaLocation(rs.getNString("CinemaLocation")));
                cinema.setCinemaPhone(rs.getNString("CinemaPhone"));
                cinema.setCinemaInfo(rs.getNString("CinemaInfo"));
                allCinemas.put(cinema.getCinemaId(), cinema);
            }
            T4uJDBC.close(rs, pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uCinemaDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return allCinemas;
    }
}

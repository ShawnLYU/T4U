/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ss.DAO;

import com.ss.Model.T4uMovie;
import com.ss.Model.T4uVersion;
import com.ss.Utility.T4uJDBC;
import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Steven Mao
 * 
 * 2016041201    SM    Implemented getting all versions.
 * 2016041501    SM    Used PreparedStatement.
 */
public class T4uVersionDAO {
    /**
    * Get all versions of specified movie.
    *
    * @param movie A Movie object.
    * @return      A list of Version objects which belong to this movie.
    */
    public static List<T4uVersion> getAllVersions(T4uMovie movie) {
        int movieId = movie.getMovieId();
        List<T4uVersion> allVersions=new ArrayList<T4uVersion>();
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM [T4U_version] WHERE [MovieId]= ?");
            pstmt.setInt(1, movieId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                T4uVersion version = new T4uVersion();
                version.setVersionId(rs.getInt("VersionId"));
                version.setMovieId(rs.getInt("MovieId"));
                version.setVersionName(rs.getNString("VersionName"));
                version.setVersionBasePrice(rs.getDouble("VersionBasePrice"));
                allVersions.add(version);
            }
            T4uJDBC.close(rs, pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uMovieDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uMovieDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return allVersions;
    }
}

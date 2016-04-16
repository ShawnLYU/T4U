/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.DAO;

import com.ss.Model.T4uMovie;
import com.ss.Utility.T4uJDBC;
import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author mengxualv2
 * 
 * 2016041201    SM    Implemented getting all movies and all versions for a movie.
 * 2016041501    SM    Used PreparedStatement.
 */
public class T4uMovieDAO {
    /**
    * Get all movies.
    *
    * @return      A list of Movie objects.
    */
    public static List<T4uMovie> getAllMovies() {
        List<T4uMovie> allMovies=new ArrayList<T4uMovie>();
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM [T4U_movie]");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                T4uMovie movie = new T4uMovie();
                movie.setMovieId(rs.getInt("MovieId"));
                movie.setMovieName(rs.getNString("MovieName"));
                movie.setMovieDescription(rs.getNString("MovieDescription"));
                movie.setMovieInfo(rs.getNString("MovieInfo"));
                movie.setAllVersions(T4uVersionDAO.getAllVersions(movie));
                allMovies.add(movie);
            }
            T4uJDBC.close(rs, pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uMovieDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uMovieDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return allMovies;
    }
}

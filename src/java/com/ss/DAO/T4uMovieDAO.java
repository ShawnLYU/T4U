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
 */
public class T4uMovieDAO {
    /**
    * Get all movies.
    *
    * @return      A list of Movie objects.
    */
//    public List<T4uMovie> getAllMovies() {
//        List<T4uMovie> allMovies=new ArrayList<T4uMovie>();
//        try {
//            T4uJDBC db = new T4uJDBC();
//            String sql = "SELECT * FROM [T4U_movie]";
//            ResultSet rs = db.query(sql);
//            while (rs.next()) {
//                T4uMovie movie = new T4uMovie();
//                movie.setMovieId(rs.getInt("MovieId"));
//                movie.setMovieName(rs.getNString("MovieName"));
//                movie.setMovieDescription(rs.getNString("MovieDescription"));
//                movie.setMovieInfo(rs.getNString("MovieInfo"));
//                allMovies.add(movie);
//            }
//            db.close(rs);
//        } catch (SQLException ex) {
//            Logger.getLogger(T4uMovieDAO.class.getName()).log(Level.SEVERE, null, ex);
//        } catch (Exception ex) {
//            Logger.getLogger(T4uMovieDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return allMovies;
//    }
    
    /**
    * Set all versions of specified movie.
    *
    * @param movie A Movie object.
    */
//    public void setAllVersions(T4uMovie movie) {
//        T4uVersionDAO vd = new T4uVersionDAO();
//        movie.setAllVersions(vd.getAllVersions(movie));
//    }
}

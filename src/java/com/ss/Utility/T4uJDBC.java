/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Utility;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Steven Mao
 * 
 * 2016040901    SM    Implemented JDBC connection
 */
public class T4uJDBC {
    private static final String DBURL = "jdbc:sqlserver://w2ksa.cs.cityu.edu.hk:1433;databaseName=aiad049_db;";
    private static final String DBUSER = "aiad049";
    private static final String DBPWD = "aiad049";
    // Close JDBC connection
    public static Connection connect() throws SQLException {
        Connection conn = null;
        try {
//            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(DBURL, DBUSER, DBPWD);//no need anymore since JDBC API 4.0
        } catch (SQLException ex) {
            Logger.getLogger(T4uJDBC.class.getName()).log(Level.SEVERE, null, ex);
            System.err.println("Cannot connect to database:\n" + ex.getMessage());
        }
        return conn;
    }
    
    // Close JDBC connection


    public static void close(ResultSet rs, PreparedStatement statement, Connection conn) throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (statement != null) {
            statement.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
    
}

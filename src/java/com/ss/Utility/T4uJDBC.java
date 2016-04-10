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
    private static Connection conn;
    private static Statement stmt;
    // Establish JDBC connection
    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(DBURL, DBUSER, DBPWD);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(T4uJDBC.class.getName()).log(Level.SEVERE, null, ex);
            System.err.println("JDBC library not found:\n" + ex.getMessage());
        } catch (SQLException ex) {
            Logger.getLogger(T4uJDBC.class.getName()).log(Level.SEVERE, null, ex);
            System.err.println("Cannot connect to database:\n" + ex.getMessage());
        }
    }
    
    public Connection getConn() {
        return conn;
    }
    
    // SELECT
    public ResultSet query(String sql) {   
        ResultSet rs = null;
        try {
            if (conn == null || conn.isClosed())
                conn = DriverManager.getConnection(DBURL, DBUSER, DBPWD);
            stmt = conn.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE, java.sql.ResultSet.CONCUR_READ_ONLY);
            rs = stmt.executeQuery(sql);
        } catch (SQLException ex) {
            Logger.getLogger(T4uJDBC.class.getName()).log(Level.SEVERE, null, ex);
            System.err.println("Database READ operation failed:\n" + ex.getMessage());
        }
        return rs; 
    }
    
    // INSERT, UPDATE, DELETE
    public int alert(String sql) {
        int rows = 0;
        try {
            if (conn == null || conn.isClosed())
                conn = DriverManager.getConnection(DBURL, DBUSER, DBPWD);
            stmt = conn.createStatement();
            rows = stmt.executeUpdate(sql);
        } catch(SQLException ex) {     
            Logger.getLogger(T4uJDBC.class.getName()).log(Level.SEVERE, null, ex);
            System.err.println("Database WRITE operation failed:\n" + ex.getMessage());
        }
        return rows;
    }
    
    // Close JDBC connection
    public void close() throws SQLException {
        if (stmt != null) {
            stmt.close();
        }
        if (conn != null) {
            conn.close();
            conn = null;
        }
    }
    
    public void close(ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            close();
        } catch(SQLException ex) {     
            Logger.getLogger(T4uJDBC.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}

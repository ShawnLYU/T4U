/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.app;

/**
 *
 * @author mengxualv2
 */
public class T4uConstants {
    //exceptions to be shown in error page
    public static String ExUnknownError = "error.unknown";
    public static String ExUserAccountNotExisted = "error.login.e1";
    public static String ExUserPasswordNotCorrect = "error.login.e2";
    public static String ExUserRegisterAccountExisted = "error.register.e1";
    public static String ExUserPasswordChanged = "error.update.e1";
    //key of attributes to be shown in jsp pages
    public static String T4uUser = "t4uUser";

    public static final String T4U_ALLMOVIES = "t4uAllMovies";
    public static final String T4U_CURMOVIE = "t4uCurMovie";
    public static final String T4U_ALLVERSIONS = "t4uAllVersions";
    public static final String T4U_SELSCHEDULES = "t4uSelSchedules";   
    
    
    //configuration
    public static final String DBURL = "jdbc:sqlserver://w2ksa.cs.cityu.edu.hk:1433;databaseName=aiad049_db;";
    public static final String DBUSER = "aiad049";
    public static final String DBPWD = "aiad049";
 

}
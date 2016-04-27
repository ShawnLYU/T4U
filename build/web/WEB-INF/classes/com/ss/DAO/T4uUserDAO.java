/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.DAO;

import com.ss.Controller.T4uRegisterServlet;
import com.ss.Model.T4uUser;
import com.ss.Utility.T4uJDBC;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Steven Mao
 * 
 * 2016041001    SM    Implemented account creation and verification.
 */
public class T4uUserDAO {
    /**
    * Check whether the account exists.
    *
    * @param  user User Model.
    * @return      Return userId if the account exists, or 0 if not.
    */
    private static org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(T4uUserDAO.class);  
    public static int checkAccountExist(T4uUser user) {
        int userId = -1;
        String userAccount = user.getUserAccount();
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement statement = conn.prepareStatement("select * from dbo.T4U_user where UserAccount = ? ");
            statement.setString(1,user.getUserAccount());
            ResultSet rs = statement.executeQuery();
            if (rs.next())
                userId = rs.getInt(1);
            T4uJDBC.close(rs, statement, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uUserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uUserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        user.setUserId(userId);
        return userId;
    }
    /**
    * Check whether password is correct.
    *
    * @param  user User Model.
    * @return      Return TRUE if password is correct.
    */
    public static boolean checkPassword(T4uUser user) {
        int userId = user.getUserId();
        String userInputPassword = user.getUserPassword();
        String userStoredPassword = null;
        if (userInputPassword != null && !userInputPassword.equals("")) {
            try {
                Connection conn =  T4uJDBC.connect();
                PreparedStatement statement = conn.prepareStatement("select userpassword from dbo.T4U_user where userid = ?");
                statement.setInt(1, userId);
                ResultSet rs = statement.executeQuery();
                if (rs != null && rs.next())
                    userStoredPassword = rs.getString(1);
                T4uJDBC.close(rs, statement, conn);
            } catch (SQLException ex) {
                Logger.getLogger(T4uUserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
            return userInputPassword.equals(userStoredPassword);
        } else
            return false;
    }
    
    /**
    * Create an account.
    *
    * @param  user User Model.
    * @return      Return userId if the account is successfully created, or 0 if not.
    */
    public static boolean createAccount(T4uUser user) throws SQLException {
        Connection conn =  T4uJDBC.connect();
        PreparedStatement statement = conn.prepareStatement("insert into dbo.T4U_user (UserAccount, UserPassword, UserName, UserGender, UserBirthdate, UserPhone, UserEmail, UserCredit, UserGroup) values(?,?,?,?, ?, ?, ?, ?, ?)");
        statement.setString(1, user.getUserAccount());
        statement.setString(2, user.getUserPassword());
        statement.setString(3, user.getUserName());
        statement.setString(4, user.getUserGender());
        statement.setDate(5, user.getUserBirthdate());
        statement.setString(6, user.getUserPhone());
        statement.setString(7, user.getUserEmail());
        statement.setInt(8, user.getUserCredit());
        statement.setString(9, user.getUserGroup());
        
        int rows = statement.executeUpdate();
        if(rows>0){
            //select top 1 * from dbo.T4U_user order by userid desc
            statement = conn.prepareStatement("select top 1 * from dbo.T4U_user order by userid desc");
            ResultSet rs = statement.executeQuery();
            if (rs != null && rs.next())
                user.setUserId(rs.getInt(1));
            return true;
        }else
            return false;
        
    }

    public static void injectT4uUserById(T4uUser t4uUser) throws SQLException {//assume user exists
        Connection conn =  T4uJDBC.connect();
        PreparedStatement statement = conn.prepareStatement("select * from dbo.T4U_user where userid = ?");
        statement.setInt(1, t4uUser.getUserId());
        ResultSet rs = statement.executeQuery();
        if (rs != null && rs.next()){
            t4uUser.setUserAccount(rs.getString("UserAccount"));
            t4uUser.setUserPassword(rs.getString("UserPassword"));
            t4uUser.setUserName(rs.getString("UserName"));
            t4uUser.setUserGender(rs.getString("UserGender"));
            Date birthdate = null;
            birthdate = rs.getDate("UserBirthDate");
            t4uUser.setUserBirthdate(birthdate);
            t4uUser.setUserPhone(rs.getString("UserPhone"));
            t4uUser.setUserEmail(rs.getString("UserEmail"));
            t4uUser.setUserCredit(rs.getInt("UserCredit"));
            t4uUser.setUserGroup(rs.getString("UserGroup"));
        }
        T4uJDBC.close(rs, statement, conn);
        
    }

    public static boolean updateUserProfile(T4uUser user) throws SQLException {
        Connection conn =  T4uJDBC.connect();
        PreparedStatement statement = conn.prepareStatement(
                "update dbo.T4U_user"+
                " set UserName = ? ,"+
                " UserGender = ? ,"+
                " UserBirthdate = ? ,"+
                " UserPhone = ? ,"+
                " UserEmail = ?"+
                " where useraccount = ?");
        statement.setString(1, user.getUserName());
        statement.setString(2, user.getUserGender());
        statement.setDate(3, user.getUserBirthdate());
        statement.setString(4, user.getUserPhone());
        statement.setString(5, user.getUserEmail());
        statement.setString(6, user.getUserAccount());
        
        int rows = statement.executeUpdate();
        if(rows>0)
            return true;
        else
            return false;
    }

    public static boolean updateUserPassword(T4uUser user) throws SQLException {
        Connection conn =  T4uJDBC.connect();
        PreparedStatement statement = conn.prepareStatement(
                "update dbo.T4U_user"+
                " set userpassword = ?"+
                " where useraccount = ?");
        statement.setString(1, user.getUserPassword());
        statement.setString(2, user.getUserAccount());
        
        int rows = statement.executeUpdate();
        if(rows>0)
            return true;
        else
            return false;
    }
    
    public static void injectT4uUserByAccount(T4uUser t4uUser) throws SQLException {//assume user exists
        Connection conn =  T4uJDBC.connect();
        PreparedStatement statement = conn.prepareStatement("select * from dbo.T4U_user where useraccount = ?");
        statement.setString(1, t4uUser.getUserAccount());
        ResultSet rs = statement.executeQuery();
        if (rs != null && rs.next()){
            t4uUser.setUserId(rs.getInt("UserId"));
            t4uUser.setUserAccount(rs.getString("UserAccount"));
            t4uUser.setUserPassword(rs.getString("UserPassword"));
            t4uUser.setUserName(rs.getString("UserName"));
            t4uUser.setUserGender(rs.getString("UserGender"));
            Date birthdate = null;
            birthdate = rs.getDate("UserBirthDate");
            t4uUser.setUserBirthdate(birthdate);
            t4uUser.setUserPhone(rs.getString("UserPhone"));
            t4uUser.setUserEmail(rs.getString("UserEmail"));
            t4uUser.setUserCredit(rs.getInt("UserCredit"));
            t4uUser.setUserGroup(rs.getString("UserGroup"));
        }
        T4uJDBC.close(rs, statement, conn);
    }
    
    public static boolean deductUserCredit(int userId, int newCredit) {
        boolean success = false;
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("UPDATE [T4U_user] SET [UserCredit] = ? WHERE [UserId] = ?");
            pstmt.setInt(1, newCredit);
            pstmt.setInt(2, userId);
            int rows = pstmt.executeUpdate();
            success = rows > 0;
            T4uJDBC.close(pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return success;
    }
    
    public static T4uUser getUserById(int userId) {
        T4uUser user = null;
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM [T4U_user] WHERE [UserId] = ?");
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs != null && rs.next()){
                user = new T4uUser();
                user.setUserId(userId);
                user.setUserAccount(rs.getNString("UserAccount"));
                user.setUserPassword(rs.getNString("UserPassword"));
                user.setUserName(rs.getNString("UserName"));
                user.setUserGender(rs.getNString("UserGender"));
                Date birthdate = rs.getDate("UserBirthdate");
                user.setUserBirthdate(birthdate);
                user.setUserPhone(rs.getNString("UserPhone"));
                user.setUserEmail(rs.getNString("UserEmail"));
                user.setUserCredit(rs.getInt("UserCredit"));
                user.setUserGroup(rs.getNString("UserGroup"));
            }
            T4uJDBC.close(rs, pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }
}

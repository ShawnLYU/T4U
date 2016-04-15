/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.DAO;

import com.ss.Model.T4uUser;
import com.ss.Utility.T4uJDBC;
import com.ss.app.T4uUserGroup;
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
        statement.setString(9, user.getUserGroup().toString());
        
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

    public static void injectT4uUser(T4uUser t4uUser) throws SQLException {//assume user exists
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
            T4uUserGroup t4uUserGroup = new T4uUserGroup();
            t4uUserGroup.setGroupName(rs.getString("UserGroup"));
            t4uUser.setUserGroup(t4uUserGroup);
        }
        T4uJDBC.close(rs, statement, conn);
        
    }
}

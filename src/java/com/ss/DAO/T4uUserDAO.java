/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.DAO;

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
    public int checkAccountExist(T4uUser user) {
        int userId = 0;
        String userAccount = user.getUserAccount();
        try {
            T4uJDBC db = new T4uJDBC();
            String sql = "SELECT [UserId] FROM [T4U_user] WHERE [UserAccount]=" + userAccount;
            ResultSet rs = db.query(sql);
            if (rs.next())
                userId = rs.getInt(1);
            db.close(rs);
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
    public boolean checkPassword(T4uUser user) {
        int userId = user.getUserId();
        String userInputPassword = user.getUserPassword();
        String userStoredPassword = null;
        if (userInputPassword != null && !userInputPassword.equals("")) {
            try {
                T4uJDBC db = new T4uJDBC();
                String sql = "SELECT [UserPassword] FROM [T4U_user] WHERE [UserId]=" + userId;
                ResultSet rs = db.query(sql);
                if (rs != null && rs.next())
                    userStoredPassword = rs.getString(1);
                db.close(rs);
            } catch (SQLException ex) {
                Logger.getLogger(T4uUserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
            return userInputPassword.equals(userStoredPassword);
        } else
            return false;
    }
    
    public int createAccount(T4uUser user) {
        int userId = 0;
        String userAccount = user.getUserAccount().replace("'", "''");
        String userPassword = user.getUserPassword();
        String userName = user.getUserName().replace("'", "''");
        String userGender = user.getUserGender();
        Date userBirthdate = user.getUserBirthdate();
        String userPhone = user.getUserPhone();
        String userEmail = user.getUserEmail().replace("'", "''");
        int userCredit = 0;
        String userGroup = "user;";
        // Create account
        if ((userAccount != null && !userAccount.equals(""))
                && (userPassword != null && !userPassword.equals(""))
                && (userName != null && !userName.equals(""))
                && (userGender != null && !userGender.equals(""))
                && (userPhone != null && !userPhone.equals(""))
                && (userEmail != null && !userEmail.equals(""))) {
            try {
                T4uJDBC db = new T4uJDBC();
                String sql = "INSERT INTO [T4U_user] ("
                        + "[UserAccount], "
                        + "[UserPassword], "
                        + "[UserName], "
                        + "[UserGender], "
                        + "[UserBirthdate], "
                        + "[UserPhone], "
                        + "[UserEmail], "
                        + "[UserCredit], "
                        + "[UserGroup]"
                        + ") VALUES ("
                        + userAccount + ", " 
                        + userPassword + ", "
                        + userName + ", "
                        + userGender + ", "
                        + userBirthdate + ", "
                        + userPhone + ", "
                        + userEmail + ", "
                        + userCredit + ", "
                        + userGroup + ")";
                int rows = db.alert(sql);
                if (rows > 0) {
                    ResultSet rs = db.query("SELECT @@IDENTITY AS [@@IDENTITY]");
                    if (rs != null && rs.next())
                        userId = rs.getInt(1);
                }
                db.close();
            } catch (SQLException ex) {
                Logger.getLogger(T4uUserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        user.setUserId(userId);
        return userId;
    }
}

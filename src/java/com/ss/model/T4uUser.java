/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.model;

import com.ss.app.T4uUserGroup;
import java.util.Date;

/**
 *
 * @author mengxualv2
 */
public class T4uUser {
    private int userId;
    private String userName;
    private String gender;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }
    private Date birthDate;
    private String userEmail;
    private String userPhone;
    private int credit;
    private T4uUserGroup t4uUserGroup;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return userName;
    }

    public void setName(String userName) {
        this.userName = userName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getEmail() {
        return userEmail;
    }

    public void setEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getPhone() {
        return userPhone;
    }

    public void setPhone(String phone) {
        this.userPhone = userPhone;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }

    public T4uUserGroup getT4uUserGroup() {
        return t4uUserGroup;
    }

    public void setT4uUserGroup(T4uUserGroup t4uUserGroup) {
        this.t4uUserGroup = t4uUserGroup;
    }
}

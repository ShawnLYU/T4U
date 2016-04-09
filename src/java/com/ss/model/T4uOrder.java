/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Model;

/**
 *
 * @author mengxualv2
 */
public class T4uOrder {
    private int orderId;
    private int userId;
    private T4uUser t4uUser;
    private int scheduleId;
    private T4uSchedule t4uSchedule;

    public int getOrderId() {
        return orderId;
    }

    public T4uUser getT4uUser() {
        return t4uUser;
    }

    public void setT4uUser(T4uUser t4uUser) {
        this.t4uUser = t4uUser;
    }

    public T4uSchedule getT4uSchedule() {
        return t4uSchedule;
    }

    public void setT4uSchedule(T4uSchedule t4uSchedule) {
        this.t4uSchedule = t4uSchedule;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }
}

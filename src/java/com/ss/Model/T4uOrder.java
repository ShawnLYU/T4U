/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Model;


import java.sql.Timestamp;

/**
 *
 * @author mengxualv2
 */
public class T4uOrder {

    private Timestamp orderId;
    private T4uUser user;
    private T4uSchedule schedule;
    private String orderSeats;
    private int orderStatus;
    private double orderCash;
    private int orderCredit;

    public Timestamp getOrderId() {
        return this.orderId;
    }
    
    public void setOrderId(Timestamp orderId) {
        this.orderId = orderId;
    }
    public T4uUser getUser() {
        return this.user;
    }


    public void setUser(T4uUser user) {
        this.user = user;
    }
    
    public T4uSchedule getSchedule() {
        return this.schedule;
    }

    public void setSchedule(T4uSchedule schedule) {
        this.schedule = schedule;
    }
    
    public String getOrderSeats(){
        return this.orderSeats;
    }
    
    public void setOrderSeats(String orderSeats) {
        this.orderSeats = orderSeats;
    }
    
    public int getOrderStatus() {
        return this.orderStatus;
    }

    public void setOrderStatus(int orderStatus) {
        this.orderStatus = orderStatus;
    }
    
    public double getOrderCash() {
        return this.orderCash;
    }
    
    public void setOrderCash(double orderCash) {
        this.orderCash = orderCash;
    }
    
    public int getOrderCredit() {
        return this.orderCredit;
    }
    
    public void setOrderCredit(int orderCredit) {
        this.orderCredit = orderCredit;
    }

}

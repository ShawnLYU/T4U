/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Model;

import com.ss.app.OrderStatus;

/**
 *
 * @author mengxualv2
 */
public class T4uOrder {
    private int orderId;
    private T4uUser t4uUser;
    private T4uSchedule t4uSchedule;
    private OrderStatus orderStatus;
    private boolean isRefundable;

    public boolean isIsRefundable() {
        return isRefundable;
    }

    public void setIsRefundable(boolean isRefundable) {
        this.isRefundable = isRefundable;
    }
    public int getOrderId() {
        return orderId;
    }

    public OrderStatus getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(OrderStatus orderStatus) {
        this.orderStatus = orderStatus;
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
}

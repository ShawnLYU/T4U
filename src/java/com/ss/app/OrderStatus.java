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
public enum OrderStatus {
    PAID(1), 
    PENDING(2),
    REFUNDED(3);
    private int statusCode;

    public int getStatusCode() {
        return statusCode;
    }
    OrderStatus(int sc) {
        statusCode = sc;
    }

    @Override
    public String toString(){
        return "(Status " +  statusCode + ")"; 
    }
    
    
}

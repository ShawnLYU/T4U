/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Model;

import com.ss.app.T4uSeatPlan;
import java.util.Map;

/**
 *
 * @author mengxualv2
 * 
 * 2016041601    SM    Refactor codes
 */
public class T4uHouse {
    private int houseId;
    private String houseName;
    private T4uCinema cinema;
    private T4uSeatPlan housePlan;
    
    public int getHouseId() {
        return this.houseId;
    }

    public void setHouseId(int houseId) {
        this.houseId = houseId;
    }
    
    public String getHouseName() {
        return this.houseName;
    }

    public void setHouseName(String houseName) {
        this.houseName = houseName;
    }
    

    public T4uCinema getCinema() {
        return this.cinema;
    }

    public void setCinema(T4uCinema cinema) {
        this.cinema = cinema;
    }

    public T4uSeatPlan getHousePlan() {
        return this.housePlan;
    }

    public void setHousePlan(T4uSeatPlan housePlan) {
        this.housePlan = housePlan;
    }
    
}

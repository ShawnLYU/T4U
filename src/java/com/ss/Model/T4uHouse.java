/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Model;

import com.ss.app.T4uSeatPlan;

/**
 *
 * @author mengxualv2
 */
public class T4uHouse {
    private int houseId;
    private int cinemaId;

    public T4uCinema getT4uCinema() {
        return t4uCinema;
    }

    public void setT4uCinema(T4uCinema t4uCinema) {
        this.t4uCinema = t4uCinema;
    }
    private T4uCinema t4uCinema;
    private String houseName;
    private T4uSeatPlan t4uSeatPlan;

    public int getHouseId() {
        return houseId;
    }

    public void setHouseId(int houseId) {
        this.houseId = houseId;
    }

    public int getCinemaId() {
        return cinemaId;
    }

    public void setCinemaId(int cinemaId) {
        this.cinemaId = cinemaId;
    }

    public String getHouseName() {
        return houseName;
    }

    public void setHouseName(String houseName) {
        this.houseName = houseName;
    }

    public T4uSeatPlan getT4uSeatPlan() {
        return t4uSeatPlan;
    }

    public void setT4uSeatPlan(T4uSeatPlan t4uSeatPlan) {
        this.t4uSeatPlan = t4uSeatPlan;
    }
    
}

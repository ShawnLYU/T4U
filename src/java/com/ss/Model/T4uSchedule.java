/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Model;

import com.ss.app.T4uMovieSlot;
import java.sql.Timestamp;

/**
 *
 * @author mengxualv2
 * 
* 2016041601    SM    Refactor codes
 */
public class T4uSchedule {
    private int scheduleId;
    private T4uVersion version;
    private T4uHouse house;
    private Timestamp scheduleTimeslot;
    private String scheduleOSeats;
    private double price;

    public int getScheduleId() {
        return this.scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public T4uVersion getVersion() {
        return this.version;
    }

    public void setVersion(T4uVersion version) {
        this.version = version;
    }

    public T4uHouse getHouse() {
        return this.house;
    }

    public void setHouse(T4uHouse house) {
        this.house = house;
    }

    public Timestamp getScheduleTimeslot() {
        return this.scheduleTimeslot;
    }

    public void setScheduleTimeslot(Timestamp scheduleTimeslot) {
        this.scheduleTimeslot = scheduleTimeslot;
    }

    public double getPrice() {
        return this.price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
}

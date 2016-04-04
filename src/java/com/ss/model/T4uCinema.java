/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.model;

import com.ss.app.T4uCinemaLocation;

/**
 *
 * @author mengxualv2
 */
public class T4uCinema {
    private int cinemaId;
    private String cinemaName;

    public int getCinemaId() {
        return cinemaId;
    }

    public void setCinemaId(int cinemaId) {
        this.cinemaId = cinemaId;
    }

    public String getCinemaName() {
        return cinemaName;
    }

    public void setCinemaName(String cinemaName) {
        this.cinemaName = cinemaName;
    }

    public T4uCinemaLocation getT4uCinemaLocation() {
        return t4uCinemaLocation;
    }

    public void setT4uCinemaLocation(T4uCinemaLocation t4uCinemaLocation) {
        this.t4uCinemaLocation = t4uCinemaLocation;
    }

    public String getHousePhone() {
        return housePhone;
    }

    public void setHousePhone(String housePhone) {
        this.housePhone = housePhone;
    }
    private T4uCinemaLocation t4uCinemaLocation;
    private String housePhone;
}

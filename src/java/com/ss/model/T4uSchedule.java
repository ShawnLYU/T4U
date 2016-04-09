/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Model;

import com.ss.app.T4uMovieSlot;

/**
 *
 * @author mengxualv2
 */
public class T4uSchedule {
    private int scheduleId;
    private int movieId;

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public T4uMovie getT4uMovie() {
        return t4uMovie;
    }

    public void setT4uMovie(T4uMovie t4uMovie) {
        this.t4uMovie = t4uMovie;
    }

    public int getHouseId() {
        return houseId;
    }

    public void setHouseId(int houseId) {
        this.houseId = houseId;
    }

    public T4uHouse getT4uHouse() {
        return t4uHouse;
    }

    public void setT4uHouse(T4uHouse t4uHouse) {
        this.t4uHouse = t4uHouse;
    }

    public T4uMovieSlot getT4uMovieSlot() {
        return t4uMovieSlot;
    }

    public void setT4uMovieSlot(T4uMovieSlot t4uMovieSlot) {
        this.t4uMovieSlot = t4uMovieSlot;
    }

    public int getMoviePrice() {
        return moviePrice;
    }

    public void setMoviePrice(int moviePrice) {
        this.moviePrice = moviePrice;
    }
    private T4uMovie t4uMovie;
    private int houseId;
    private T4uHouse t4uHouse;
    private T4uMovieSlot t4uMovieSlot;
    private int moviePrice;
    
}

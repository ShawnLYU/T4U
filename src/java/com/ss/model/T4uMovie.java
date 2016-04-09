/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Model;

import com.ss.app.T4uMovieType;

/**
 *
 * @author mengxualv2
 */
public class T4uMovie {
    private int movieId;
    private String movieName;
    private T4uMovieType t4uMovieType;
    private int basicMoviePrice;

    public int getBasicMoviePrice() {
        return basicMoviePrice;
    }

    public void setBasicMoviePrice(int basicMoviePrice) {
        this.basicMoviePrice = basicMoviePrice;
    }

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public T4uMovieType getT4uMovieType() {
        return t4uMovieType;
    }

    public void setT4uMovieType(T4uMovieType t4uMovieType) {
        this.t4uMovieType = t4uMovieType;
    }
    
}

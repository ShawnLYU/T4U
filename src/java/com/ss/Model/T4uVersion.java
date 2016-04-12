/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ss.Model;

/**
 *
 * @author Steven Mao
 * 
 * 2016041201    SM    Rebuild Movie and Version Model
 */
public class T4uVersion {
    private int versionId;
    private int movieId;
    private String versionName;
    private double versionBasePrice;
    
    public int getVersionId() {
        return this.versionId;
    }

    public void setVersionId(int versionId) {
        this.versionId = versionId;
    }

    public int getMovieId() {
        return this.movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public String getVersionName() {
        return this.versionName;
    }

    public void setVersionName(String versionName) {
        this.versionName = versionName;
    }

    public double getVersionBasePrice() {
        return this.versionBasePrice;
    }

    public void setVersionBasePrice(double versionBasePrice) {
        this.versionBasePrice = versionBasePrice;
    }
    
}

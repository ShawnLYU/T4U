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
 * 2016041701    SM    Change movieId to movie object
 */
public class T4uVersion {
    private int versionId;
    private T4uMovie movie;
    private String versionName;
    private double versionBasePrice;
    
    public int getVersionId() {
        return this.versionId;
    }

    public void setVersionId(int versionId) {
        this.versionId = versionId;
    }

    public T4uMovie getMovie() {
        return this.movie;
    }

    public void setMovie(T4uMovie movie) {
        this.movie = movie;
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Model;

import com.ss.app.T4uCinemaLocation;
import com.ss.Utility.T4uJson2Map;
import java.util.Map;
import org.json.JSONObject;

/**
 *
 * @author mengxualv2
 * 
 * 2016040901    SM    Add cinemaInfo field
 * 2016041201    SM    Use generic Map type as default variable type
 * 2016041701    SM    Refactor codes
 */
public class T4uCinema {
    private int cinemaId;
    private String cinemaName;
    private T4uCinemaLocation cinemaLocation;

    public void setCinemaInfo(Map<String, String> cinemaInfo) {
        this.cinemaInfo = cinemaInfo;
    }

    public T4uCinemaLocation getCinemaLocation() {
        return cinemaLocation;
    }
    private String cinemaPhone;
    private Map<String, String> cinemaInfo;

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
        return cinemaLocation;
    }

    public void setCinemaLocation(T4uCinemaLocation cinemaLocation) {
        this.cinemaLocation = cinemaLocation;
    }

    public String getCinemaPhone() {
        return cinemaPhone;
    }

    public void setCinemaPhone(String cinemaPhone) {
        this.cinemaPhone = cinemaPhone;
    }
    
    public Map<String, String> getCinemaInfo() {
        return this.cinemaInfo;
    }
    
    public void setCinemaInfo(String strCinemaInfo) {
        this.cinemaInfo=T4uJson2Map.jsonToMap(new JSONObject(strCinemaInfo));
    }
    
}

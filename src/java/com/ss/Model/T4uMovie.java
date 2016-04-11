/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Model;

import com.ss.Utility.T4uJson2Map;
import java.util.HashMap;
import org.json.JSONObject;

/**
 *
 * @author mengxualv2
 * 
 * 2016040901    SM    Refactor codes
 */
public class T4uMovie {
    private int movieId;
    private String movieName;
    private String movieType;
    private int movieBasePrice;
    private HashMap<String, String> movieDescription;
    
    public int getMovieId() {
        return this.movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }
    
    public String getMovieName() {
        return this.movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }
    
    public String getMovieType() {
        return this.movieType;
    }

    public void setMovieType(String movieType) {
        this.movieType = movieType;
    }
    
    public int getMovieBasePrice() {
        return this.movieBasePrice;
    }

    public void setMovieBasePrice(int movieBasePrice) {
        this.movieBasePrice = movieBasePrice;
    }
    
    public HashMap<String, String> getMovieDescription() {
        return this.movieDescription;
    }
    
    public void setMovieDescription(String strMovieDescription) {
        this.movieDescription=T4uJson2Map.jsonToMap(new JSONObject(strMovieDescription));
    }

}

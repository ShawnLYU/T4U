/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Model;

import com.ss.Utility.T4uJson2Map;
import java.util.*;
import org.json.JSONObject;

/**
 *
 * @author mengxualv2
 * 
 * 2016040901    SM    Refactor codes
 * 2016041201    SM    Rebuild Movie and Version Model
 */
public class T4uMovie {
    private int movieId;
    private String movieName;
    private String movieDescription;
    private Map<String, String> movieInfo;
    private List<T4uVersion> allVersions;
    
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
    
    public String getMovieDescription() {
        return this.movieDescription;
    }

    public void setMovieDescription(String movieDescription) {
        this.movieDescription = movieDescription;
    }
    
    public Map<String, String> getMovieInfo() {
        return this.movieInfo;
    }
    
    public void setMovieInfo(String strMovieInfo) {
        this.movieInfo=T4uJson2Map.jsonToMap(new JSONObject(strMovieInfo));
    }

    public List<T4uVersion> getAllVersions() {
        return this.allVersions;
    }

    public void setAllVersions(List<T4uVersion> allVersions) {
        this.allVersions = allVersions;
    }

}
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.app;

/**
 *
 * @author Steven
 * 
 * 20160417    SM    Implement the constructor
 */
public class T4uCinemaLocation {
    private String region = "";

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getBuilding() {
        return building;
    }

    public void setBuilding(String building) {
        this.building = building;
    }
    private String district = "";
    private String street = "";
    private String building = "";
    
    public T4uCinemaLocation(String address) {
        String[] segments = address.split(",");
        try {
            this.region = segments[segments.length - 1];
            this.district = segments[segments.length - 2];
            this.street = segments[segments.length - 3];
            this.building = segments[segments.length - 4];
        } catch (IndexOutOfBoundsException ex) {
        }
    }
}

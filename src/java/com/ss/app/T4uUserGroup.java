/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.app;

/**
 *
 * @author mengxualv2
 */
public class T4uUserGroup {
    private String groupName;

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }
    @Override
    public String toString(){
        return this.groupName;
    }
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.DAO;

import com.ss.Model.T4uCinema;
import com.ss.Model.T4uHouse;
import com.ss.Utility.T4uJDBC;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author mengxualv2
 */
public class T4uHouseDAO {
    public static Map<Integer,T4uHouse> getAllHouses() {
        Map<Integer, T4uCinema> allCinemas = T4uCinemaDAO.getAllCinemas();
        Map<Integer, T4uHouse> allHouses=new HashMap<Integer, T4uHouse>();
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM [T4U_house]");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                T4uHouse house = new T4uHouse();
                int houseId = rs.getInt("HouseId");
                house.setHouseId(houseId);
                house.setHouseName(rs.getNString("HouseName"));
                house.setCinema(allCinemas.get(rs.getInt("CinemaId")));
                house.setHousePlan(rs.getNString("HousePlan"));
                allHouses.put(houseId, house);
            }
            T4uJDBC.close(rs, pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uHouseDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uHouseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return allHouses;
    }
}

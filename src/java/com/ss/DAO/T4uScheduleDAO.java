/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.DAO;

import com.ss.Model.T4uHouse;
import com.ss.Model.T4uSchedule;
import com.ss.Model.T4uVersion;
import com.ss.Utility.T4uJDBC;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author mengxualv2
 */
public class T4uScheduleDAO {

    public static void getScheduleForVersion(T4uVersion version, Map<Integer, T4uHouse> allHouses, Map<Integer, T4uSchedule> allSchedules) {
        int versionId = version.getVersionId();
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM [T4U_schedule] WHERE [versionId]= ? ");
            pstmt.setInt(1, versionId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                T4uSchedule schedule = new T4uSchedule();
                int scheduleId = rs.getInt("ScheduleId");
                schedule.setScheduleId(scheduleId);
                schedule.setVersion(version);
                schedule.setHouse(allHouses.get(rs.getInt("HouseId")));
                schedule.setScheduleTimeslot(rs.getTimestamp("ScheduleTimeslot"));
                // Calculate price
                allSchedules.put(scheduleId, schedule);
            }
            T4uJDBC.close(rs, pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}

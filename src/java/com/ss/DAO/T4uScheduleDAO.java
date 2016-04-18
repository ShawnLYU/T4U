/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.DAO;

import com.ss.Model.*;
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
                schedule.setPrice(version.getVersionBasePrice());
                allSchedules.put(scheduleId, schedule);
                
            }
            T4uJDBC.close(rs, pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static T4uSchedule getScheduleById(int scheduleId) {
        T4uSchedule schedule = null;
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("SELECT " +
"m.MovieId, m.MovieName, " +
"v.VersionId, v.VersionName, v.VersionBasePrice, " +
"c.CinemaId, c.CinemaName, " +
"h.HouseId, h.HouseName, h.HousePlan, " +
"s.ScheduleId, s.ScheduleTimeslot, s.ScheduleOSeats " +
"FROM [T4U_schedule] s " +
"INNER JOIN [T4U_version] v ON s.versionId = v.versionId " +
"INNER JOIN [T4U_movie] m ON v.movieId = m.movieId " +
"INNER JOIN [T4U_house] h ON s.houseid = h.houseid " +
"INNER JOIN [T4U_cinema] c ON h.cinemaid = c.cinemaid " +
"WHERE s.scheduleId = ?");
            pstmt.setInt(1, scheduleId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                // Set movie
                T4uMovie movie = new T4uMovie();
                movie.setMovieId(rs.getInt("MovieId"));
                movie.setMovieName(rs.getNString("MovieName"));
                // Set version
                T4uVersion version = new T4uVersion();
                version.setVersionId(rs.getInt("VersionId"));
                version.setVersionName(rs.getNString("versionName"));
                version.setVersionBasePrice(rs.getDouble("VersionBasePrice"));
                version.setMovie(movie);
                // Set cinema
                T4uCinema cinema = new T4uCinema();
                cinema.setCinemaId(rs.getInt("CinemaId"));
                cinema.setCinemaName(rs.getNString("CinemaName"));
                // Set house
                T4uHouse house = new T4uHouse();
                house.setHouseId(rs.getInt("HouseId"));
                house.setHouseName(rs.getNString("HouseName"));
                house.setHousePlan(rs.getNString("HousePlan"));
                house.setCinema(cinema);
                // Set schedule
                schedule = new T4uSchedule();
                schedule.setScheduleId(scheduleId);
                schedule.setScheduleTimeslot(rs.getTimestamp("ScheduleTimeslot"));
                schedule.setVersion(version);
                schedule.setHouse(house);
                schedule.setPrice(version.getVersionBasePrice());
                schedule.setScheduleOSeats(rs.getNString("ScheduleOSeats"));
            }
            T4uJDBC.close(rs, pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return schedule;
    }
    
}

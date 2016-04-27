/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.DAO;

import com.ss.Model.*;
import com.ss.Utility.T4uJDBC;
import com.ss.app.T4uCinemaLocation;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
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
    public static List<Integer> getAllScheduleIds() {
        List<Integer> allScheduleIds = new ArrayList<Integer>();
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("SELECT [ScheduleId] FROM [T4U_schedule]");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next())
                allScheduleIds.add(rs.getInt("ScheduleId"));
            T4uJDBC.close(rs, pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return allScheduleIds;
    }
    
    public static T4uSchedule getScheduleById(int scheduleId) {
        T4uSchedule schedule = null;
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("SELECT " +
"m.MovieId, m.MovieName, m.MovieInfo," +
"v.VersionId, v.VersionName, v.VersionBasePrice, " +
"c.CinemaId, c.CinemaName, c.CinemaLocation, " +
"h.HouseId, h.HouseName, h.HousePlan, " +
"s.ScheduleId, s.ScheduleTimeslot, s.ScheduleOSeats, s.ScheduleUSeats " +
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
                movie.setMovieInfo(rs.getNString("MovieInfo"));
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
                cinema.setCinemaLocation(new T4uCinemaLocation(rs.getNString("CinemaLocation")));
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
                schedule.setScheduleUSeats(rs.getNString("ScheduleUSeats"));
            }
            T4uJDBC.close(rs, pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return schedule;
    }
    
    public static String getOSeatsById(int scheduleId) {
        String oSeats = null;
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("SELECT [ScheduleOSeats] FROM [T4U_schedule] WHERE [ScheduleId]=?");
            pstmt.setInt(1, scheduleId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next())
                oSeats = rs.getNString("ScheduleOSeats");
            T4uJDBC.close(rs, pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return oSeats;
    }
    
    public static boolean updateOSeatsById(int scheduleId, String oSeats) {
        boolean success = false;
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("UPDATE [T4U_schedule] SET [ScheduleOSeats] = ? WHERE [ScheduleId] = ?");
            pstmt.setNString(1, oSeats);
            pstmt.setInt(2, scheduleId);
            int rows = pstmt.executeUpdate();
            success = rows > 0;
            T4uJDBC.close(pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return success;
    }
    
    public static boolean updateUSeatsById(int scheduleId, String uSeats) {
        boolean success = false;
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("UPDATE [T4U_schedule] SET [ScheduleUSeats] = ? WHERE [ScheduleId] = ?");
            pstmt.setNString(1, uSeats);
            pstmt.setInt(2, scheduleId);
            int rows = pstmt.executeUpdate();
            success = rows > 0;
            T4uJDBC.close(pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return success;
    }
    
    public static int insertSchedule(int versionId, int houseId, Timestamp scheduleTimeslot) {
        int scheduleId = 0;
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO [T4U_schedule] "
+ "([VersionId], [houseId], [ScheduleTimeslot], [ScheduleOSeats], [ScheduleUSeats]) "
+ "VALUES (?,?,?,?,?)");
            pstmt.setInt(1, versionId);
            pstmt.setInt(2, houseId);
            pstmt.setTimestamp(3, scheduleTimeslot);
            pstmt.setNString(4, "");
            pstmt.setNString(5, "");
            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT @@IDENTITY AS [@@IDENTITY]");
                if (rs !=null && rs.next()) {
                    scheduleId = rs.getInt(1);
                    rs.close();
                }
            }
            T4uJDBC.close(pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return scheduleId;
    }
    
    public static boolean updateSchedule(int scheduleId, int versionId, int houseId, Timestamp scheduleTimesolt) {
        boolean success = false;
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("UPDATE [T4U_schedule] "
+ "SET [VersionId] = ?, [houseId] = ?, [ScheduleTimeslot] = ? "
+ "WHERE [ScheduleId] = ?");
            pstmt.setInt(1, versionId);
            pstmt.setInt(2, houseId);
            pstmt.setTimestamp(3, scheduleTimesolt);
            pstmt.setInt(4, scheduleId);
            int rows = pstmt.executeUpdate();
            success = rows > 0;
            T4uJDBC.close(pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return success;
    }
    
    public static boolean deleteSchedule(int scheduleId) {
        boolean success = false;
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM [T4U_schedule] WHERE [ScheduleId] = ?");
            pstmt.setInt(1, scheduleId);
            int rows = pstmt.executeUpdate();
            success = rows > 0;
            T4uJDBC.close(pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uScheduleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return success;
    }
}

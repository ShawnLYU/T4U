/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.DAO;

import com.ss.Model.T4uOrder;
import com.ss.Model.T4uUser;
import com.ss.Utility.T4uJDBC;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Steven
 */
public class T4uOrderDAO {
    public static Map<Long, T4uOrder> getAllOrdersByUser(T4uUser user) {
        int userId = user.getUserId();
        Map<Long, T4uOrder> allOrders = new HashMap<Long, T4uOrder>();
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM [T4U_order] WHERE [UserId]= ? ");
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                // Set order
                T4uOrder order = new T4uOrder();
                long orderId = rs.getLong("OrderId");
                order.setOrderId(orderId);
                Timestamp orderDate = rs.getTimestamp("OrderDate");
                order.setOrderDate(orderDate);
                order.setUser(user);
                order.setSchedule(T4uScheduleDAO.getScheduleById(rs.getInt("ScheduleId")));
                order.setOrderSeats(rs.getNString("OrderSeats"));
                order.setOrderStatus(rs.getInt("OrderStatus"));
                order.setOrderCash(rs.getDouble("OrderCash"));
                order.setOrderCredit(rs.getInt("OrderCredit"));
                allOrders.put(orderId, order);
            }
            T4uJDBC.close(rs, pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return allOrders;
    }
    
    public static T4uOrder getOrderById(long orderId) {
        T4uOrder order = null;
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM [T4U_order] WHERE [OrderId]= ? ");
            pstmt.setLong(1, orderId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                // Set order
                order = new T4uOrder();
                order.setOrderId(orderId);
                Timestamp orderDate = rs.getTimestamp("OrderDate");
                order.setOrderDate(orderDate);
                order.setUser(T4uUserDAO.getUserById(rs.getInt("UserId")));
                order.setSchedule(T4uScheduleDAO.getScheduleById(rs.getInt("ScheduleId")));
                order.setOrderSeats(rs.getNString("OrderSeats"));
                order.setOrderStatus(rs.getInt("OrderStatus"));
                order.setOrderCash(rs.getDouble("OrderCash"));
                order.setOrderCredit(rs.getInt("OrderCredit"));
            }
            T4uJDBC.close(rs, pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return order;
    }
    
    public static List<T4uOrder> getWAOrders() {
        List<T4uOrder> waOrders = new ArrayList<T4uOrder>();
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM [T4U_order] WHERE [OrderStatus]=2");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                // Set order
                T4uOrder order = new T4uOrder();
                order.setOrderId(rs.getLong("OrderId"));
                order.setOrderDate(rs.getTimestamp("OrderDate"));
                order.setUserId(rs.getInt("UserId"));
                order.setScheduleId(rs.getInt("ScheduleId"));
                order.setOrderSeats(rs.getNString("OrderSeats"));
                order.setOrderStatus(rs.getInt("OrderStatus"));
                order.setOrderCash(rs.getDouble("OrderCash"));
                order.setOrderCredit(rs.getInt("OrderCredit"));
                waOrders.add(order);
            }
        } catch (SQLException ex) {
            Logger.getLogger(T4uOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return waOrders;
    }
    
    public static long placeOrder(int userId, int scheduleId, List<String> orderSeats, double orderCash, int orderCredit, String oldOSeats) {
        String strOrderSeats = "";
        long orderId = 0;
        for (String seat: orderSeats)
            strOrderSeats += "'" + seat + "',";
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO [T4U_order] "
+ "([UserId], [ScheduleId], [OrderSeats], [OrderStatus], [OrderCash], [OrderCredit]) "
+ "VALUES (?,?,?,?,?,?)");
            pstmt.setInt(1, userId);
            pstmt.setInt(2, scheduleId);
            pstmt.setNString(3, strOrderSeats);
            pstmt.setInt(4, 1);
            pstmt.setDouble(5, orderCash);
            pstmt.setInt(6, orderCredit);
            int row = pstmt.executeUpdate();
            if (row > 0) {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT @@IDENTITY AS [@@IDENTITY]");
                if (rs !=null && rs.next()) {
                    orderId = rs.getLong(1);
                    rs.close();
                }
            }
            T4uJDBC.close(pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
            // Revert
            T4uScheduleDAO.updateOSeatsById(scheduleId, oldOSeats);
        } catch (Exception ex) {
            Logger.getLogger(T4uOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
            // Revert
            T4uScheduleDAO.updateOSeatsById(scheduleId, oldOSeats);
        }
        return orderId;
    }
    
    public static boolean changeOrderStatus(long orderId, int newStatus, T4uUser operator) {
        boolean success = false;
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("UPDATE [T4U_order] SET [OrderStatus]=? WHERE [OrderId]=?");
            pstmt.setInt(1, newStatus);
            pstmt.setLong(2, orderId);
            if (newStatus != 3 || (newStatus == 3 && operator.getUserGroup().equals("admin"))) {
                int rows = pstmt.executeUpdate();
                success = rows > 0;
            }
            T4uJDBC.close(pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return success;
    }
    
}

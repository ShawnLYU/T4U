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
    public static Map<Timestamp, T4uOrder> getAllOrdersByUser(T4uUser user) {
        int userId = user.getUserId();
        Map<Timestamp, T4uOrder> allOrders = new HashMap<Timestamp, T4uOrder>();
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM [T4U_order] WHERE [userId]= ? ");
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                // Set order
                T4uOrder order = new T4uOrder();
                Timestamp orderId = rs.getTimestamp("OrderId");
                order.setOrderId(orderId);
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
    
    public static Timestamp placeOrder(int userId, int scheduleId, List<String> orderSeats, double orderCash, int orderCredit) {
        String strOrderSeats = "";
        Timestamp orderId = null;
        for (String seat: orderSeats)
            strOrderSeats += "'" + seat + "',";
        try {
            Connection conn =  T4uJDBC.connect();
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO [T4U_order] "
+ "([UserId], [ScheduleId], [OrderSeats], [OrderStatus], [OrderCash], [OrderCredit]) VALUES "
+ "(?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, scheduleId);
            pstmt.setNString(3, strOrderSeats);
            pstmt.setInt(4, 1);
            pstmt.setDouble(5, orderCash);
            pstmt.setInt(6, orderCredit);
            int row = pstmt.executeUpdate();
            ResultSet rs = pstmt.getGeneratedKeys();
            if (row > 0 && rs.next())
                orderId = rs.getTimestamp("OrderId");
            T4uJDBC.close(rs, pstmt, conn);
        } catch (SQLException ex) {
            Logger.getLogger(T4uOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(T4uOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return orderId;
    }
    
}

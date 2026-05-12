package com.dashboard.dao;

import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Map;

import com.dashboard.util.DBConnection;

public class DashboardDAO {

	public int getTotalReservations() {
		int count = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM reservations");
				ResultSet rs = ps.executeQuery()) {

			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;
	}

	public double getTotalRevenue() {
		double total = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con
						.prepareStatement("SELECT SUM(amount) FROM payments WHERE payment_status='PAID'");
				ResultSet rs = ps.executeQuery()) {

			if (rs.next()) {
				total = rs.getDouble(1);
				if (rs.wasNull()) {
					total = 0;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return total;
	}

	public int getConfirmedReservations() {
		int count = 0;
		try {
			Connection con = DBConnection.getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM reservations WHERE status='CONFIRMED'");
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public int getTotalCustomers() {
		int count = 0;
		try {
			Connection con = DBConnection.getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM customers");
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	public Map<String, Integer> getReservationsPerDay() {
	    Map<String, Integer> data = new LinkedHashMap<>();

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(
	             "SELECT DATE(reservation_time) as day, COUNT(*) as total " +
	             "FROM reservations GROUP BY day ORDER BY day"
	         );
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            data.put(rs.getString("day"), rs.getInt("total"));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return data;
	}
	public Map<String, Double> getRevenuePerDay() {
	    Map<String, Double> data = new LinkedHashMap<>();

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(
	             "SELECT DATE(created_at) as day, SUM(amount) as total " +
	             "FROM payments WHERE payment_status='PAID' " +
	             "GROUP BY day ORDER BY day"
	         );
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            data.put(rs.getString("day"), rs.getDouble("total"));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return data;
	}
	public Map<String, Double> getDailySales() {
	    Map<String, Double> data = new LinkedHashMap<>();
	    
	    String query = "SELECT DATE(created_at) as day, SUM(amount) as total " +
	                   "FROM payments " +
	                   "WHERE payment_status='PAID' " +
	                   "GROUP BY DATE(created_at) " +
	                   "ORDER BY DATE(created_at)";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(query);
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            String day = rs.getString("day");
	            double total = rs.getDouble("total");
	            
	            if (rs.wasNull()) {
	                total = 0.0;
	            }
	            
	            data.put(day, total);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return data;
	}
}
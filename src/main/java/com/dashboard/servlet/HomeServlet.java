package com.dashboard.servlet;

import com.dashboard.util.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try (Connection con = DBConnection.getConnection()) {

			// TABLE COUNTS
			req.setAttribute("availableTables",
					getCount(con, "SELECT COUNT(*) FROM restaurant_tables WHERE status='AVAILABLE'"));

			req.setAttribute("reservedTables",
					getCount(con, "SELECT COUNT(*) FROM restaurant_tables WHERE status='RESERVED'"));

			req.setAttribute("bookedTables",
					getCount(con, "SELECT COUNT(*) FROM restaurant_tables WHERE status='BOOKED'"));

			// ORDER COUNTS
			req.setAttribute("pendingOrders", getCount(con, "SELECT COUNT(*) FROM orders WHERE status='PENDING'"));

			req.setAttribute("processingOrders",
					getCount(con, "SELECT COUNT(*) FROM orders WHERE status='PROCESSING'"));

			req.setAttribute("completedOrders", getCount(con, "SELECT COUNT(*) FROM orders WHERE status='COMPLETED'"));

			req.setAttribute("cancelledOrders", getCount(con, "SELECT COUNT(*) FROM orders WHERE status='CANCELLED'"));

			// FEEDBACK COUNTS
//			req.setAttribute("totalFeedback", getCount(con, "SELECT COUNT(*) FROM feedback_results"));
//
//			req.setAttribute("positiveFeedback",
//					getCount(con, "SELECT COUNT(*) FROM feedback_results WHERE result='POSITIVE'"));
//
//			req.setAttribute("negativeFeedback",
//					getCount(con, "SELECT COUNT(*) FROM feedback_results WHERE result='NEGATIVE'"));

		} catch (Exception e) {
			e.printStackTrace();
		}

		req.getRequestDispatcher("home.jsp").forward(req, resp);
	}

	private int getCount(Connection con, String sql) throws SQLException {
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		if (rs.next()) {
			return rs.getInt(1);
		}

		return 0;
	}
}
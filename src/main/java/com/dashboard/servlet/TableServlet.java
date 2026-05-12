package com.dashboard.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.dashboard.util.*;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/addTable")
public class TableServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		int tableNumber = Integer.parseInt(req.getParameter("table_number"));
		int capacity = Integer.parseInt(req.getParameter("capacity"));

		try (Connection con = DBConnection.getConnection()) {
			PreparedStatement ps = con
					.prepareStatement("INSERT INTO restaurant_tables(table_number, capacity) VALUES (?, ?)");
			ps.setInt(1, tableNumber);
			ps.setInt(2, capacity);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect("tables.jsp");
	}
}
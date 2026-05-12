package com.dashboard.servlet;

import com.dashboard.util.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/records")
public class RecordsServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String type = req.getParameter("type");
		String search = req.getParameter("search");
		String pageParam = req.getParameter("page");

		if (type == null) {
			type = "customers";
		}

		if (search == null) {
			search = "";
		}

		int page = 1;
		int limit = 15;

		if (pageParam != null) {
			page = Integer.parseInt(pageParam);
		}

		int offset = (page - 1) * limit;

		List<Map<String, Object>> records = new ArrayList<>();
		List<String> columns = new ArrayList<>();

		int totalRecords = 0;

		try (Connection con = DBConnection.getConnection()) {

			String dataQuery = "";
			String countQuery = "";

			if ("customers".equals(type)) {

				dataQuery = "SELECT id, name, phone, email, created_at FROM customers "
						+ "WHERE name LIKE ? OR phone LIKE ? OR email LIKE ? " + "ORDER BY id DESC LIMIT ? OFFSET ?";

				countQuery = "SELECT COUNT(*) FROM customers " + "WHERE name LIKE ? OR phone LIKE ? OR email LIKE ?";

			} else if ("confirmed".equals(type)) {

				dataQuery = "SELECT * FROM reservations "
						+ "WHERE status='CONFIRMED' AND (CAST(id AS CHAR) LIKE ? OR status LIKE ?) "
						+ "ORDER BY id DESC LIMIT ? OFFSET ?";

				countQuery = "SELECT COUNT(*) FROM reservations "
						+ "WHERE status='CONFIRMED' AND (CAST(id AS CHAR) LIKE ? OR status LIKE ?)";

			} else if ("revenue".equals(type)) {

				dataQuery = "SELECT id, customer_name, table_number, item_name, quantity, total_amount, status, created_at "
						+ "FROM orders WHERE CAST(id AS CHAR) LIKE ? OR customer_name LIKE ? OR item_name LIKE ? "
						+ "ORDER BY id DESC LIMIT ? OFFSET ?";

				countQuery = "SELECT COUNT(*) FROM orders "
						+ "WHERE CAST(id AS CHAR) LIKE ? OR customer_name LIKE ? OR item_name LIKE ?";

			} else {

				type = "reservations";

				dataQuery = "SELECT * FROM reservations " + "WHERE CAST(id AS CHAR) LIKE ? OR status LIKE ? "
						+ "ORDER BY id DESC LIMIT ? OFFSET ?";

				countQuery = "SELECT COUNT(*) FROM reservations " + "WHERE CAST(id AS CHAR) LIKE ? OR status LIKE ?";
			}

			String likeSearch = "%" + search + "%";

			PreparedStatement countPs = con.prepareStatement(countQuery);

			if ("customers".equals(type) || "revenue".equals(type)) {
				countPs.setString(1, likeSearch);
				countPs.setString(2, likeSearch);
				countPs.setString(3, likeSearch);
			} else {
				countPs.setString(1, likeSearch);
				countPs.setString(2, likeSearch);
			}

			ResultSet countRs = countPs.executeQuery();

			if (countRs.next()) {
				totalRecords = countRs.getInt(1);
			}

			PreparedStatement ps = con.prepareStatement(dataQuery);

			if ("customers".equals(type) || "revenue".equals(type)) {
				ps.setString(1, likeSearch);
				ps.setString(2, likeSearch);
				ps.setString(3, likeSearch);
				ps.setInt(4, limit);
				ps.setInt(5, offset);
			} else {
				ps.setString(1, likeSearch);
				ps.setString(2, likeSearch);
				ps.setInt(3, limit);
				ps.setInt(4, offset);
			}

			ResultSet rs = ps.executeQuery();
			ResultSetMetaData meta = rs.getMetaData();

			int columnCount = meta.getColumnCount();

			for (int i = 1; i <= columnCount; i++) {
				columns.add(meta.getColumnLabel(i));
			}

			while (rs.next()) {

				Map<String, Object> row = new LinkedHashMap<>();

				for (String col : columns) {
					row.put(col, rs.getObject(col));
				}

				records.add(row);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		int totalPages = (int) Math.ceil(totalRecords / 15.0);

		req.setAttribute("records", records);
		req.setAttribute("columns", columns);
		req.setAttribute("type", type);
		req.setAttribute("search", search);
		req.setAttribute("currentPage", page);
		req.setAttribute("totalPages", totalPages);
		req.setAttribute("totalRecords", totalRecords);

		req.getRequestDispatcher("records.jsp").forward(req, resp);
	}
}
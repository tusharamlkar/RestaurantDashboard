package com.dashboard.servlet;

import com.dashboard.util.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		List<Map<String, Object>> orders = new ArrayList<>();
		List<Map<String, Object>> menuItems = new ArrayList<>();
		List<Map<String, Object>> tables = new ArrayList<>();
		try (Connection con = DBConnection.getConnection()) {

			// orders fetch
			PreparedStatement ps = con.prepareStatement(
					"SELECT * FROM orders WHERE created_at >= NOW() - INTERVAL 2 DAY ORDER BY id DESC");

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Map<String, Object> order = new HashMap<>();

				order.put("id", rs.getInt("id"));
				order.put("customer_name", rs.getString("customer_name"));
				order.put("item_name", rs.getString("item_name"));
				order.put("quantity", rs.getInt("quantity"));
				order.put("total_amount", rs.getDouble("total_amount"));
				order.put("status", rs.getString("status"));
				order.put("table_number", rs.getInt("table_number"));
				orders.add(order);
			}

			// menu items fetch
			PreparedStatement menuPs = con.prepareStatement("SELECT * FROM menu_items WHERE status='AVAILABLE'");

			ResultSet menuRs = menuPs.executeQuery();

			while (menuRs.next()) {
				Map<String, Object> item = new HashMap<>();

				item.put("id", menuRs.getInt("id"));
				item.put("item_name", menuRs.getString("item_name"));
				item.put("price", menuRs.getDouble("price"));

				menuItems.add(item);
			}

			PreparedStatement tablePs = con
					.prepareStatement("SELECT * FROM restaurant_tables WHERE status='AVAILABLE'");

			ResultSet tableRs = tablePs.executeQuery();

			while (tableRs.next()) {

				Map<String, Object> table = new HashMap<>();

				table.put("table_number", tableRs.getInt("table_number"));

				tables.add(table);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		req.setAttribute("tables", tables);
		req.setAttribute("orders", orders);
		req.setAttribute("menuItems", menuItems);

		req.getRequestDispatcher("orders.jsp").forward(req, resp);

	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String action = req.getParameter("action");

		try (Connection con = DBConnection.getConnection()) {

			if ("add".equals(action)) {
				String customerName = req.getParameter("customer_name");
				String customerPhone = req.getParameter("customer_phone");
				String customerEmail = req.getParameter("customer_email");

				int customerId = 0;

				PreparedStatement checkCustomer = con
						.prepareStatement("SELECT id FROM customers WHERE phone=? OR email=? LIMIT 1");
				checkCustomer.setString(1, customerPhone);
				checkCustomer.setString(2, customerEmail);

				ResultSet crs = checkCustomer.executeQuery();

				if (crs.next()) {
					customerId = crs.getInt("id");
				} else {

					PreparedStatement insertCustomer = con.prepareStatement(
							"INSERT INTO customers(name, phone, email) VALUES (?, ?, ?)",
							Statement.RETURN_GENERATED_KEYS);

					insertCustomer.setString(1, customerName);
					insertCustomer.setString(2, customerPhone);
					insertCustomer.setString(3, customerEmail);

					insertCustomer.executeUpdate();

					ResultSet keys = insertCustomer.getGeneratedKeys();

					if (keys.next()) {
						customerId = keys.getInt(1);
					}
				}
				int tableNumber = Integer.parseInt(req.getParameter("table_number"));
				String itemName = req.getParameter("item_name");
				int quantity = Integer.parseInt(req.getParameter("quantity"));
				double totalAmount = Double.parseDouble(req.getParameter("total_amount"));
				String status = req.getParameter("status");

				PreparedStatement ps = con.prepareStatement(
						"INSERT INTO orders(customer_id, customer_name, table_number, item_name, quantity, total_amount, status) VALUES (?, ?, ?, ?, ?, ?, ?)");

				ps.setInt(1, customerId);
				ps.setString(2, customerName);
				ps.setInt(3, tableNumber);
				ps.setString(4, itemName);
				ps.setInt(5, quantity);
				ps.setDouble(6, totalAmount);
				ps.setString(7, status);

				ps.executeUpdate();

			} else if ("update".equals(action)) {

				int id = Integer.parseInt(req.getParameter("id"));
				String status = req.getParameter("status");

				PreparedStatement ps = con.prepareStatement("UPDATE orders SET status=? WHERE id=?");

				ps.setString(1, status);
				ps.setInt(2, id);

				ps.executeUpdate();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect("orders?success=1");
	}
}
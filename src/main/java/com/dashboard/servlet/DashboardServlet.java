package com.dashboard.servlet;

import java.io.IOException;
import java.util.Map;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

import com.dashboard.dao.DashboardDAO;

public class DashboardServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		DashboardDAO dao = new DashboardDAO();

		int totalReservations = dao.getTotalReservations();
		double totalRevenue = dao.getTotalRevenue();

		int confirmed = dao.getConfirmedReservations();
		int customers = dao.getTotalCustomers();

		Map<String, Integer> reservationsData = dao.getReservationsPerDay();
		Map<String, Double> revenueData = dao.getRevenuePerDay();

		req.setAttribute("reservations", totalReservations);
		req.setAttribute("revenue", totalRevenue);
		req.setAttribute("confirmed", confirmed);
		req.setAttribute("customers", customers);
		req.setAttribute("resChart", reservationsData);
		req.setAttribute("revChart", revenueData);

		RequestDispatcher rd = req.getRequestDispatcher("dashboard.jsp");
		rd.forward(req, resp);
	}
}

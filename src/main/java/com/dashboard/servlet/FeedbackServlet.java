package com.dashboard.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.*;

@MultipartConfig
public class FeedbackServlet extends HttpServlet {

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Part filePart = req.getPart("file");

		BufferedReader reader = new BufferedReader(new InputStreamReader(filePart.getInputStream()));

		String line;
		int positive = 0;
		int negative = 0;
		int lines = 0;

		while ((line = reader.readLine()) != null) {
			lines++;

			line = line.toLowerCase();

			if (line.contains("good") || line.contains("excellent") || line.contains("nice")) {
				positive++;
			}

			if (line.contains("bad") || line.contains("poor") || line.contains("worst")) {
				negative++;
			}
		}

		req.setAttribute("positive", positive);
		req.setAttribute("negative", negative);
		req.setAttribute("lines", lines);

		req.getRequestDispatcher("feedback.jsp").forward(req, resp);
	}
}
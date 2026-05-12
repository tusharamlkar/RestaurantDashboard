<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Records</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

	<script>
if(localStorage.getItem("theme") === "dark") {
    document.body.classList.add("dark-mode");
}
</script>

	<div class="container">

		<div class="sidebar">
			<h2>Dashboard</h2>

			<ul>
				<li><a href="dashboard">Dashboard</a></li>
				<li><a href="home">Home</a></li>
				<li><a href="orders">Orders</a></li>
				<li><a href="tables">Tables</a></li>
				<li><a href="settings">Settings</a></li>
				<li><a href="feedback">Feedback</a></li>
			</ul>
		</div>

		<div class="main">

			<%
			String type = (String) request.getAttribute("type");
			String search = (String) request.getAttribute("search");
			Integer currentPage = (Integer) request.getAttribute("currentPage");
			Integer totalPages = (Integer) request.getAttribute("totalPages");
			Integer totalRecords = (Integer) request.getAttribute("totalRecords");

			List<String> columns = (List<String>) request.getAttribute("columns");

			List<Map<String, Object>> records = (List<Map<String, Object>>) request.getAttribute("records");
			%>

			<h1>
				<%=type.substring(0, 1).toUpperCase() + type.substring(1)%>
				Records
			</h1>

			<div class="card record-top-card">

				<form action="records" method="get" class="record-search-form">

					<input type="hidden" name="type" value="<%=type%>"> <input
						type="text" name="search" value="<%=search%>"
						placeholder="Search records...">

					<button type="submit">Search</button>

					<a href="records?type=<%=type%>" class="clear-btn">Clear</a>

				</form>

				<p class="record-count">
					Total Records: <strong><%=totalRecords%></strong>
				</p>

			</div>

			<div class="card table-card">

				<div class="table-wrapper">

					<table class="modern-table">

						<thead>
							<tr>
								<th>No.</th>

								<%
								if (columns != null) {
									for (String col : columns) {
								%>
								<th><%=col%></th>
								<%
								}
								}
								%>
							</tr>
						</thead>

						<tbody>

							<%
							int serial = ((currentPage - 1) * 15) + 1;

							if (records != null && !records.isEmpty()) {

								for (Map<String, Object> row : records) {
							%>

							<tr>
								<td><%=serial++%></td>

								<%
								for (String col : columns) {
								%>
								<td><%=row.get(col)%></td>
								<%
								}
								%>
							</tr>

							<%
							}

							} else {
							%>

							<tr>
								<td colspan="20" style="text-align: center;">No records
									found</td>
							</tr>

							<%
							}
							%>

						</tbody>

					</table>

				</div>

			</div>

			<div class="pagination">

				<%
				if (currentPage > 1) {
				%>
				<a
					href="records?type=<%=type%>&search=<%=search%>&page=<%=currentPage - 1%>">
					Previous </a>
				<%
				}

				for (int i = 1; i <= totalPages; i++) {
				%>
				<a class="<%=i == currentPage ? "page-active" : ""%>"
					href="records?type=<%=type%>&search=<%=search%>&page=<%=i%>"> <%=i%>
				</a>
				<%
				}

				if (currentPage < totalPages) {
				%>
				<a
					href="records?type=<%=type%>&search=<%=search%>&page=<%=currentPage + 1%>">
					Next </a>
				<%
				}
				%>

			</div>

		</div>

	</div>
	
<!-- 
</script>
	<!-- CUSTOM CURSOR 

	<div class="custom-cursor"></div>
	<div class="cursor-dot"></div>

	<script>

const cursor =
	document.querySelector(".custom-cursor");

const dot =
	document.querySelector(".cursor-dot");

document.addEventListener("mousemove", (e) => {

	cursor.style.left = e.clientX + "px";
	cursor.style.top = e.clientY + "px";

	dot.style.left = e.clientX + "px";
	dot.style.top = e.clientY + "px";
});

/* HOVER EFFECT */

const hoverElements =
	document.querySelectorAll(
		"a, button, .card, select, input"
	);

hoverElements.forEach(el => {

	el.addEventListener("mouseenter", () => {

		cursor.classList.add("cursor-hover");

	});

	el.addEventListener("mouseleave", () => {

		cursor.classList.remove("cursor-hover");

	});
});

</script> -->
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Home</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

	<div class="container">

		<div class="sidebar">
			<h2>Dashboard</h2>
			<ul>
				<li><a href="dashboard.jsp">Dashboard</a></li>
				<li><a class="active" href="home">Home</a></li>
				<li><a href="orders.jsp">Orders</a></li>
				<li><a href="tables.jsp">Tables</a></li>
				<li><a href="settings.jsp">Settings</a></li>
				<li><a href="feedback.jsp">Feedback</a></li>
			</ul>
		</div>

		<div class="main">
			<h1>Home</h1>

			<div class="cards">

				<a class="card home-card" href="dashboard">
					<h3>Dashboard</h3>
					<p>Business analysis</p>
				</a> <a class="card home-card" href="tables.jsp">
					<h3>Table Management</h3>
					<p>Available: ${availableTables}</p>
					<p>Reserved: ${reservedTables}</p>
					<p>Booked: ${bookedTables}</p>
				</a> <a class="card home-card" href="feedback.jsp">
					<h3>Feedback Check</h3>
					<p>Total: ${totalFeedback}</p>
					<p>Positive: ${positiveFeedback}</p>
					<p>Negative: ${negativeFeedback}</p>
				</a> <a class="card home-card" href="orders">
					<h3>Orders</h3>
					<p>Pending: ${pendingOrders}</p>
					<p>Processing: ${processingOrders}</p>
					<p>Completed: ${completedOrders}</p>
					<p>Cancelled: ${cancelledOrders}</p>
				</a>

			</div>
		</div>

	</div>
	<script>
		if (localStorage.getItem("theme") === "dark") {
			document.body.classList.add("dark-mode");
		}
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
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Table Management</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

	<div class="container">

		<div class="sidebar">
			<h2>Dashboard</h2>

			<ul>
				<li><a href="dashboard">Dashboard</a></li>
				<li><a href="home">Home</a></li>
				<li><a href="orders">Orders</a></li>
				<li><a class="active" href="tables">Tables</a></li>
				<li><a href="settings.jsp">Settings</a></li>
				<li><a href="feedback">Feedback</a></li>
			</ul>
		</div>

		<div class="main">

			<h1>Table Management</h1>

			<div class="card">

				<h2 style="margin-bottom: 20px;">Add New Table</h2>

				<form action="addTable" method="post">

					<div style="margin-bottom: 15px;">
						<label>Table Number</label><br> <input type="number"
							name="table_number" placeholder="Enter Table Number" required
							style="width: 100%; padding: 12px; margin-top: 8px;">
					</div>

					<div style="margin-bottom: 15px;">
						<label>Capacity</label><br> <input type="number"
							name="capacity" placeholder="Enter Capacity" required
							style="width: 100%; padding: 12px; margin-top: 8px;">
					</div>

					<div style="margin-bottom: 20px;">
						<label>Status</label><br> <select name="status"
							style="width: 100%; padding: 12px; margin-top: 8px;">

							<option value="AVAILABLE">AVAILABLE</option>
							<option value="BOOKED">BOOKED</option>
							<option value="RESERVED">RESERVED</option>

						</select>
					</div>

					<button type="submit"
						style="padding: 12px 25px; background: #4caf50; color: white; border: none; border-radius: 10px; cursor: pointer; font-size: 16px;">

						Update Table</button>

				</form>

			</div>

		</div>

	</div>
	<script>
if(localStorage.getItem("theme") === "dark") {
    document.body.classList.add("dark-mode");
}

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
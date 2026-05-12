<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Settings</title>

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
				<li><a href="tables.jsp">Tables</a></li>
				<li><a class="active" href="settings.jsp">Settings</a></li>
				<li><a href="feedback.jsp">Feedback</a></li>
			</ul>
		</div>

		<div class="main">

			<h1>Settings</h1>

			<div class="settings-grid">

				<!-- PROFILE -->
				<div class="card settings-card">

					<h2>Profile</h2>

					<form>

						<div class="input-group">
							<label>Name</label> <input type="text" value="Restaurant Admin">
						</div>

						<div class="input-group">
							<label>Email</label> <input type="email" value="admin@gmail.com">
						</div>

						<div class="input-group">
							<label>Password</label> <input type="password" value="123456">
						</div>

						<button type="button" class="save-btn">Update Profile</button>

					</form>

				</div>

				<!-- APP SETTINGS -->
				<div class="card settings-card">

					<h2>Application Settings</h2>

					<div class="setting-item">

						<div>
							<h3>Dark Mode</h3>
							<p>Enable dark theme</p>
						</div>

						<label class="switch"> <input type="checkbox"
							id="themeToggle"> <span class="slider"></span>
						</label>

					</div>

					<div class="setting-item">

						<div>
							<h3>Notifications</h3>
							<p>Enable order alerts</p>
						</div>

						<label class="switch"> <input type="checkbox" checked>
							<span class="slider"></span>
						</label>

					</div>

					<div class="setting-item">

						<div>
							<h3>Auto Refresh</h3>
							<p>Refresh dashboard automatically</p>
						</div>

						<label class="switch"> <input type="checkbox"
							id="autoRefreshToggle"> <span class="slider"></span>
						</label>

					</div>

				</div>

				<!-- ACCOUNT -->
				<div class="card settings-card">

					<h2>Account</h2>

					<button class="danger-btn">Logout</button>

				</div>

			</div>

		</div>

	</div>


	<script>
		document.addEventListener("DOMContentLoaded", function() {

			const themeToggle = document.getElementById("themeToggle");
			const autoRefreshToggle = document
					.getElementById("autoRefreshToggle");

			// DARK MODE LOAD
			if (localStorage.getItem("theme") === "dark") {
				document.body.classList.add("dark-mode");

				if (themeToggle) {
					themeToggle.checked = true;
				}
			}

			// DARK MODE BUTTON
			if (themeToggle) {
				themeToggle.addEventListener("change", function() {

					if (themeToggle.checked) {
						document.body.classList.add("dark-mode");
						localStorage.setItem("theme", "dark");
					} else {
						document.body.classList.remove("dark-mode");
						localStorage.setItem("theme", "light");
					}

				});
			}

			// AUTO REFRESH LOAD
			if (localStorage.getItem("autoRefresh") === "on") {
				if (autoRefreshToggle) {
					autoRefreshToggle.checked = true;
				}
			}

			// AUTO REFRESH BUTTON
			if (autoRefreshToggle) {
				autoRefreshToggle.addEventListener("change", function() {

					if (autoRefreshToggle.checked) {
						localStorage.setItem("autoRefresh", "on");
					} else {
						localStorage.setItem("autoRefresh", "off");
					}

				});
			}

		});
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
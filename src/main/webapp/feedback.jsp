<!DOCTYPE html>
<html>
<head>
<title>Feedback Analysis</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

	<div class="container">

		<div class="sidebar">
			<h2>Dashboard</h2>
			<ul>
				<li><a href="dashboard">Dashboard</a></li>
				<li><a href="homes.jsp">Home</a></li>
				<li><a href="orders.jsp">Orders</a></li>
				<li><a href="tables.jsp">Tables</a></li>
				<li><a href="settings.jsp">Settings</a></li>
				<li><a class="active" href="feedback">Feedback</a></li>
			</ul>
		</div>

		<div class="main">
			<h1>Feedback Analysis</h1>

			<div class="card">
				<form action="feedback" method="post" enctype="multipart/form-data">
					<input type="file" name="file" required> <br> <br>
					<button type="submit">Upload & Analyze</button>
				</form>
			</div>

			<br> <br>
			<div class="cards">

				<div class="card">
					<h3>Total Feedback</h3>
					<p>${lines}</p>
				</div>

				<div class="card">
					<h3>Positive</h3>
					<p style="color: green">${positive}</p>
				</div>

				<div class="card">
					<h3>Negative</h3>
					<p style="color: red">${negative}</p>
				</div>

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
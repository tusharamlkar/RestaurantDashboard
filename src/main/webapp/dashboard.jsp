<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Dashboard</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body>

	<div class="container">

		<!-- SIDEBAR -->
		<div class="sidebar">

			<h2>Dashboard</h2>

			<ul>
				<li><a class="active" href="dashboard">Dashboard</a></li>
				<li><a href="home.jsp">Home</a></li>
				<li><a href="orders.jsp">Orders</a></li>
				<li><a href="tables.jsp">Tables</a></li>
				<li><a href="settings.jsp">Settings</a></li>
				<li><a href="feedback.jsp">Feedback</a></li>
			</ul>

		</div>

		<!-- MAIN -->
		<div class="main">

			<h1>Dashboard</h1>

			<div class="cards" id="dashboardCards">

				<a class="card home-card" href="records?type=reservations">
					<h3>Total Reservations</h3>
					<p>${reservations}</p>
				</a> <a class="card home-card" href="records?type=revenue">
					<h3>Total Revenue</h3>
					<p>₹ ${revenue}</p>
				</a> <a class="card home-card" href="records?type=confirmed">
					<h3>Confirmed</h3>
					<p>${confirmed}</p>
				</a> <a class="card home-card" href="records?type=customers">
					<h3>Customers</h3>
					<p>${customers}</p>
				</a>

			</div>

			<!-- CHARTS -->
			<div class="charts-container" id="chartsSection">

				<div class="chart-card">
					<h3>Reservations Trend</h3>
					<canvas id="resChart"></canvas>
				</div>

				<div class="chart-card">
					<h3>Revenue Trend</h3>
					<canvas id="revChart"></canvas>
				</div>

			</div>

		</div>

	</div>

	<!-- CHART SCRIPT -->
	<script>

    // RESERVATION LABELS
    const resLabels = [

        <%Map<String, Integer> resChart = (Map<String, Integer>) request.getAttribute("resChart");

if (resChart != null) {

	for (String k : resChart.keySet()) {%>

        "<%=k%>",

        <%}
}%>

    ];

    // RESERVATION DATA
    const resData = [

        <%if (resChart != null) {

	for (Integer v : resChart.values()) {%>

        <%=v%>,

        <%}
}%>

    ];

    // REVENUE LABELS
    const revLabels = [

        <%Map<String, Double> revChart = (Map<String, Double>) request.getAttribute("revChart");

if (revChart != null) {

	for (String k : revChart.keySet()) {%>

        "<%=k%>",

        <%}
}%>

    ];

    // REVENUE DATA
    const revData = [

        <%if (revChart != null) {

	for (Double v : revChart.values()) {%>

        <%=v%>,

        <%}
}%>

    ];

    // RESERVATION CHART
    new Chart(document.getElementById('resChart'), {

        type: 'line',

        data: {

            labels: resLabels,

            datasets: [{

                label: 'Reservations',

                data: resData,

                borderColor: '#4CAF50',

                backgroundColor: 'rgba(76,175,80,0.2)',

                tension: 0.4

            }]
        },

        options: {

            responsive: true,

            plugins: {
                legend: {
                    display: true
                }
            },

            scales: {
                x: {
                    ticks: {
                        maxRotation: 45
                    }
                }
            }
        }
    });

    // REVENUE CHART
    new Chart(document.getElementById('revChart'), {

        type: 'bar',

        data: {

            labels: revLabels,

            datasets: [{

                label: 'Revenue ₹',

                data: revData,

                backgroundColor: '#2196f3'

            }]
        },

        options: {

            responsive: true,

            scales: {
                x: {
                    ticks: {
                        maxRotation: 45
                    }
                }
            }
        }
    });

</script>

	<!-- DARK MODE -->
	<script>

if(localStorage.getItem("theme") === "dark") {

    document.body.classList.add("dark-mode");
}

</script>

	<!-- AUTO REFRESH -->
	<script>

if(localStorage.getItem("autoRefresh") === "on") {

    setInterval(() => {

        fetch("dashboard")

        .then(response => response.text())

        .then(data => {

            const parser =
                new DOMParser();

            const htmlDoc =
                parser.parseFromString(data, "text/html");

            // UPDATE CARDS
            const newCards =
                htmlDoc.getElementById("dashboardCards");

            if(newCards) {

                document.getElementById("dashboardCards")
                    .innerHTML = newCards.innerHTML;
            }

            // UPDATE CHARTS
            const newCharts =
                htmlDoc.getElementById("chartsSection");

            if(newCharts) {

                document.getElementById("chartsSection")
                    .innerHTML = newCharts.innerHTML;
            }

        });

    }, 10000);
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
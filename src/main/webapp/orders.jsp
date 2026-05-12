<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Orders</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
</head>


<body>
	<div id="toast" class="toast">Order Added Successfully</div>
	<div class="container">

		<div class="sidebar">
			<h2>Dashboard</h2>
			<ul>
				<li><a href="dashboard">Dashboard</a></li>
				<li><a href="home">Home</a></li>
				<li><a class="active"href="orders">Orders</a></li>
				<li><a  href="tables.jsp">Tables</a></li>
				<li><a href="settings.jsp">Settings</a></li>
				<li><a href="feedback.jsp">Feedback</a></li>
			</ul>
		</div>

		<div class="main">
			<h1>Orders</h1>

			<div class="order-layout">

				<div class="card table-card" id="recentOrdersSection">
					<h2>Add New Order</h2>

					<form action="orders" method="post" class="order-form"
						onsubmit="return prepareOrderData();">

						<input type="hidden" name="action" value="add">

						<div>
							<label>Customer Name</label> <input type="text"
								name="customer_name" placeholder="Enter customer name" required>
						</div>
						<div>
							<label>Phone Number</label> <input type="text"
								name="customer_phone" placeholder="Enter phone number">
						</div>

						<div>
							<label>Email</label> <input type="email" name="customer_email"
								placeholder="Enter email">
						</div>
						<div>
							<label>Table Number</label> <select name="table_number" required>

								<option value="">Select Table</option>

								<%
								List<Map<String, Object>> tables = (List<Map<String, Object>>) request.getAttribute("tables");

								if (tables != null) {

									for (Map<String, Object> t : tables) {
								%>

								<option value="<%=t.get("table_number")%>">Table
									<%=t.get("table_number")%>

								</option>

								<%
								}
								}
								%>

							</select>
						</div>
						<div>
							<label>Item</label> <select id="itemSelect">
								<option value="">Select Item</option>

								<%
								List<Map<String, Object>> menuItems = (List<Map<String, Object>>) request.getAttribute("menuItems");

								if (menuItems != null) {
									for (Map<String, Object> item : menuItems) {
								%>
								<option value="<%=item.get("item_name")%>"
									data-price="<%=item.get("price")%>">
									<%=item.get("item_name")%> - ₹<%=item.get("price")%>
								</option>
								<%
								}
								}
								%>
							</select>
						</div>

						<div>
							<label>Quantity</label> <input type="number" id="qtyInput"
								min="1" value="1">
						</div>

						<button type="button" onclick="addItem()">Add Item</button>

						<div>
							<label>Status</label> <select name="status">
								<option value="PENDING">PENDING</option>
								<option value="PROCESSING">PROCESSING</option>
								<option value="COMPLETED">COMPLETED</option>
								<option value="CANCELLED">CANCELLED</option>
							</select>
						</div>

						<input type="hidden" name="item_name" id="itemNameInput">
						<input type="hidden" name="quantity" id="quantityInput"> <input
							type="hidden" name="total_amount" id="totalAmountInput">

						<button type="submit">Save Order</button>

					</form>
				</div>

				<div class="card cart-card">
					<h2>Order Items</h2>

					<div id="selectedItems" class="cart-items">
						<p class="empty-cart">No items added yet</p>
					</div>

					<div class="cart-total">
						<span>Total</span> <strong>₹ <span id="showTotal">0</span></strong>
					</div>
				</div>

			</div>
			<div class="card table-card">
				<h2>Recent Orders</h2>

				<div class="table-wrapper">
					<table class="modern-table">

						<thead>
							<tr>
								<th>No.</th>
								<th>Customer</th>
								<th>Table</th>
								<th>Items</th>
								<th>Qty</th>
								<th>Total</th>
								<th>Status</th>
								<th>Update</th>
							</tr>
						</thead>

						<tbody>

							<%
							List<Map<String, Object>> orders = (List<Map<String, Object>>) request.getAttribute("orders");

							int serial = 1;

							if (orders != null && !orders.isEmpty()) {

								for (Map<String, Object> o : orders) {

									String status = String.valueOf(o.get("status"));
							%>

							<tr>

								<td><%=serial++%></td>

								<td><strong><%=o.get("customer_name")%></strong></td>

								<td>Table <%=o.get("table_number")%>
								</td>

								<td style="min-width: 250px;"><%=o.get("item_name")%></td>

								<td><%=o.get("quantity")%></td>

								<td>₹ <%=o.get("total_amount")%>
								</td>

								<td><span class="status-badge <%=status.toLowerCase()%>">
										<%=status%>
								</span></td>

								<td>

									<form action="orders" method="post" class="status-form">

										<input type="hidden" name="action" value="update"> <input
											type="hidden" name="id" value="<%=o.get("id")%>"> <select
											name="status">

											<option value="PENDING"
												<%=status.equals("PENDING") ? "selected" : ""%>>
												PENDING</option>

											<option value="PROCESSING"
												<%=status.equals("PROCESSING") ? "selected" : ""%>>
												PROCESSING</option>

											<option value="COMPLETED"
												<%=status.equals("COMPLETED") ? "selected" : ""%>>
												COMPLETED</option>

											<option value="CANCELLED"
												<%=status.equals("CANCELLED") ? "selected" : ""%>>
												CANCELLED</option>

										</select>

										<button type="submit">Save</button>

									</form>

								</td>

							</tr>

							<%
							}
							} else {
							%>

							<tr>
								<td colspan="8" style="text-align: center;">No orders found
								</td>
							</tr>

							<%
							}
							%>

						</tbody>

					</table>
				</div>
			</div>
		</div>
	</div>

	<script>
let items = [];
let total = 0;

function addItem() {
    const itemSelect = document.getElementById("itemSelect");
    const qtyInput = document.getElementById("qtyInput");

    const itemName = itemSelect.value;
    const selectedOption = itemSelect.options[itemSelect.selectedIndex];
    const price = Number(selectedOption.getAttribute("data-price"));
    const qty = Number(qtyInput.value);

    if (itemName === "" || qty <= 0) {
        alert("Please select item and quantity");
        return;
    }

    const amount = price * qty;

    items.push({
        name: itemName,
        price: price,
        qty: qty,
        amount: amount
    });

    total += amount;

    renderItems();

    itemSelect.value = "";
    qtyInput.value = 1;
}

function removeItem(index) {
    total -= items[index].amount;
    items.splice(index, 1);
    renderItems();
}

function renderItems() {
    const selectedItems = document.getElementById("selectedItems");
    const showTotal = document.getElementById("showTotal");

    if (items.length === 0) {
        selectedItems.innerHTML = '<p class="empty-cart">No items added yet</p>';
        showTotal.innerText = 0;
        return;
    }

    let html = "";

    items.forEach((item, index) => {
        html +=
            '<div class="cart-item">' +
                '<div>' +
                    '<strong>' + item.name + '</strong>' +
                    '<p>₹' + item.price + ' × ' + item.qty + ' = ₹' + item.amount + '</p>' +
                '</div>' +
                '<button type="button" onclick="removeItem(' + index + ')">×</button>' +
            '</div>';
    });

    selectedItems.innerHTML = html;
    showTotal.innerText = total;
}

function prepareOrderData() {
    if (items.length === 0) {
        alert("Please add at least one item");
        return false;
    }

    document.getElementById("itemNameInput").value =
        items.map(i => i.name + " x " + i.qty).join(", ");

    document.getElementById("quantityInput").value =
        items.reduce((sum, i) => sum + i.qty, 0);

    document.getElementById("totalAmountInput").value = total;

    return true;
}
</script>
	<script>
if(localStorage.getItem("theme") === "dark") {
    document.body.classList.add("dark-mode");
}
</script>
	<script>
if(localStorage.getItem("theme") === "dark") {
    document.body.classList.add("dark-mode");
}
</script>

	<script>

const params = new URLSearchParams(window.location.search);

if(params.get("success") === "1") {

    const toast = document.getElementById("toast");

    toast.classList.add("show");

    setTimeout(() => {
        toast.classList.remove("show");
    }, 3000);
}

</script>
	<script>

if(localStorage.getItem("autoRefresh") === "on") {

    setInterval(() => {

        fetch("orders")
        .then(response => response.text())
        .then(data => {

            const parser = new DOMParser();

            const htmlDoc =
                parser.parseFromString(data, "text/html");

            const newSection =
                htmlDoc.getElementById("recentOrdersSection");

            document.getElementById("recentOrdersSection")
                .innerHTML = newSection.innerHTML;
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
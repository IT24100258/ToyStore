<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.toyStore.model.OrderManagement.Order" %>
<%@ page import="com.toyStore.model.Toymanagement.Toy" %>
<%
  List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin - All Orders</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    :root {
      --primary-color: #6c5ce7;
      --accent-color: #fd79a8;
      --bg-light: #f8f9fa;
      --card-bg: #fff;
      --text-primary: #2d3436;
      --text-secondary: #636e72;
      --glass-bg: rgba(255,255,255,0.93);
    }
    body {
      background: linear-gradient(120deg, #f9fafb 0%, #f6f0f0 60%, #fd79a8 100%);
      font-family: 'Poppins', 'Segoe UI', Arial, sans-serif;
      color: var(--text-primary);
      min-height: 100vh;
    }
    .dashboard-glass {
      background: var(--glass-bg);
      border-radius: 28px;
      box-shadow: 0 12px 48px rgba(108,92,231,0.13);
      padding: 2.5rem 2rem;
      max-width: 1200px;
      margin: 4rem auto 2rem auto;
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      border: 1.5px solid rgba(108,92,231,0.09);
    }
    .section-title {
      color: var(--primary-color);
      margin-top: 2rem;
      margin-bottom: 1.5rem;
      font-weight: 800;
      letter-spacing: 0.04em;
      font-size: 2rem;
      text-shadow: 0 2px 6px rgba(108,92,231,0.15);
    }
    .btn-back {
      background: none;
      color: #6c5ce7;
      border: 2px solid #6c5ce7;
      font-weight: 700;
      border-radius: 10px;
      padding: 0.5em 1.3em;
      transition: background 0.2s, color 0.2s;
    }
    .btn-back:hover {
      background: #6c5ce7;
      color: #fff;
    }
    .table {
      background: #fff;
      border-radius: 14px;
      overflow: hidden;
      box-shadow: 0 4px 18px rgba(108,92,231,0.08);
    }
    .table thead {
      background: #6c5ce7;
      color: #fff;
      font-size: 1.07rem;
      letter-spacing: 0.01em;
    }
    .table tbody tr:hover {
      background: #f1f3f6;
    }
    .btn-confirm {
      background: linear-gradient(90deg, #6c5ce7 0%, #fd79a8 100%);
      color: white;
      border: none;
      border-radius: 8px;
      padding: 0.4rem 0.8rem;
      cursor: pointer;
      font-weight: 700;
      transition: background 0.3s;
    }
    .btn-confirm:hover {
      background: linear-gradient(90deg, #fd79a8 0%, #6c5ce7 100%);
    }
    .badge-status-pending {
      background-color: #fdcb6e;
      color: #2d3436;
      font-weight: 700;
    }
    .badge-status-success {
      background-color: #00b894;
      color: white;
      font-weight: 700;
    }
    @media (max-width: 991px) {
      .dashboard-glass { padding: 1.2rem 0.5rem; }
      .table-responsive { font-size: 0.98em; }
      .section-title { font-size: 1.3rem; }
    }
  </style>
</head>
<body>
<%@ include file="/views/header.jsp" %>
<div class="dashboard-glass">
  <div class="d-flex justify-content-between align-items-center mb-2">
    <h4 class="section-title"><i class="fas fa-boxes me-2"></i>All Orders</h4>
    <a href="${pageContext.request.contextPath}/views/admin/AdminManagement/adminDashboard.jsp" class="btn btn-back">
      <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
    </a>
  </div>
  <div class="table-responsive">
    <table class="table table-striped align-middle">
      <thead>
      <tr>
        <th>Order ID</th>
        <th>User</th>
        <th>Toy IDs</th>
        <th>Payment</th>
        <th>Total</th>
        <th>Address</th>
        <th>Telephone</th>
        <th>Date</th>
        <th>Status</th>
        <th>Action</th>
      </tr>
      </thead>
      <tbody>
      <% if (orders != null && !orders.isEmpty()) { %>
      <% for (Order order : orders) { %>
      <tr>
        <td><%= order.getOrderId() %></td>
        <td><%= order.getUser().getUserName() %></td>
        <td>
          <%
            Toy toy = order.getToy();
            if (toy != null) {
              out.print(toy.getId()); // or toy.getId() if that's your getter
            } else {
              out.print("<span class='text-danger'>N/A</span>");
            }
          %>
        </td>

        <td><%= order.getPaymentMethodString() %></td>
        <td>Rs <%= String.format("%.2f", order.getTotalAmount()) %></td>
        <td><%= order.getAddress() %></td>
        <td><%= order.getTelephone() %></td>
        <td><%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(order.getOrderDate()) %></td>
        <td>
          <span class="badge <%= "Pending".equals(order.getStatus()) ? "badge-status-pending" : "badge-status-success" %>">
            <%= order.getStatus() %>
          </span>
        </td>
        <td>
          <% if ("Pending".equals(order.getStatus())) { %>
          <form method="post" action="<%= request.getContextPath() %>/admin/orders" style="display:inline;">
            <input type="hidden" name="action" value="confirm">
            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
            <button type="submit" class="btn-confirm">Confirm</button>
          </form>
          <% } else { %>
          <span class="text-success">Confirmed</span>
          <% } %>
        </td>
      </tr>
      <% } %>
      <% } else { %>
      <tr><td colspan="10" class="text-center text-muted">No orders found.</td></tr>
      <% } %>
      </tbody>
    </table>
  </div>
</div>
<%@ include file="/views/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

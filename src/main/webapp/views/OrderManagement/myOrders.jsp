<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.toyStore.model.OrderManagement.Order" %>
<%@ page import="com.toyStore.model.Toymanagement.Toy" %>
<%@ page import="com.toyStore.model.Toymanagement.ToyLinkedList" %>

<%
  List<Order> orders = (List<Order>) request.getAttribute("orders");
  ToyLinkedList toyList = (ToyLinkedList) request.getAttribute("toyList");
%>
<!DOCTYPE html>
<html>
<head>
  <title>My Orders</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    :root {
      --primary-color: #6c5ce7;
      --accent-color: #fd79a8;
      --bg-light: #f8f9fa;
      --card-bg: #fff;
      --glass-bg: rgba(255,255,255,0.93);
      --text-primary: #2d3436;
      --text-secondary: #636e72;
    }
    body {
      background: linear-gradient(120deg, #f9fafb 0%, #f6f0f0 60%, #fd79a8 100%);
      color: var(--text-primary);
      font-family: 'Poppins', 'Segoe UI', Arial, sans-serif;
      min-height: 100vh;
    }
    .orders-card {
      background: var(--glass-bg);
      border-radius: 22px;
      box-shadow: 0 12px 44px rgba(108,92,231,0.13);
      padding: 2.5rem 2rem;
      max-width: 1100px;
      margin: 4rem auto 3rem auto;
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      border: 1.5px solid rgba(108,92,231,0.09);
    }
    .section-title {
      color: var(--primary-color);
      margin-bottom: 2rem;
      font-weight: 800;
      letter-spacing: 0.04em;
      text-shadow: 0 2px 6px rgba(108,92,231,0.15);
      font-size: 2rem;
    }
    .table thead {
      background: var(--primary-color);
      color: white;
      font-size: 1.08rem;
      letter-spacing: 0.02em;
      border-radius: 12px 12px 0 0;
    }
    .table tbody tr:hover {
      background: #f1f3f6;
      transition: background 0.2s;
    }
    .btn-back {
      background: none;
      color: var(--primary-color);
      border: 2px solid var(--primary-color);
      font-weight: 700;
      border-radius: 10px;
      padding: 0.5em 1.3em;
      transition: background 0.2s, color 0.2s;
    }
    .btn-back:hover {
      background: var(--primary-color);
      color: #fff;
    }
    .badge-status-pending {
      background-color: #fdcb6e;
      color: #2d3436;
      font-weight: 700;
      font-size: 0.97em;
      border-radius: 8px;
      padding: 0.4em 1.1em;
    }
    .badge-status-success {
      background-color: #00b894;
      color: white;
      font-weight: 700;
      font-size: 0.97em;
      border-radius: 8px;
      padding: 0.4em 1.1em;
    }
    .badge-toy {
      background: var(--accent-color);
      color: #fff;
      font-size: 0.97em;
      border-radius: 8px;
      padding: 0.3em 0.9em;
      margin-right: 0.2em;
      font-weight: 600;
      box-shadow: 0 2px 6px rgba(253,121,168,0.08);
    }
    @media (max-width: 991px) {
      .orders-card { padding: 1.2rem 0.2rem; }
      .table-responsive { font-size: 0.98em; }
      .section-title { font-size: 1.3rem; }
    }
  </style>
</head>
<body>
<%@ include file="/views/header.jsp" %>
<div class="orders-card">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h4 class="section-title"><i class="fas fa-boxes me-2"></i>My Orders</h4>
    <a href="${pageContext.request.contextPath}/" class="btn btn-back">
      <i class="fas fa-arrow-left me-1"></i> Back to Home
    </a>
  </div>
  <% if (orders != null && !orders.isEmpty()) { %>
  <div class="table-responsive">
    <table class="table align-middle">
      <thead>
      <tr>
        <th>Order ID</th>
        <th>Toy ID</th>
        <th>Payment</th>
        <th>Total</th>
        <th>Address</th>
        <th>Telephone</th>
        <th>Date</th>
        <th>Status</th>
      </tr>
      </thead>
      <tbody>
      <% for (Order order : orders) { %>
      <tr>
        <td><%= order.getOrderId() %></td>
        <td>
          <%
            Toy toy = order.getToy();
            if (toy != null) {
          %>
          <span class="badge-toy"><%= toy.getId() %></span>
          <%
            }
          %>
        </td>
        <td><%= order.getPaymentMethodString()%></td>
        <td>Rs <%= String.format("%.2f", order.getTotalAmount()) %></td>
        <td><%= order.getAddress() %></td>
        <td><%= order.getTelephone() %></td>
        <td><%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(order.getOrderDate()) %></td>
        <td>
          <span class="<%= "Pending".equals(order.getStatus()) ? "badge-status-pending" : "badge-status-success" %>">
            <%= order.getStatus() %>
          </span>
        </td>
      </tr>
      <% } %>
      </tbody>
    </table>
  </div>
  <% } else { %>
  <div class="text-center text-muted">You haven't placed any orders yet.</div>
  <% } %>
</div>
<%@ include file="/views/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

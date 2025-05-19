<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.toyStore.model.Toymanagement.Toy" %>
<%@ page import="java.util.List" %>
<%@ page import="com.toyStore.model.PaymentManagement.PaymentMethod" %>
<%
  Toy toy = (Toy) request.getAttribute("toy");
  List<PaymentMethod> paymentMethods = (List<PaymentMethod>) request.getAttribute("paymentMethods");
  String success = request.getParameter("success");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Order Toy</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body {
      background: linear-gradient(120deg, #6c5ce7 0%, #fd79a8 100%);
      min-height: 100vh;
      color: #2d3436;
      font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
    }
    .order-card {
      background: rgba(255,255,255,0.92);
      border-radius: 26px;
      box-shadow: 0 14px 44px rgba(108,92,231,0.16);
      padding: 2.5rem 2rem;
      max-width: 480px;
      margin: 5rem auto 3rem auto;
      backdrop-filter: blur(16px);
      -webkit-backdrop-filter: blur(16px);
      border: 1.5px solid rgba(108,92,231,0.08);
    }
    .order-img {
      border-radius: 14px;
      object-fit: cover;
      max-height: 180px;
      box-shadow: 0 4px 16px rgba(0,0,0,0.07);
      background: #fff;
    }
    .order-title {
      color: #6c5ce7;
      font-weight: 700;
      letter-spacing: 0.03em;
      margin-bottom: 1.5rem;
      text-align: center;
      font-size: 2rem;
      text-shadow: 0 2px 6px rgba(108,92,231,0.13);
    }
    .toy-price {
      color: #fd5e53;
      font-size: 1.35rem;
      font-weight: 600;
      margin-top: 0.5rem;
    }
    .btn-modern {
      border-radius: 12px;
      font-weight: 600;
      letter-spacing: 0.03em;
      padding-left: 1.5em;
      padding-right: 1.5em;
      font-size: 1.07em;
      box-shadow: 0 4px 14px rgba(108,92,231,0.11);
      transition: background 0.2s, color 0.2s;
    }
    .btn-primary.btn-modern {
      background: linear-gradient(90deg, #6c5ce7 0%, #fd79a8 100%);
      border: none;
    }
    .btn-primary.btn-modern:hover {
      background: linear-gradient(90deg, #fd79a8 0%, #6c5ce7 100%);
    }
    .btn-outline-secondary.btn-modern {
      border: 2px solid #6c5ce7;
      color: #6c5ce7;
      background: none;
    }
    .btn-outline-secondary.btn-modern:hover {
      background: #6c5ce7;
      color: #fff;
    }
    .form-select:focus, .form-control:focus {
      border-color: #6c5ce7;
      box-shadow: 0 0 0 0.15rem rgba(108, 92, 231, 0.15);
    }
    .alert-success {
      border-radius: 10px;
      font-size: 1.05rem;
      margin-bottom: 1.5rem;
    }
  </style>
</head>
<body>
<%@ include file="/views/header.jsp" %>
<div class="order-card">
  <% if ("true".equals(success)) { %>
  <div class="alert alert-success alert-dismissible fade show" role="alert">
    <i class="fas fa-check-circle me-2"></i>
    <strong>Success!</strong> Your order has been placed.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <% } %>
  <h3 class="order-title"><i class="fas fa-shopping-cart me-2"></i>Order Toy</h3>
  <div class="mb-4 text-center">
    <img src="<%= request.getContextPath() + "/" + toy.getImagePath() %>" class="img-fluid order-img" alt="<%= toy.getName() %>">
    <div class="mt-3 fw-bold fs-5"><%= toy.getName() %></div>
    <div class="text-secondary mb-1"><%= toy.getDescription() %></div>
    <div class="toy-price">Rs <%= String.format("%.2f", toy.getPrice()) %></div>
  </div>
  <form method="post" action="<%= request.getContextPath() %>/order">
    <input type="hidden" name="toyId" value="<%= toy.getId() %>">
    <input type="hidden" name="price" value="<%= toy.getPrice() %>">
    <div class="mb-3">
      <label class="form-label">Select Payment Method</label>
      <select name="paymentMethod" class="form-select" required>
        <% if (paymentMethods != null && !paymentMethods.isEmpty()) { %>
        <% for (PaymentMethod pm : paymentMethods) { %>
        <option value="<%= pm.getCardType() %> - <%= pm.getCardNumber() %>">
          <%= pm.getCardType() %> - <%= pm.getCardNumber() %>
        </option>
        <% } %>
        <% } %>
        <option value="Cash on Delivery">Cash on Delivery</option>
      </select>
    </div>
    <div class="mb-3">
      <label class="form-label">Delivery Address</label>
      <textarea name="address" class="form-control" rows="2" required placeholder="Enter your delivery address"></textarea>
    </div>
    <div class="mb-3">
      <label class="form-label">Telephone Number</label>
      <input type="text" name="telephone" class="form-control" required placeholder="Enter your phone number">
    </div>
    <button type="submit" class="btn btn-primary btn-modern w-100 mt-2">
      <i class="fas fa-check me-1"></i>Place Order
    </button>
    <a href="<%= request.getContextPath() %>/" class="btn btn-outline-secondary btn-modern w-100 mt-2">
      <i class="fas fa-arrow-left me-1"></i>Back to Home
    </a>
  </form>
</div>
<%@ include file="/views/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

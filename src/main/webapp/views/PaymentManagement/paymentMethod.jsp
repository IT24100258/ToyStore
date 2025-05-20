<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.toyStore.model.PaymentManagement.PaymentMethod" %>
<%
  HttpSession usersession = request.getSession(false);
  String username = (usersession != null && usersession.getAttribute("username") != null)
          ? (String) usersession.getAttribute("username") : null;
  if (username == null) {
    response.sendRedirect(request.getContextPath() + "/login");
    return;
  }
  List<PaymentMethod> methods = (List<PaymentMethod>) request.getAttribute("methods");
%>
<!DOCTYPE html>
<html>
<head>
  <title>My Payment Methods</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body {
      background: linear-gradient(120deg, #f9fafb 0%, #f6f0f0 60%, #fd79a8 100%);
      font-family: 'Poppins', 'Segoe UI', Arial, sans-serif;
      color: #2d3436;
      min-height: 100vh;
    }
    .methods-card {
      background: rgba(255,255,255,0.93);
      border-radius: 28px;
      box-shadow: 0 12px 48px rgba(108,92,231,0.13);
      padding: 2.5rem 2rem 2rem 2rem;
      max-width: 600px;
      margin: 4rem auto 2rem auto;
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      border: 1.5px solid rgba(108,92,231,0.09);
    }
    .methods-title {
      color: #6c5ce7;
      font-weight: 800;
      margin-bottom: 2.2rem;
      letter-spacing: 0.04em;
      text-align: center;
      font-size: 2rem;
      text-shadow: 0 2px 6px rgba(108,92,231,0.10);
    }
    .card-method {
      background: #f6f6ff;
      border-radius: 16px;
      box-shadow: 0 2px 12px rgba(108,92,231,0.08);
      padding: 1.5rem 1.2rem;
      margin-bottom: 1.5rem;
      display: flex;
      align-items: center;
      gap: 1.2rem;
      transition: box-shadow 0.2s;
    }
    .card-method:hover {
      box-shadow: 0 8px 24px rgba(253,121,168,0.12);
    }
    .card-icon {
      font-size: 2.2rem;
      flex-shrink: 0;
      color: #6c5ce7;
      background: #fff;
      border-radius: 10px;
      box-shadow: 0 2px 8px rgba(108,92,231,0.08);
      padding: 0.7rem;
    }
    .method-details {
      flex-grow: 1;
      min-width: 0;
    }
    .method-details .fw-semibold {
      font-size: 1.15rem;
      color: #6c5ce7;
      font-weight: 700;
      margin-bottom: 0.2em;
      letter-spacing: 0.01em;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    .method-details .text-muted {
      font-size: 1.05rem;
      color: #555;
      margin-bottom: 0.1em;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    .method-details .text-secondary {
      font-size: 0.97rem;
      color: #777;
    }
    .btn-modern {
      border-radius: 12px;
      font-weight: 700;
      letter-spacing: 0.04em;
      font-size: 1.07rem;
      transition: background-color 0.2s, box-shadow 0.2s;
      box-shadow: 0 2px 8px rgba(253,121,168,0.08);
      padding: 0.6em 1.6em;
    }
    .btn-back {
      background: none;
      color: #6c5ce7;
      border: 2px solid #6c5ce7;
      transition: background 0.2s, color 0.2s, box-shadow 0.2s;
      font-weight: 700;
    }
    .btn-back:hover {
      background: #6c5ce7;
      color: #fff;
      box-shadow: 0 8px 20px rgba(108,92,231,0.13);
    }
    .btn-add {
      background: linear-gradient(90deg, #6c5ce7 0%, #fd79a8 100%);
      color: #fff;
      border: none;
    }
    .btn-add:hover {
      background: linear-gradient(90deg, #fd79a8 0%, #6c5ce7 100%);
      color: #fff;
    }
    @media (max-width: 600px) {
      .methods-card {
        padding: 1.2rem 0.5rem;
        margin: 2rem 0.5rem;
      }
      .card-method {
        flex-direction: column;
        align-items: flex-start;
        gap: 0.7rem;
        padding: 1.1rem 0.6rem;
      }
      .card-icon {
        font-size: 1.5rem;
        padding: 0.5rem;
      }
      .methods-title { font-size: 1.3rem; }
    }
  </style>
</head>
<body>
<%@ include file="/views/header.jsp" %>
<div class="methods-card">
  <h2 class="methods-title"><i class="fas fa-credit-card me-2"></i>My Payment Methods</h2>
  <% if (methods != null && !methods.isEmpty()) { %>
  <% for (PaymentMethod pm : methods) { %>
  <div class="card-method" tabindex="0" aria-label="Payment method: <%= pm.getCardType() %> ending with <%= pm.getCardNumber().substring(pm.getCardNumber().length() - 4) %>">
    <i class="card-icon
          <%= pm.getCardType().equalsIgnoreCase("Visa") ? "fab fa-cc-visa" :
              pm.getCardType().equalsIgnoreCase("MasterCard") ? "fab fa-cc-mastercard" :
              pm.getCardType().equalsIgnoreCase("Amex") ? "fab fa-cc-amex" :
              pm.getCardType().equalsIgnoreCase("Discover") ? "fab fa-cc-discover" : "fa fa-credit-card" %>"></i>
    <div class="method-details">
      <div class="fw-semibold"><%= pm.getCardHolder() %></div>
      <div class="text-muted"><%= pm.getCardType() %> &middot; <%= pm.getCardNumber() %></div>
      <div class="text-secondary">Exp: <%= pm.getExpiryMonth() %>/<%= pm.getExpiryYear() %></div>
    </div>
  </div>
  <% } %>
  <% } else { %>
  <div class="text-center text-muted mb-4" style="font-size:1.1rem;">No payment methods added yet.</div>
  <% } %>
  <div class="d-flex justify-content-between gap-3 mt-3">
    <a href="<%= request.getContextPath() %>/profile" class="btn btn-back btn-modern" aria-label="Back to Profile">
      <i class="fas fa-arrow-left me-2"></i>Back to Profile
    </a>
    <a href="<%= request.getContextPath() %>/addPaymentMethod" class="btn btn-add btn-modern" aria-label="Add Payment Method">
      <i class="fas fa-plus me-2"></i>Add Payment Method
    </a>
  </div>
</div>
<%@ include file="/views/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

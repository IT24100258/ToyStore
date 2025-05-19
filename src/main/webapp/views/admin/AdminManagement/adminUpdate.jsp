<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.toyStore.model.UserManagement.User" %>
<%
  HttpSession adminSession = request.getSession(false);
  User loggedUser = null;
  if (adminSession != null && adminSession.getAttribute("user") != null) {
    loggedUser = (User) adminSession.getAttribute("user");
    if (!"admin".equalsIgnoreCase(loggedUser.getRole())) {
      response.sendRedirect(request.getContextPath() + "/login");
      return;
    }
  } else {
    response.sendRedirect(request.getContextPath() + "/login");
    return;
  }
  String adminUsername = loggedUser.getUserName();
  String email = loggedUser.getEmail();
  String phoneNumber = loggedUser.getPhoneNumber();
  String address = loggedUser.getAddress();
%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Profile Update</title>
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
    .admin-glass {
      background: rgba(255,255,255,0.93);
      border-radius: 28px;
      box-shadow: 0 12px 48px rgba(108,92,231,0.13);
      padding: 2.5rem 2rem;
      max-width: 600px;
      margin: 4rem auto 2rem;
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      border: 1.5px solid rgba(108,92,231,0.09);
    }
    .admin-title {
      color: #6c5ce7;
      font-weight: 800;
      font-size: 2rem;
      letter-spacing: 0.03em;
      margin-bottom: 1.5em;
      text-align: center;
    }
    .form-label {
      color: #636e72;
      font-weight: 600;
    }
    .form-control, .form-control:focus {
      border-radius: 10px;
      border-color: #6c5ce7;
      box-shadow: 0 0 0 0.13rem rgba(108, 92, 231, 0.08);
    }
    .btn-save {
      background: linear-gradient(90deg, #6c5ce7 0%, #fd79a8 100%);
      color: #fff;
      font-weight: 700;
      border-radius: 10px;
      border: none;
      padding: 0.7em 2em;
      transition: background 0.2s;
    }
    .btn-save:hover {
      background: linear-gradient(90deg, #fd79a8 0%, #6c5ce7 100%);
    }
    .btn-back, .btn-dashboard {
      background: none;
      color: #6c5ce7;
      border: 2px solid #6c5ce7;
      font-weight: 700;
      border-radius: 10px;
      padding: 0.5em 1.3em;
      transition: background 0.2s, color 0.2s;
      text-decoration: none;
      display: inline-block;
    }
    .btn-back:hover, .btn-dashboard:hover {
      background: #6c5ce7;
      color: #fff;
    }
    .alert {
      border-radius: 8px;
    }
    @media (max-width: 600px) {
      .admin-glass { padding: 1.2rem 0.5rem; }
      .admin-title { font-size: 1.3rem; }
    }
  </style>
</head>
<body>
<%@ include file="/views/header.jsp" %>
<div class="admin-glass">
  <!-- Back to Dashboard button at the top -->
  <div class="mb-4 text-end">
    <a href="${pageContext.request.contextPath}/views/admin/AdminManagement/adminDashboard.jsp" class="btn-dashboard">
      <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
    </a>
  </div>
  <h3 class="admin-title"><i class="fas fa-user-shield me-2"></i>Update Admin Info</h3>
  <% String message = (String) request.getAttribute("message"); %>
  <% if (message != null) { %>
  <div class="alert alert-info">
    <i class="fas fa-info-circle me-2"></i><%= message %>
  </div>
  <% } %>
  <form action="${pageContext.request.contextPath}/admin/updateAdmin" method="POST">
    <div class="mb-3">
      <label for="adminUsername" class="form-label">Admin Username</label>
      <input type="text" class="form-control" id="adminUsername" name="adminUsername" value="<%= adminUsername %>" required>
    </div>
    <div class="mb-3">
      <label for="email" class="form-label">Email</label>
      <input type="email" class="form-control" id="email" name="email" value="<%= email %>" readonly>
    </div>
    <div class="mb-3">
      <label for="phoneNumber" class="form-label">Phone Number</label>
      <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="<%= phoneNumber != null ? phoneNumber : "" %>">
    </div>
    <div class="mb-3">
      <label for="address" class="form-label">Personal Address</label>
      <input type="text" class="form-control" id="address" name="address" value="<%= address != null ? address : "" %>">
    </div>
    <div class="mb-3">
      <label for="newPassword" class="form-label">New Password (leave blank to keep current)</label>
      <input type="password" class="form-control" id="newPassword" name="newPassword">
    </div>
    <div class="mb-4">
      <label for="confirmPassword" class="form-label">Confirm New Password</label>
      <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
    </div>
    <div class="d-flex justify-content-between">
      <a href="${pageContext.request.contextPath}/views/admin/AdminManagement/adminDashboard.jsp" class="btn-back">
        <i class="fas fa-arrow-left me-2"></i>Back
      </a>
      <button type="submit" class="btn btn-save">
        <i class="fas fa-save me-2"></i>Save Changes
      </button>
    </div>
  </form>
</div>
<%@ include file="/views/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
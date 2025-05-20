<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.toyStore.model.UserManagement.User" %>
<%
  HttpSession adminSession = request.getSession(false);
  User loggedUser = null;
  if (adminSession != null && adminSession.getAttribute("user") != null){
    loggedUser = (User) adminSession.getAttribute("user");
    if(!"admin".equalsIgnoreCase(loggedUser.getRole())){
      response.sendRedirect(request.getContextPath() + "/home.jsp");
      return;
    }
  } else {
    response.sendRedirect(request.getContextPath() + "/login");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Add New Admin</title>
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
      padding: 2.5rem 2rem 2.5rem 2rem;
      max-width: 650px;
      margin: 4rem auto 2rem auto;
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      border: 1.5px solid rgba(108,92,231,0.09);
    }
    .admin-title {
      color: #6c5ce7;
      font-weight: 800;
      font-size: 2rem;
      letter-spacing: 0.03em;
      margin-bottom: 0.5em;
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
    .form-label {
      color: #636e72;
      font-weight: 600;
    }
    .form-control, .form-control:focus {
      border-radius: 10px;
      border-color: #6c5ce7;
      box-shadow: 0 0 0 0.13rem rgba(108, 92, 231, 0.08);
    }
    .btn-add {
      background: linear-gradient(90deg, #6c5ce7 0%, #fd79a8 100%);
      color: #fff;
      font-weight: 700;
      border-radius: 10px;
      letter-spacing: 1px;
      border: none;
      padding: 0.7em 2em;
      transition: background 0.2s;
    }
    .btn-add:hover {
      background: linear-gradient(90deg, #fd79a8 0%, #6c5ce7 100%);
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
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="admin-title"><i class="fas fa-user-plus me-2"></i>Add New Admin</h3>
    <a href="${pageContext.request.contextPath}/views/admin/AdminManagement/adminDashboard.jsp" class="btn btn-back">
      <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
    </a>
  </div>
  <% String message = (String) request.getAttribute("message"); %>
  <% if (message != null) { %>
  <div class="alert alert-info mb-4">
    <i class="fas fa-info-circle me-2"></i><%= message %>
  </div>
  <% } %>
  <form action="${pageContext.request.contextPath}/registerAdmin" method="POST" autocomplete="off">
    <div class="row">
      <div class="col-md-6">
        <label for="username" class="form-label">Admin Username</label>
        <input type="text" class="form-control" id="username" name="username" required>
      </div>
      <div class="col-md-6">
        <label for="email" class="form-label">Email Address</label>
        <input type="email" class="form-control" id="email" name="email" required>
      </div>
    </div>
    <div class="row">
      <div class="col-md-6">
        <label for="number" class="form-label">Phone Number</label>
        <input type="text" class="form-control" id="number" name="number" required>
      </div>
      <div class="col-md-6">
        <label for="address" class="form-label">Personal Address</label>
        <input type="text" class="form-control" id="address" name="address" required>
      </div>
    </div>
    <div class="row">
      <div class="col-md-6">
        <label for="password" class="form-label">Password</label>
        <input type="password" class="form-control" id="password" name="password" required>
      </div>
      <div class="col-md-6">
        <label for="confirmPassword" class="form-label">Confirm Password</label>
        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
      </div>
    </div>
    <div class="d-flex justify-content-end mt-4">
      <button type="submit" class="btn btn-add px-4">
        <i class="fas fa-user-plus me-2"></i>Add Admin
      </button>
    </div>
  </form>
</div>
<%@ include file="/views/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.toyStore.model.UserManagement.User" %>

<%
  HttpSession usersession = request.getSession(false);
  User loggedUser = null;

  if (usersession != null && usersession.getAttribute("user") != null) {
    loggedUser = (User) usersession.getAttribute("user");
    if (!"admin".equalsIgnoreCase(loggedUser.getRole())) {
      response.sendRedirect("/home.jsp");
      return;
    }
  } else {
    response.sendRedirect("/login");
    return;
  }

  String username = loggedUser.getUserName();
  String email = loggedUser.getEmail();
  String role = loggedUser.getRole();
  String phoneNumber = loggedUser.getPhoneNumber();
  String address = loggedUser.getAddress();
%>

<!DOCTYPE html>
<html>
<head>
  <title>Admin Panel | <%= username %></title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    :root {
      --primary-color: #6c5ce7;
      --accent-color: #fd79a8;
      --bg-light: #f8f9fa;
      --card-bg: #ffffff;
      --text-primary: #2d3436;
      --text-secondary: #636e72;
    }
    body {
      background: linear-gradient(120deg, #f9fafb 0%, #f6f0f0 60%, #fd79a8 100%);
      min-height: 100vh;
      font-family: 'Poppins', 'Segoe UI', Arial, sans-serif;
      color: var(--text-primary);
    }
    .profile-container {
      padding: 2.5rem 1rem;
    }
    .profile-glass {
      background: rgba(255,255,255,0.93);
      border-radius: 28px;
      box-shadow: 0 12px 48px rgba(108,92,231,0.13);
      overflow: hidden;
      max-width: 600px;
      margin: 4rem auto 2rem auto;
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      border: 1.5px solid rgba(108,92,231,0.09);
      transition: transform 0.3s;
    }
    .profile-glass:hover {
      transform: translateY(-5px) scale(1.01);
    }
    .profile-header {
      background: linear-gradient(135deg, #6c5ce7, #fd79a8);
      color: white;
      padding: 2.5rem 1.5rem 1.5rem;
      text-align: center;
      border-radius: 28px 28px 0 0;
    }
    .profile-avatar {
      width: 110px;
      height: 110px;
      background: white;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 1.1rem;
      border: 5px solid rgba(255,255,255,0.3);
      box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    }
    .profile-avatar i {
      font-size: 48px;
      color: #6c5ce7;
    }
    .profile-header h3 {
      margin-bottom: 0.3rem;
      font-weight: 800;
    }
    .profile-header p {
      margin-bottom: 0;
      font-size: 1.1rem;
      letter-spacing: 0.01em;
    }
    .profile-body {
      padding: 2.2rem 2rem 1.2rem 2rem;
    }
    .info-item {
      display: flex;
      align-items: center;
      margin-bottom: 1.25rem;
      padding-bottom: 1.25rem;
      border-bottom: 1px solid #f1f1f1;
    }
    .info-item:last-child {
      border-bottom: none;
      margin-bottom: 0;
      padding-bottom: 0;
    }
    .info-icon {
      min-width: 44px;
      height: 44px;
      background-color: rgba(108, 92, 231, 0.11);
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 1.1rem;
      color: #6c5ce7;
      font-size: 1.3rem;
    }
    .info-content {
      flex-grow: 1;
    }
    .info-label {
      font-size: 0.8rem;
      text-transform: uppercase;
      letter-spacing: 0.05em;
      color: #636e72;
      margin-bottom: 0.25rem;
    }
    .info-value {
      font-weight: 600;
      color: #2d3436;
      word-break: break-word;
    }
    .profile-actions {
      padding: 1.5rem 2rem;
      background-color: #fafafa;
      border-top: 1px solid #f1f1f1;
    }
    .btn-profile {
      border-radius: 10px;
      padding: 0.75rem 1.5rem;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 0.05em;
      font-size: 0.97rem;
      transition: all 0.3s;
    }
    .btn-dashboard {
      background: linear-gradient(90deg, #6c5ce7 0%, #fd79a8 100%);
      color: #fff;
      border: none;
    }
    .btn-dashboard:hover {
      background: linear-gradient(90deg, #fd79a8 0%, #6c5ce7 100%);
      color: #fff;
    }
    .btn-logout {
      background: #b2bec3;
      border: none;
      color: #2d3436;
    }
    .btn-logout:hover {
      background: #636e72;
      color: #fff;
    }
    @media (max-width: 576px) {
      .profile-actions .btn {
        display: block;
        width: 100%;
        margin-bottom: 0.75rem;
      }
      .profile-actions .btn:last-child {
        margin-bottom: 0;
      }
    }
  </style>
</head>
<body>

<%@ include file="/views/header.jsp" %>

<div class="container profile-container">
  <div class="profile-glass">
    <div class="profile-header">
      <div class="profile-avatar">
        <i class="fas fa-user-shield"></i>
      </div>
      <h3><%= username %></h3>
      <p>Administrator</p>
    </div>
    <div class="profile-body">
      <div class="info-item">
        <div class="info-icon"><i class="fas fa-user"></i></div>
        <div class="info-content">
          <div class="info-label">Username</div>
          <div class="info-value"><%= username %></div>
        </div>
      </div>
      <div class="info-item">
        <div class="info-icon"><i class="fas fa-envelope"></i></div>
        <div class="info-content">
          <div class="info-label">Email</div>
          <div class="info-value"><%= email %></div>
        </div>
      </div>
      <div class="info-item">
        <div class="info-icon"><i class="fas fa-user-tag"></i></div>
        <div class="info-content">
          <div class="info-label">Role</div>
          <div class="info-value"><%= role %></div>
        </div>
      </div>
      <div class="info-item">
        <div class="info-icon"><i class="fas fa-phone"></i></div>
        <div class="info-content">
          <div class="info-label">Phone Number</div>
          <div class="info-value"><%= phoneNumber %></div>
        </div>
      </div>
      <div class="info-item">
        <div class="info-icon"><i class="fas fa-map-marker-alt"></i></div>
        <div class="info-content">
          <div class="info-label">Address</div>
          <div class="info-value"><%= address %></div>
        </div>
      </div>
    </div>
    <div class="profile-actions">
      <div class="d-flex flex-column flex-sm-row gap-2">
        <form action="${pageContext.request.contextPath}/views/admin/AdminManagement/adminDashboard.jsp" method="POST" class="flex-fill">
          <button type="submit" class="btn btn-dashboard btn-profile w-100">
            <i class="fas fa-chart-line me-2"></i> Dashboard
          </button>
        </form>
        <form action="${pageContext.request.contextPath}/logout" method="GET" class="flex-fill">
          <button type="submit" class="btn btn-logout btn-profile w-100">
            <i class="fas fa-sign-out-alt me-2"></i> Logout
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<%@ include file="/views/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

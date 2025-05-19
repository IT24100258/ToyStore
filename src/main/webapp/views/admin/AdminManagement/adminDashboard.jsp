<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.toyStore.model.UserManagement.User" %>
<%--<%@ page import="com.toyStore.model.OrderManagement.Order" %>--%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.toyStore.util.UserManagement.FileUtil" %>
<%@ page import="com.toyStore.util.adminManegment.AdminFileUtil" %>
<%
  HttpSession usersession = request.getSession(false);
  User loggedUser = null;
  if (usersession != null && usersession.getAttribute("user") != null) {
    loggedUser = (User) usersession.getAttribute("user");
    if (!"admin".equalsIgnoreCase(loggedUser.getRole())) {
      response.sendRedirect(request.getContextPath() + "/home.jsp");
      return;
    }
  } else {
    response.sendRedirect(request.getContextPath() + "/login");
    return;
  }
  List<User> admins = AdminFileUtil.getAdmins();
  List<User> users = FileUtil.getUsers();
//  List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard | <%= loggedUser.getUserName() %></title>
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
    .dashboard-glass {
      background: rgba(255,255,255,0.93);
      border-radius: 28px;
      box-shadow: 0 12px 48px rgba(108,92,231,0.13);
      padding: 2.5rem 2rem;
      max-width: 1200px;
      margin: 4rem auto 2rem auto;
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      border: 1.5px solid rgba(108,92,231,0.09);
    }
    .dashboard-header {
      background: linear-gradient(135deg, #6c5ce7, #fd79a8);
      color: white;
      padding: 2rem 1.5rem 1.5rem;
      text-align: center;
      border-radius: 22px 22px 0 0;
      margin-bottom: 2rem;
    }
    .dashboard-header h2 {
      margin-bottom: 0.5rem;
      font-weight: 800;
    }
    .dashboard-actions {
      padding: 1.5rem 0 1rem 0;
      display: flex;
      gap: 1rem;
      flex-wrap: wrap;
      justify-content: flex-end;
    }
    .dashboard-actions .btn {
      min-width: 150px;
      font-weight: 700;
      border-radius: 10px;
      letter-spacing: 0.03em;
      box-shadow: 0 2px 8px rgba(253,121,168,0.09);
    }
    .btn-primary {
      background: linear-gradient(90deg, #6c5ce7 0%, #fd79a8 100%);
      border: none;
    }
    .btn-success {
      background: linear-gradient(90deg, #00b894 0%, #6c5ce7 100%);
      border: none;
      color: #fff;
    }
    .btn-info {
      background: linear-gradient(90deg, #fd79a8 0%, #6c5ce7 100%);
      border: none;
      color: #fff;
    }
    .btn-secondary {
      background: #b2bec3;
      color: #2d3436;
    }
    .btn-secondary:hover {
      background: #636e72;
      color: #fff;
    }
    .section-title {
      color: #6c5ce7;
      margin-top: 2rem;
      margin-bottom: 1rem;
      font-weight: 800;
      font-size: 1.3rem;
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
    .action-btns .btn {
      margin-right: 0.5rem;
    }
    @media (max-width: 991px) {
      .dashboard-glass { padding: 1.2rem 0.5rem; }
      .table-responsive { font-size: 0.98em; }
      .dashboard-header { font-size: 1.1rem; }
    }
  </style>
</head>
<body>
<%@ include file="/views/header.jsp" %>
<div class="dashboard-glass">
  <div class="dashboard-header">
    <h2><i class="fas fa-user-shield me-2"></i>Admin Dashboard</h2>
    <div>Welcome, <b><%= loggedUser.getUserName() %></b>!</div>
  </div>
  <div class="dashboard-actions">
    <a href="${pageContext.request.contextPath}/views/admin/toyManagement" class="btn btn-primary">
      <i class="fa-solid fa-warehouse me-2"></i>Inventory
    </a>
    <a href="${pageContext.request.contextPath}/views/admin/AdminManagement/addNewAdmin.jsp" class="btn btn-success">
      <i class="fas fa-user-plus me-2"></i>Add New Admin
    </a>
    <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-info">
      <i class="fas fa-boxes me-2"></i>Orders
    </a>
    <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">
      <i class="fas fa-sign-out-alt me-2"></i>Logout
    </a>
  </div>

  <h4 class="section-title"><i class="fas fa-users-cog me-2"></i>Admin Accounts</h4>
  <div class="table-responsive mb-4">
    <table class="table table-striped align-middle">
      <thead>
      <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Address</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <% if (admins != null && !admins.isEmpty()) {
        for (User admin : admins) { %>
      <tr>
        <td><%= admin.getId() %></td>
        <td><%= admin.getUserName() %></td>
        <td><%= admin.getEmail() %></td>
        <td><%= admin.getPhoneNumber() %></td>
        <td><%= admin.getAddress() %></td>
        <td class="action-btns">
          <a href="${pageContext.request.contextPath}/views/admin/AdminManagement/adminUpdate.jsp?email=<%= admin.getEmail() %>" class="btn btn-warning btn-sm">
            <i class="fas fa-edit"></i> Update
          </a>
        </td>
      </tr>
      <%  }
      } else { %>
      <tr><td colspan="6" class="text-center text-muted">No admins found.</td></tr>
      <% } %>
      </tbody>
    </table>
  </div>

  <h4 class="section-title"><i class="fas fa-users me-2"></i>User Accounts</h4>
  <div class="table-responsive">
    <table class="table table-striped align-middle">
      <thead>
      <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Address</th>
      </tr>
      </thead>
      <tbody>
      <% if (users != null && !users.isEmpty()) {
        for (User user : users) { %>
      <tr>
        <td><%= user.getId() %></td>
        <td><%= user.getUserName() %></td>
        <td><%= user.getEmail() %></td>
        <td><%= user.getPhoneNumber() %></td>
        <td><%= user.getAddress() %></td>
      </tr>
      <%  }
      } else { %>
      <tr><td colspan="5" class="text-center text-muted">No users found.</td></tr>
      <% } %>
      </tbody>
    </table>
  </div>
</div>
<%@ include file="/views/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

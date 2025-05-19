<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.toyStore.model.UserManagement.User" %>

<%
    HttpSession userSession = request.getSession(false);
    User loggedUser = null;

    if (userSession != null && userSession.getAttribute("user") != null){
        loggedUser = (User) userSession.getAttribute("user");
    }else{
        response.sendRedirect("/login");
        return;
    }

    String username = loggedUser.getUserName();
    String email = loggedUser.getEmail();
    String address = loggedUser.getAddress();
    String phoneNumber = loggedUser.getPhoneNumber();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Profile | <%= username %></title>
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
            color: var(--text-primary);
            font-family: 'Poppins', 'Segoe UI', Arial, sans-serif;
            min-height: 100vh;
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
        .form-floating {
            margin-bottom: 1.25rem;
        }
        .form-floating > label {
            color: var(--text-secondary);
        }
        .form-control {
            border-radius: 10px;
            border: 1px solid #e0e0e0;
            padding: 0.75rem 1rem;
            height: auto;
            font-size: 1rem;
            box-shadow: none;
            transition: all 0.3s;
        }
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(108, 92, 231, 0.25);
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
        .btn-update {
            background: linear-gradient(90deg, #6c5ce7 0%, #fd79a8 100%);
            border: none;
            color: #fff;
        }
        .btn-update:hover {
            background: linear-gradient(90deg, #fd79a8 0%, #6c5ce7 100%);
            color: #fff;
        }
        .btn-back {
            background-color: #b2bec3;
            border: none;
            color: #2d3436;
        }
        .btn-back:hover {
            background-color: #a0aab1;
            color: #fff;
        }
        .action-buttons {
            display: grid;
            grid-template-columns: 1fr;
            gap: 12px;
            margin-top: 1.5rem;
        }
        .alert {
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            border: none;
        }
        .alert-info {
            background-color: rgba(108, 92, 231, 0.1);
            color: var(--primary-color);
        }
        @media (max-width: 600px) {
            .profile-glass { padding: 1.2rem 0.5rem; }
            .profile-header { font-size: 1.3rem; }
        }
    </style>
</head>
<body>

<%@ include file="/views/header.jsp" %>

<div class="container profile-container">
    <div class="profile-glass">
        <div class="profile-header">
            <div class="profile-avatar">
                <i class="fas fa-user-edit"></i>
            </div>
            <h3 class="mb-1">Update Profile</h3>
            <p class="mb-0">Edit your account information</p>
        </div>
        <div class="profile-body">
            <% String message = (String) request.getAttribute("message"); %>
            <% if (message != null) { %>
            <div class="alert alert-info">
                <i class="fas fa-info-circle me-2"></i><%= message %>
            </div>
            <% } %>
            <form action="${pageContext.request.contextPath}/updateProfile" method="POST">
                <div class="form-floating mb-3">
                    <input type="text" id="username" name="username" class="form-control" value="<%= username%>" required>
                    <label for="username"><i class="fas fa-user me-2"></i>Username</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="email" id="email" name="email" class="form-control" value="<%= email%>" required>
                    <label for="email"><i class="fas fa-envelope me-2"></i>Email</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="text" id="address" name="address" class="form-control" value="<%= address%>" required>
                    <label for="address"><i class="fas fa-map-marker-alt me-2"></i>Address</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="text" id="phoneNumber" name="phoneNumber" class="form-control" value="<%= phoneNumber%>" required>
                    <label for="phoneNumber"><i class="fas fa-phone me-2"></i>Phone Number</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="password" id="newPassword" name="newPassword" class="form-control">
                    <label for="newPassword"><i class="fas fa-lock me-2"></i>New Password</label>
                </div>
                <div class="form-floating mb-4">
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control">
                    <label for="confirmPassword"><i class="fas fa-lock me-2"></i>Confirm New Password</label>
                </div>
                <div class="action-buttons">
                    <button type="submit" class="btn btn-profile btn-update">
                        <i class="fas fa-save me-2"></i> Save Changes
                    </button>
                    <a href="${pageContext.request.contextPath}/views/UserManagement/profile.jsp" class="btn btn-profile btn-back">
                        <i class="fas fa-arrow-left me-2"></i> Back to Profile
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="/views/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

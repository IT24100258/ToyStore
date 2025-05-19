<%--
  Created by IntelliJ IDEA.
  User: Tuf
  Date: 3/29/2025
  Time: 6:30 PM
  To change this template use File | Settings | File Templates.
--%>
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
    String password = loggedUser.getPassword();
%>

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
            background-color: var(--bg-light);
            color: var(--text-primary);
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        .profile-container {
            padding: 2rem 1rem;
        }

        .profile-card {
            background: var(--card-bg);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s;
        }

        .profile-card:hover {
            transform: translateY(-5px);
        }

        .profile-header {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            padding: 2.5rem 1.5rem 1.5rem;
            color: white;
            text-align: center;
            position: relative;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            background-color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            border: 4px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .profile-avatar i {
            font-size: 40px;
            color: var(--primary-color);
        }

        .profile-body {
            padding: 2rem;
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
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            font-size: 0.9rem;
            transition: all 0.3s;
        }

        .btn-update {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-update:hover {
            background-color: #5a4ccf;
            border-color: #5a4ccf;
        }

        .btn-back {
            background-color: #b2bec3;
            border-color: #b2bec3;
            color: #2d3436;
        }

        .btn-back:hover {
            background-color: #a0aab1;
            border-color: #a0aab1;
        }

        .action-buttons {
            display: grid;
            grid-template-columns: 1fr;
            gap: 12px;
            margin-top: 1.5rem;
        }

        .input-group-text {
            background-color: #f8f9fa;
            border-radius: 10px 0 0 10px;
            border: 1px solid #e0e0e0;
            border-right: none;
        }

        .password-field {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--text-secondary);
            cursor: pointer;
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
    </style>
</head>
<body>

<%@ include file="/views/header.jsp" %>

<div class="container profile-container">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            <div class="profile-card">
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
                        <div class="mb-3">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <div class="form-floating flex-grow-1">
                                    <input type="text" id="username" name="username" class="form-control" value="<%= username%>" required>
                                    <label for="username">Username</label>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                <div class="form-floating flex-grow-1">
                                    <input type="email" id="email" name="email" class="form-control" value="<%= email%>" required>
                                    <label for="email">Email</label>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                <div class="form-floating flex-grow-1">
                                    <input type="text" id="address" name="address" class="form-control" value="<%= address%>" required>
                                    <label for="address">Address</label>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                <div class="form-floating flex-grow-1">
                                    <input type="text" id="phoneNumber" name="phoneNumber" class="form-control" value="<%= phoneNumber%>" required>
                                    <label for="phoneNumber">Phone Number</label>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <div class="form-floating flex-grow-1 password-field">
                                    <input type="password" id="newPassword" name="newPassword" class="form-control">
                                    <label for="newPassword">New Password</label>
                                </div>
                            </div>
                            <small class="text-muted ms-4">Leave blank to keep current password</small>
                        </div>

                        <div class="mb-3">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <div class="form-floating flex-grow-1 password-field">
                                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control">
                                    <label for="confirmPassword">Confirm New Password</label>
                                </div>
                            </div>
                        </div>

                        <div class="action-buttons">
                            <button type="submit" class="btn btn-primary btn-profile btn-update">
                                <i class="fas fa-save me-2"></i> Save Changes
                            </button>

                            <a href="${pageContext.request.contextPath}/views/UserManagement/profile.jspent/profile.jsp" class="btn btn-secondary btn-profile btn-back">
                                <i class="fas fa-arrow-left me-2"></i> Back to Profile
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/views/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
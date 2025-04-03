<%--
  Created by IntelliJ IDEA.
  User: Tuf
  Date: 3/24/2025
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.toyStore.model.UserManagement.User" %>

<%
    HttpSession usersession = request.getSession(false);
    User loggedUser = null;

    if(usersession != null && usersession.getAttribute("user") != null){
        loggedUser = (User) usersession.getAttribute("user");
    }else{
        response.sendRedirect("/login");
        return;
    }

    String username = loggedUser.getUserName();
    String email = loggedUser.getEmail();
    String address = loggedUser.getAddress();
    String phoneNumber = loggedUser.getPhoneNumber();
    String role = loggedUser.getRole();
%>

<html>
<head>
    <title>Profile | <%= username %></title>
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
            min-width: 40px;
            height: 40px;
            background-color: rgba(108, 92, 231, 0.1);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            color: var(--primary-color);
        }

        .info-content {
            flex-grow: 1;
        }

        .info-label {
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--text-secondary);
            margin-bottom: 0.25rem;
        }

        .info-value {
            font-weight: 500;
            color: var(--text-primary);
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
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            font-size: 0.9rem;
            transition: all 0.3s;
        }

        .btn-delete {
            background-color: #ff7675;
            border-color: #ff7675;
        }

        .btn-delete:hover {
            background-color: #e06462;
            border-color: #e06462;
        }

        .btn-logout {
            background-color: #b2bec3;
            border-color: #b2bec3;
            color: #2d3436;
        }

        .btn-logout:hover {
            background-color: #a0aab1;
            border-color: #a0aab1;
        }

        .btn-orders {
            background-color: #00b894;
            border-color: #00b894;
        }

        .btn-orders:hover {
            background-color: #00a382;
            border-color: #00a382;
        }

        .profile-quick-actions {
            margin-bottom: 1.5rem;
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
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            <div class="profile-card">
                <div class="profile-header">
                    <div class="profile-avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <h3 class="mb-1"><%= username %></h3>
                    <p class="mb-0">Toy Store Member</p>
                </div>

                <div class="profile-body">
                    <!-- Quick actions section -->
                    <div class="profile-quick-actions text-center mb-4">
                        <a href="${pageContext.request.contextPath}/orders" class="btn btn-success btn-profile btn-orders">
                            <i class="fas fa-box me-2"></i> View My Orders
                        </a>
                    </div>

                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Username</div>
                            <div class="info-value"><%= username %></div>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Email</div>
                            <div class="info-value">
                                <a href="mailto:<%= email %>" class="text-decoration-none"><%= email %></a>
                            </div>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Address</div>
                            <div class="info-value"><%= address %></div>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Phone Number</div>
                            <div class="info-value"><%= phoneNumber %></div>
                        </div>
                    </div>
                </div>

                <div class="profile-actions">
                    <div class="d-flex flex-column flex-sm-row gap-2">
                        <form action="${pageContext.request.contextPath}/views/UserManagement/updateProfile.jsp" method="POST" class="flex-fill">
                            <input type="hidden" name="email" value="<%= email %>">
                            <button type="submit" class="btn btn-danger btn-profile btn-delete w-100">
                                <i class="fas fa-trash-alt me-2"></i> Update Profile
                            </button>
                        </form>

                        <form action="${pageContext.request.contextPath}/views/UserManagement/deleteProfile.jsp" method="POST" class="flex-fill">
                            <input type="hidden" name="email" value="<%= email %>">
                            <button type="submit" class="btn btn-danger btn-profile btn-delete w-100">
                                <i class="fas fa-trash-alt me-2"></i> Delete Account
                            </button>
                        </form>

                        <form action="${pageContext.request.contextPath}/logout" method="GET" class="flex-fill">
                            <button type="submit" class="btn btn-secondary btn-profile btn-logout w-100">
                                <i class="fas fa-sign-out-alt me-2"></i> Log Out
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/views/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
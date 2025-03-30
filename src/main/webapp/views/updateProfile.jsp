<%--
  Created by IntelliJ IDEA.
  User: Tuf
  Date: 3/29/2025
  Time: 6:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.toyStore.model.User" %>

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
    <title>Update Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .update-profile-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            width: 80%;
            max-width: 600px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>

<%@ include file="/views/header.jsp" %>

<div class="container d-flex justify-content-center">
    <div class="update-profile-card p-4">
        <h2 class="fw-bold text-center">Update Profile</h2>

        <% String message = (String) request.getAttribute("message"); %>
        <% if (message != null) { %>
        <div class="alert alert-info"><%= message %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/updateProfile" method="POST">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" id="username" name="username" class="form-control" value="<%= username%>" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" id="email" name="email" class="form-control" value="<%= email%>"  required>
            </div>

            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <input type="text" id="address" name="address" class="form-control" value="<%= address%>" required>
            </div>

            <div class="mb-3">
                <label for="phoneNumber" class="form-label">Phone Number</label>
                <input type="text" id="phoneNumber" name="phoneNumber" class="form-control" value="<%= phoneNumber%>" required>
            </div>

            <div class="mb-3">
                <label for="newPassword" class="form-label">New Password: </label>
                <input type="password" id="newPassword" name="newPassword" class="form-control">
            </div>

            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Confirm New Password: </label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control">
            </div>

            <button type="submit" class="btn btn-primary w-100">Update Profile</button>
        </form>

        <a href="profile.jsp" class="btn btn-secondary w-100 mt-3">Back to Profile</a>
    </div>
</div>

<%@ include file="/views/footer.jsp" %>

</body>
</html>

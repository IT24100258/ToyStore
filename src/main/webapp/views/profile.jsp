<%--
  Created by IntelliJ IDEA.
  User: Tuf
  Date: 3/24/2025
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.toyStore.model.User" %>

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
%>

<html>
<head>
    <title>Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .profile-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            width: 80%;
            max-width: 900px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        .profile-icon {
            font-size: 70px;
            color: gray;
        }
        .btn-custom {
            width: 100%;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<%@ include file="/views/header.jsp" %>

<div class="container d-flex justify-content-center">
    <div class="profile-card p-4">
        <h2 class="fw-bold">Profile</h2>
        <div class="profile-icon">👤</div>
        <h4 class="fw-bold"><%= username %></h4>

        <hr>

        <div class="text-start">
            <p><strong>Username:</strong> <%= username %></p>
            <p><strong>Email:</strong> <a href="mailto:<%= email %>"><%= email %></a></p>
            <p><strong>Address:</strong> <%= address %></p>
            <p><strong>Phone Number:</strong> <%= phoneNumber %></p>
        </div>

        <div class="d-flex flex-column">
            <a href="${pageContext.request.contextPath}/views/updateProfile.jsp" class="btn btn-primary btn-custom">Edit Information</a>
            <form action="${pageContext.request.contextPath}/views/deleteProfile.jsp" method="POST">
                <input type="hidden" name="email" value="<%= email %>">
                <button type="submit" class="btn btn-danger btn-custom">Delete Profile</button>
            </form>
        </div>

        <form action="${pageContext.request.contextPath}/logout" method="GET" class="mt-3">
            <button type="submit" class="btn btn-secondary btn-custom">Log Out</button>
        </form>
    </div>
</div>

<%@ include file="/views/footer.jsp" %>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*" %>
<%
    String toy = request.getParameter("toy");
    String reviewFilePath = "";
    String displayName = "";

    if ("ToyCar".equalsIgnoreCase(toy)) {
        displayName = "Toy Car";
        reviewFilePath = application.getRealPath("/data/ToyCar.txt");
    } else if ("DollHouse".equalsIgnoreCase(toy)) {
        displayName = "Doll House";
        reviewFilePath = application.getRealPath("/data/DollHouse.txt");
    } else if ("Building".equalsIgnoreCase(toy)) {
        displayName = "Building Blocks";
        reviewFilePath = application.getRealPath("/data/Building.txt");
    }

    StringBuilder allData = new StringBuilder();
    try (BufferedReader reader = new BufferedReader(new FileReader(reviewFilePath))) {
        String line;
        while ((line = reader.readLine()) != null) {
            allData.append(line).append("<br>");
        }
    } catch (Exception e) {
        allData.append("No reviews available for this toy.");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View More - <%= displayName %></title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: rgba(255, 199, 217, 0.27);
            min-height: 100vh;
            font-family: 'Arial', sans-serif;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .content-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            width: 70%;
            padding: 2rem;
            margin: auto;
            height: auto;
        }

        .content-title {
            font-size: 1.5rem;
            font-weight: bold;
            color: #343a40;
        }

        .content-text {
            font-size: 1.1rem;
            color: #6c757d;
            margin-bottom: 1rem;
        }

        .btn-back {
            background: white;
            color: black;
            border: none;
            border-radius: 20px;
            padding: 0.6rem 1.5rem;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="content-card">
    <h1 class="content-title">Reviews || All from verified purchases <br> <%= displayName %></h1>
    <div class="content-text">
        <%= allData.toString() %>
    </div>
    <a href="${pageContext.request.contextPath}/views/home.jsp" class="btn btn-back">⬅ Back to Home</a>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

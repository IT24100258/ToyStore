<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.toyStore.model.Toymanagement.Toy" %>
<%@ page import="com.toyStore.model.ReviewManagement.Review" %>
<%@ page import="java.util.List" %>
<%
    Toy toy = (Toy) request.getAttribute("toy");
    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View More - <%= toy.getName() %></title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            /* Do NOT use flex here */
        }
        .viewmore-page {
            min-height: 100vh;
            width: 100%;
            background: rgba(255, 199, 217, 0.27);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .viewmore-page .content-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            width: 70%;
            padding: 2rem;
            margin: auto;
            height: auto;
        }
        .viewmore-page .content-title {
            font-size: 1.5rem;
            font-weight: bold;
            color: #343a40;
            margin-bottom: 2rem;
        }
        .viewmore-page .review-item {
            margin-top: 1rem;
            font-size: 1rem;
            color: #343a40;
            background: #f8f9fa;
            border-radius: 12px;
            padding: 1em 1.2em;
            box-shadow: 0 2px 8px rgba(253,121,168,0.07);
            border-left: 5px solid #fd79a8;
        }
        .viewmore-page .reviewer {
            color: #6c5ce7;
            font-weight: 600;
            font-size: 1.05em;
        }
        .viewmore-page .btn-back {
            background: white;
            color: black;
            border: none;
            border-radius: 20px;
            padding: 0.6rem 1.5rem;
            font-weight: bold;
            margin-top: 2rem;
        }
    </style>
</head>
<body>
<%@ include file="/views/header.jsp" %>
<div class="viewmore-page">
    <div class="content-card">
        <h1 class="content-title">Reviews || All from verified purchases<br> <%= toy.getName() %></h1>
        <div>
            <%
                if (reviews != null && !reviews.isEmpty()) {
                    for (Review review : reviews) {
            %>
            <div class="review-item">
                <span class="reviewer"><i class="fas fa-user"></i> <%= review.getReviewer().getUserName() %></span>
                <span style="margin-left:1em; color:#ffc107;">
                    <% for(int i=0;i<review.getRating();i++) { %>★<% } %>
                </span>
                <div class="mt-1"><%= review.getContent() %></div>
            </div>
            <%   }
            } else { %>
            <div class="review-item text-muted">No reviews yet. Be the first to review!</div>
            <% } %>
        </div>
        <a href="<%= request.getContextPath() %>/product?id=<%= toy.getId() %>" class="btn btn-back">⬅ Back to Product</a>

    </div>
</div>
<%@ include file="/views/footer.jsp" %>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

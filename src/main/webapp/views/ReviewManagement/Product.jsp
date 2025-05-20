<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.toyStore.model.Toymanagement.Toy" %>
<%@ page import="com.toyStore.model.UserManagement.User" %>
<%@ page import="com.toyStore.model.ReviewManagement.Review" %>
<%@ page import="java.util.List" %>
<%
  Toy toy = (Toy) request.getAttribute("toy");
  List<Review> reviews = (List<Review>) request.getAttribute("reviews");
  HttpSession session1 = session;
  User user = (session1 != null) ? (User) session1.getAttribute("user") : null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title><%= toy.getName() %> Details</title>
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    /* Only general resets for body */
    body {
      margin: 0;
      padding: 0;
      font-family: 'Arial', sans-serif;
    }
    /* All product page styles are scoped under .product-page */
    .product-page {
      background: linear-gradient(135deg, #845ff8, #ed6363);
      min-height: 100vh;
      font-family: 'Arial', sans-serif;
      display: flex;
      align-items: center;
      justify-content: center;
      width: 100%;
    }
    .product-page .product-card {
      background: white;
      border-radius: 15px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
      width: 70%;
      padding:1.5rem;
      margin: auto;
      min-height:500px ;
    }
    .product-page .product-title {
      font-size: 2rem;
      font-weight: bold;
      color: #343a40;
    }
    .product-page .product-description {
      font-size: 1.1rem;
      color: #6c757d;
      margin-bottom: 1rem;
    }
    .product-page .badge-age {
      background-color: #ff6384;
      color: white;
      border-radius: 20px;
      padding: 0.4rem 0.8rem;
      font-size: 0.9rem;
      margin-right: 10px;
    }
    .product-page .product-price {
      background-color: #ff6384;
      color: white;
      border-radius: 20px;
      padding: 0.4rem 0.8rem;
      font-size: 1.2rem;
    }
    .product-page .btn-order {
      background: linear-gradient(90deg, #6f42c1, #f01a8d);
      color: white;
      border: none;
      border-radius: 20px;
      padding: 0.6rem 1.5rem;
      font-weight: bold;
      margin-top: 1.75rem;
    }
    .product-page .btn-secondary {
      background: white;
      color: black;
      border: 1px solid #ddd;
      border-radius: 20px;
      padding: 0.6rem 1.5rem;
    }
    .product-page .btn-add-review {
      background: #007bff;
      color: white;
      border-radius: 20px;
      padding: 0.6rem 1.5rem;
      margin-left: 2rem;
    }
    .product-page .reviews-title {
      font-size: 1.5rem;
      color: #6f42c1;
      font-weight: bold;
    }
    .product-page .review-item {
      margin-top: 1rem;
      font-size: 1rem;
      color: #343a40;
      background: #f8f9fa;
      border-radius: 12px;
      padding: 1em 1.2em;
      box-shadow: 0 2px 8px rgba(253,121,168,0.07);
      border-left: 5px solid #fd79a8;
    }
    .product-page .reviewer {
      color: #6c5ce7;
      font-weight: 600;
      font-size: 1.05em;
    }
    .product-page .product-image img {
      max-width: 100%;
      border-radius: 10px;
    }
    .product-page .back-to-home {
      display: inline-block;
      color: #343a40;
      margin-top:2rem;
    }
    .product-page .badge-like{
      margin-top: 1rem;
      font-size: 1rem;
    }
    .product-page .btn-viewmore{
      background: #ffffff;
      border-radius: 0;
      padding: 0.4rem 1rem;
    }
    @media (max-width: 767px) {
      .product-page .product-card { width: 98%; padding: 0.8rem; }
      .product-page .btn-add-review { margin-left: 0.5rem; }
    }
  </style>
</head>
<body>
<%@ include file="/views/header.jsp" %>
<div class="product-page">
  <div class="product-card">
    <div class="row">
      <!-- Image Section -->
      <div class="col-md-4 text-center">
        <div class="product-image">
          <img src="<%= request.getContextPath() + "/" + toy.getImagePath() %>"
               alt="<%= toy.getName() %>" class="img-fluid">
        </div>
      </div>
      <!-- Info Section -->
      <div class="col-md-8">
        <h1 class="product-title"><%= toy.getName() %></h1>
        <p class="product-description"><%= toy.getDescription() %></p>
        <span class="badge badge-age"><%= toy.getAgeGroup() %>+</span>
        <span class="product-price">Rs <%= String.format("%.2f", toy.getPrice()) %></span><br>
        <a href="<%= request.getContextPath() %>/order?toyId=<%= toy.getId() %>" class="btn btn-order ml-3">🛒 Order Now</a>
        <br>
        <div class="reviews-title mt-4">Latest Review</div>
        <div>
          <%
            if (reviews != null && !reviews.isEmpty()) {
              Review latestReview = reviews.get(0); // Only the latest review
          %>
          <div class="review-item">
            <span class="reviewer"><i class="fas fa-user"></i> <%= latestReview.getReviewer().getUserName() %></span>
            <span style="margin-left:1em; color:#ffc107;">
              <% for(int i=0;i<latestReview.getRating();i++) { %>★<% } %>
            </span>
            <div class="mt-1"><%= latestReview.getContent() %></div>
          </div>
          <% } else { %>
          <div class="review-item text-muted">No reviews yet. Be the first to review!</div>
          <% } %>
        </div>
        <span class="badge badge-like"><%= (reviews != null ? reviews.size() : 0) %> people like this product!</span>
        <a href="<%= request.getContextPath() %>/viewMoreReviews?toyId=<%= toy.getId() %>" class="btn btn-viewmore">Show More</a><br>
        <a href="<%= request.getContextPath() %>/" class="btn-secondary back-to-home">⬅ Back to Home</a>
        <% if (user != null) { %>
        <a href="<%= request.getContextPath() %>/addReview?toyId=<%= toy.getId() %>"
           class="btn btn-add-review">✍️ Add Review</a>
        <% } %>
      </div>
    </div>
  </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<%@ include file="/views/footer.jsp" %>
</body>
</html>

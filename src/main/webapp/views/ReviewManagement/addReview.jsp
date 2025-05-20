<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.toyStore.model.UserManagement.User" %>
<%
  Integer toyId = (request.getAttribute("toyId") != null) ? Integer.parseInt(request.getAttribute("toyId").toString()) : 0;
  String toyName = (String) request.getAttribute("toyName");
  User user = (session != null) ? (User) session.getAttribute("user") : null;
  String userEmail = (user != null && user.getEmail() != null) ? user.getEmail() : "Guest";
  String error = (String) request.getAttribute("error");
  String content = request.getParameter("content") != null ? request.getParameter("content") : (String) request.getAttribute("content");
  String ratingStr = request.getParameter("rating") != null ? request.getParameter("rating") : (String) request.getAttribute("rating");
  int rating = 0;
  try { rating = Integer.parseInt(ratingStr); } catch (Exception e) { rating = 0; }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Review for <%= toyName != null ? toyName : "toy" %></title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(135deg, #7f5af0, #f46060);
      min-height: 100vh;
      font-family: 'Arial', sans-serif;
      margin: 0;
      padding: 0;
    }
    .review-page {
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .review-container {
      background: white;
      padding: 2.5rem;
      border-radius: 15px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 600px;
    }
    .review-header {
      color: #7f5af0;
      margin-bottom: 1.5rem;
      text-align: center;
      font-weight: 600;
    }
    .form-label {
      font-weight: 500;
      color: #495057;
      margin-bottom: 0.5rem;
    }
    .form-control {
      border-radius: 8px;
      border: 1px solid #ced4da;
      padding: 0.75rem;
      transition: border-color 0.3s;
    }
    .form-control:focus {
      border-color: #7f5af0;
      box-shadow: 0 0 0 0.25rem rgba(127, 90, 240, 0.25);
    }
    .star-rating {
      display: flex;
      justify-content: center;
      margin: 1.5rem 0;
      gap: 0.5rem;
    }
    .star {
      font-size: 2rem;
      color: #e0e0e0;
      cursor: pointer;
      transition: all 0.2s;
    }
    .star:hover {
      transform: scale(1.1);
    }
    .star.selected {
      color: #ffc107;
    }
    .btn-submit {
      background: linear-gradient(to right, #7f5af0, #f46060);
      color: white;
      border: none;
      padding: 0.75rem 1.5rem;
      border-radius: 8px;
      font-weight: 600;
      transition: all 0.3s;
    }
    .btn-submit:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }
    .btn-cancel {
      background: #6c757d;
      color: white;
      border: none;
      padding: 0.75rem 1.5rem;
      border-radius: 8px;
      font-weight: 600;
      transition: all 0.3s;
    }
    .btn-cancel:hover {
      background: #5a6268;
      color: white;
    }
    .button-group {
      display: flex;
      justify-content: space-between;
      margin-top: 2rem;
      gap: 1rem;
    }
    .user-email {
      font-size: 0.9rem;
      color: #6c757d;
      text-align: center;
      margin-top: 1rem;
      font-style: italic;
    }
    .alert-message {
      color: #e74c3c;
      font-size: 1rem;
      margin-top: 0.5em;
      text-align: center;
      min-height: 1.5em;
    }
    @media (max-width: 576px) {
      .review-container {
        padding: 1.5rem;
        margin: 1rem;
      }
      .button-group {
        flex-direction: column;
      }
      .btn-submit, .btn-cancel {
        width: 100%;
      }
    }
  </style>
</head>
<body>
<%@ include file="/views/header.jsp" %>
<div class="review-page">
  <div class="review-container">
    <h2 class="review-header">📝 Add Review for <%= toyName != null ? toyName : "Selected Toy" %></h2>
    <% if (error != null) { %>
    <div class="alert-message"><%= error %></div>
    <% } %>
    <form method="post" action="<%= request.getContextPath() %>/addReview" onsubmit="return validateForm()">
      <input type="hidden" name="toyId" value="<%= toyId %>">
      <div class="mb-3">
        <label for="review" class="form-label">Your Review:</label>
        <textarea class="form-control" id="review" name="content" rows="5"
                  placeholder="Share your honest thoughts about this toy..."><%= content != null ? content : "" %></textarea>
      </div>
      <div class="mb-3">
        <label class="form-label">Your Rating:</label>
        <div class="star-rating">
          <input type="hidden" name="rating" id="rating-value" value="<%= rating %>">
          <span class="star<%= (rating >= 1) ? " selected" : "" %>" data-value="1">★</span>
          <span class="star<%= (rating >= 2) ? " selected" : "" %>" data-value="2">★</span>
          <span class="star<%= (rating >= 3) ? " selected" : "" %>" data-value="3">★</span>
          <span class="star<%= (rating >= 4) ? " selected" : "" %>" data-value="4">★</span>
          <span class="star<%= (rating >= 5) ? " selected" : "" %>" data-value="5">★</span>
        </div>
      </div>
      <div class="user-email">
        Reviewing as: <strong><%= userEmail %></strong>
      </div>
      <div class="button-group">
        <button type="submit" class="btn btn-submit">Submit Review</button>
        <button type="button" class="btn btn-cancel"
                onclick="window.location.href='<%= request.getContextPath() %>/product?id=<%= toyId %>'">
          Cancel
        </button>
      </div>
    </form>
  </div>
</div>
<%@ include file="/views/footer.jsp" %>
<script>
  // DOM elements
  const stars = document.querySelectorAll('.star');
  const ratingInput = document.getElementById('rating-value');
  const reviewTextarea = document.getElementById('review');
  let currentRating = parseInt(ratingInput.value) || 0;
  stars.forEach(star => {
    star.addEventListener('click', () => {
      const value = parseInt(star.getAttribute('data-value'));
      currentRating = value;
      ratingInput.value = value;
      stars.forEach((s, index) => {
        if (index < value) {
          s.classList.add('selected');
          s.style.color = '#ffc107';
        } else {
          s.classList.remove('selected');
          s.style.color = '#e0e0e0';
        }
      });
    });
    star.addEventListener('mouseover', () => {
      const value = parseInt(star.getAttribute('data-value'));
      stars.forEach((s, index) => {
        if (index < value) {
          s.style.color = '#ffc107';
        }
      });
    });
    star.addEventListener('mouseout', () => {
      stars.forEach((s, index) => {
        if (index < currentRating) {
          s.style.color = '#ffc107';
        } else {
          s.style.color = '#e0e0e0';
        }
      });
    });
  });
  document.addEventListener('DOMContentLoaded', function() {
    stars.forEach((s, index) => {
      if (index < currentRating) {
        s.classList.add('selected');
        s.style.color = '#ffc107';
      } else {
        s.classList.remove('selected');
        s.style.color = '#e0e0e0';
      }
    });
  });
  function validateForm() {
    const reviewText = reviewTextarea.value.trim();
    const rating = ratingInput.value;
    const alertMsg = document.querySelector('.alert-message');
    if (!reviewText) {
      if(alertMsg) alertMsg.textContent = "Please write your review before submitting";
      return false;
    }
    if (rating === "0" || rating === "" || rating === null) {
      if(alertMsg) alertMsg.textContent = "Please select a rating by clicking the stars";
      return false;
    }
    if(alertMsg) alertMsg.textContent = "";
    return true;
  }
</script>
</body>
</html>

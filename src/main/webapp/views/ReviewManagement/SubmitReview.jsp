<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.toyStore.model.UserManagement.User" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="java.io.IOException" %>

<%
    // Handle session and user data
    HttpSession session1 = request.getSession(false);
    User user = (session1 != null) ? (User) session1.getAttribute("user") : null;
    String userEmail = (user != null) ? user.getEmail() : "Guest";

    // Get parameters from request
    String toyName = request.getParameter("toy");
    String review = request.getParameter("review");
    String rating = request.getParameter("rating");

    // Process form submission
    if (toyName != null && review != null && rating != null) {
        String filePath = application.getRealPath("/data/" + toyName + ".txt");
        try (FileWriter writer = new FileWriter(filePath, true)) {
            writer.write(userEmail + "<br>");
            writer.write(review + "<br>");
            writer.write(rating+"\n");
            writer.write("----------\n");

            // Redirect back to the toy's review page after successful submission
            response.sendRedirect(request.getContextPath() + "/views/ReviewManagement/review.jsp?toy=" + toyName);
            return;
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
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
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #7f5af0, #f46060);
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
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(0, 0, 0, 0.85);
            color: white;
            padding: 1rem 2rem;
            border-radius: 8px;
            z-index: 1000;
            display: none;
            max-width: 80%;
            text-align: center;
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
<div class="review-container">
    <h2 class="review-header">📝 Add Review for <%= toyName != null ? toyName : "Selected Toy" %></h2>

    <form method="post" onsubmit="return validateForm()">
        <input type="hidden" name="toy" value="<%= toyName %>">

        <div class="mb-3">
            <label for="review" class="form-label">Your Review:</label>
            <textarea class="form-control" id="review" name="review" rows="5"
                      placeholder="Share your honest thoughts about this toy..."></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Your Rating:</label>
            <div class="star-rating">
                <input type="hidden" name="rating" id="rating-value" value="0">
                <span class="star" data-value="1">★</span>
                <span class="star" data-value="2">★</span>
                <span class="star" data-value="3">★</span>
                <span class="star" data-value="4">★</span>
                <span class="star" data-value="5">★</span>
            </div>
        </div>

        <div class="user-email">
            Reviewing as: <strong><%= userEmail %></strong>
        </div>

        <div class="button-group">
            <button type="submit" class="btn btn-submit">Submit Review</button>
            <button type="button" class="btn btn-cancel"
                    onclick="window.location.href='<%= request.getContextPath() %>/views/ReviewManagement/review.jsp?toy=<%= toyName %>'">
                Cancel
            </button>
        </div>
    </form>
</div>

<div class="alert-message" id="alertMessage"></div>

<script>
    // DOM elements
    const stars = document.querySelectorAll('.star');
    const ratingInput = document.getElementById('rating-value');
    const reviewTextarea = document.getElementById('review');
    const alertMessage = document.getElementById('alertMessage');

    // Initialize star rating
    let currentRating = 0;

    // Star rating functionality
    stars.forEach(star => {
        star.addEventListener('click', () => {
            const value = parseInt(star.getAttribute('data-value'));
            currentRating = value;
            ratingInput.value = value;

            // Update star display
            stars.forEach((s, index) => {
                if (index < value) {
                    s.classList.add('selected');
                } else {
                    s.classList.remove('selected');
                }
            });
        });

        // Add hover effect
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
                if (index >= currentRating) {
                    s.style.color = '#e0e0e0';
                }
            });
        });
    });

    // Form validation
    function validateForm() {
        const reviewText = reviewTextarea.value.trim();
        const rating = ratingInput.value;

        if (!reviewText) {
            showAlert("Please write your review before submitting");
            return false;
        }

        if (rating === "0") {
            showAlert("Please select a rating by clicking the stars");
            return false;
        }

        return true;
    }

    // Show alert message
    function showAlert(message) {
        alertMessage.textContent = message;
        alertMessage.style.display = "block";

        setTimeout(() => {
            alertMessage.style.display = "none";
        }, 3000);
    }
</script>
</body>
</html>
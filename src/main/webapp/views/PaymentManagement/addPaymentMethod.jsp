<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession usersession = request.getSession(false);
    String username = (usersession != null && usersession.getAttribute("username") != null)
            ? (String) usersession.getAttribute("username") : null;
    if (username == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Payment Method</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6c5ce7;
            --accent-color: #fd79a8;
            --bg-light: #f8f9fa;
            --card-bg: #fff;
        }
        body {
            background-image: url('${pageContext.request.contextPath}/images/paymentBackground.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        .add-method-form {
            background: var(--card-bg);
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.09);
            padding: 2.5rem 2rem;
            max-width: 480px;
            margin: 5rem auto 3rem auto;
            opacity: 0.97;
        }
        .form-label {
            color: #636e72;
            font-weight: 500;
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.15rem rgba(108, 92, 231, 0.13);
        }
        .btn-modern {
            border-radius: 10px;
            font-weight: 500;
            letter-spacing: 0.03em;
            padding-left: 1.5em;
            padding-right: 1.5em;
        }
        .btn-cancel {
            background: none;
            color: var(--primary-color);
            border: 1.5px solid var(--primary-color);
            transition: background 0.2s, color 0.2s;
        }
        .btn-cancel:hover {
            background: var(--primary-color);
            color: #fff;
        }
        .add-title {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 2rem;
            letter-spacing: 0.03em;
            text-align: center;
        }
    </style>
</head>
<body>
<%@ include file="/views/header.jsp" %>
<div class="add-method-form">
    <h2 class="add-title"><i class="fas fa-credit-card me-2"></i>Add Payment Method</h2>
    <form method="post" action="<%= request.getContextPath() %>/addPaymentMethod">
        <div class="mb-3">
            <label class="form-label">Card Holder Name</label>
            <input type="text" name="cardHolder" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Card Number</label>
            <input type="text" name="cardNumber" class="form-control" pattern="\d{15,16}" maxlength="16" required placeholder="15 or 16-digit card number">
        </div>
        <div class="row mb-3">
            <div class="col">
                <label class="form-label">Expiry Month</label>
                <input type="text" name="expiryMonth" class="form-control" pattern="\d{2}" maxlength="2" required placeholder="MM">
            </div>
            <div class="col">
                <label class="form-label">Expiry Year</label>
                <input type="text" name="expiryYear" class="form-control" pattern="\d{2,4}" maxlength="4" required placeholder="YYYY">
            </div>
        </div>
        <div class="mb-3">
            <label class="form-label">Card Type</label>
            <select name="cardType" class="form-select" required>
                <option value="">Select</option>
                <option value="Visa">Visa</option>
                <option value="MasterCard">MasterCard</option>
                <option value="Amex">Amex</option>
                <option value="Discover">Discover</option>
            </select>
        </div>
        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary btn-modern flex-fill">
                <i class="fas fa-plus me-2"></i>Add Payment Method
            </button>
            <a href="<%= request.getContextPath() %>/paymentMethods" class="btn btn-cancel btn-modern flex-fill">
                Cancel
            </a>
        </div>
    </form>
</div>
<%@ include file="/views/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

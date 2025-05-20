<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Toy Shop - Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            background: linear-gradient(120deg, #f9fafb 0%, #f6f0f0 70%, #ff6f61 100%);
            min-height: 100vh;
            font-family: 'Poppins', 'Segoe UI', Arial, sans-serif;
            color: #2d3436;
        }
        .register-container {
            max-width: 900px;
            margin: 4rem auto 2rem auto;
        }
        .register-glass {
            background: rgba(255,255,255,0.95);
            border-radius: 22px;
            box-shadow: 0 8px 32px rgba(41,41,114,0.13);
            overflow: hidden;
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            border: 1.5px solid rgba(255,111,97,0.08);
        }
        .register-title {
            color: #ff6f61;
            font-weight: 800;
            margin-bottom: 2rem;
            letter-spacing: 0.04em;
            text-align: center;
            font-size: 2rem;
        }
        .form-label {
            color: #636e72;
            font-weight: 600;
        }
        .form-control, .form-control:focus {
            border-radius: 10px;
            border-color: #ff6f61;
            box-shadow: 0 0 0 0.13rem rgba(255,111,97,0.08);
        }
        .register-btn {
            background: linear-gradient(90deg, #ff6f61 0%, #2a2a72 100%);
            border: none;
            color: #fff;
            font-weight: 700;
            border-radius: 10px;
            font-size: 1.1rem;
            padding: 0.7em 0;
            letter-spacing: 0.03em;
            box-shadow: 0 2px 8px rgba(255,111,97,0.09);
            transition: background 0.2s;
        }
        .register-btn:hover {
            background: linear-gradient(90deg, #2a2a72 0%, #ff6f61 100%);
        }
        .register-links {
            text-align: center;
            margin-top: 1.5rem;
        }
        .register-links a {
            color: #ff6f61;
            text-decoration: none;
            font-size: 1.05rem;
        }
        .register-links a:hover {
            text-decoration: underline;
        }
        .register-img {
            object-fit: cover;
            width: 100%;
            height: 100%;
            min-height: 320px;
        }
        @media (max-width: 900px) {
            .register-container { margin: 2rem 0.5rem; }
        }
        @media (max-width: 767px) {
            .register-img { min-height: 180px; }
        }
        @media (max-width: 575px) {
            .register-title { font-size: 1.3rem; }
            .register-glass { padding: 1.2rem 0.7rem; }
        }
    </style>
</head>
<body>
<%@ include file="/views/header.jsp" %>
<div class="container register-container">
    <div class="register-glass card shadow-lg">
        <div class="row g-0">
            <div class="col-md-6 d-none d-md-block">
                <img class="img-fluid rounded-start register-img"
                     loading="lazy"
                     src="${pageContext.request.contextPath}/images/loginOriginal.jpg"
                     alt="Register Image">
            </div>
            <div class="col-md-6">
                <div class="card-body p-4">
                    <div class="register-title"><i class="fas fa-user-plus me-2"></i>Register</div>
                    <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger text-center" role="alert">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>
                    <form action="register" method="post">
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <div class="mb-3">
                            <label for="phoneNumber" class="form-label">Phone Number</label>
                            <input type="text" class="form-control" name="phoneNumber">
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <input type="text" class="form-control" name="address">
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn register-btn">Register</button>
                        </div>
                    </form>
                    <div class="register-links mt-3">
                        <a href="${pageContext.request.contextPath}/login">Already have an account?</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/views/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

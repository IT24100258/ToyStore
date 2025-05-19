<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Toy Shop - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            background: linear-gradient(120deg, #f9fafb 0%, #f6f0f0 70%, #ff6f61 100%);
            min-height: 100vh;
            font-family: 'Poppins', 'Segoe UI', Arial, sans-serif;
            color: #2d3436;
        }
        .login-container {
            max-width: 900px;
            margin: 4rem auto 2rem auto;
        }
        .login-glass {
            background: rgba(255,255,255,0.95);
            border-radius: 22px;
            box-shadow: 0 8px 32px rgba(41,41,114,0.13);
            overflow: hidden;
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            border: 1.5px solid rgba(255,111,97,0.08);
        }
        .login-title {
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
        .login-btn {
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
        .login-btn:hover {
            background: linear-gradient(90deg, #2a2a72 0%, #ff6f61 100%);
        }
        .login-links {
            text-align: center;
            margin-top: 1.5rem;
        }
        .login-links a {
            color: #ff6f61;
            text-decoration: none;
            margin: 0 0.5em;
            font-size: 1.05rem;
        }
        .login-links a:hover {
            text-decoration: underline;
        }
        .login-img {
            object-fit: cover;
            width: 100%;
            height: 100%;
            min-height: 320px;
        }
        @media (max-width: 900px) {
            .login-container { margin: 2rem 0.5rem; }
        }
        @media (max-width: 767px) {
            .login-img { min-height: 180px; }
        }
        @media (max-width: 575px) {
            .login-title { font-size: 1.3rem; }
            .login-glass { padding: 1.2rem 0.7rem; }
        }
    </style>
</head>
<body>
<%@ include file="/views/header.jsp" %>
<div class="container login-container">
    <div class="login-glass card shadow-lg">
        <div class="row g-0">
            <div class="col-md-6 d-none d-md-block">
                <img class="img-fluid rounded-start login-img"
                     loading="lazy"
                     src="${pageContext.request.contextPath}/images/loginOriginal.jpg"
                     alt="Login Image">
            </div>
            <div class="col-md-6">
                <div class="card-body p-4">
                    <div class="login-title"><i class="fas fa-sign-in-alt me-2"></i>Log In</div>
                    <form action="login" method="post">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" name="remember_me" id="remember_me">
                            <label class="form-check-label" for="remember_me">Remember me</label>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn login-btn">Log In</button>
                        </div>
                    </form>
                    <div class="login-links mt-3">
                        <a href="#">Forgot Password?</a>
                        <span>|</span>
                        <a href="${pageContext.request.contextPath}/register">Create an Account</a>
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

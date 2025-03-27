<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Toy Shop - Login</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        :root {
            --primary-color: #ff6f61;
            --secondary-color: #2a2a72;
            --light-color: #f8f9fa;
            --dark-color: #212529;
        }
        body {
            background-color: var(--light-color);
        }
        .navbar {
            background-color: var(--secondary-color) !important;
        }
        .navbar-brand, .nav-link {
            color: white !important;
        }
        .login-container {
            max-width: 900px;
            margin: auto;
        }
        .login-btn {
            background-color: var(--primary-color);
            border: none;
            color: white;
            font-weight: bold;
        }
        .login-btn:hover {
            background-color: #e35d50;
        }
        footer {
            background-color: var(--dark-color);
            color: white;
            padding: 2rem 0;
        }
        footer a {
            color: var(--primary-color);
            text-decoration: none;
        }
        footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<%@ include file="/views/header.jsp" %>

<section class="p-4">
    <div class="container login-container">
        <div class="card shadow-lg">
            <div class="row g-0">
                <div class="col-md-6">
                    <img class="img-fluid rounded-start w-100 h-100 object-fit-cover"
                         loading="lazy"
                         src="${pageContext.request.contextPath}/images/loginOriginal.jpg"
                         alt="Login Image">
                </div>
                <div class="col-md-6">
                    <div class="card-body">
                        <h3 class="text-center mb-4">Log In</h3>

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
                                <input type="checkbox" class="form-check-input" name="remember_me">
                                <label class="form-check-label">Remember me</label>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn login-btn">Log In</button>
                            </div>
                        </form>
                        <div class="text-center mt-3">
                            <a href="">Forgot Password?</a>
                            <br>
                            <a href="${pageContext.request.contextPath}/register">Create an Account</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="/views/footer.jsp" %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

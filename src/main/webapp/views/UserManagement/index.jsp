<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Toy Shop - Register</title>

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

        .register-container {
            max-width: 900px;
            margin: auto;
        }
        .register-btn {
            background-color: var(--primary-color);
            border: none;
            color: white;
            font-weight: bold;
        }
        .register-btn:hover {
            background-color: #e35d50;
        }
    </style>
</head>
<body>

<%@ include file="/views/header.jsp" %>

<section class="p-4">
    <div class="container register-container">
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
                        <h3 class="text-center mb-4">Register</h3>

                        <!-- Error Message Display -->
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
                        <div class="text-center mt-3">
                            <a href="${pageContext.request.contextPath}/login">Already have an account?</a>
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

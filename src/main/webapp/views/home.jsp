<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.toyStore.model.Toymanagement.Toy" %>
<%@ page import="com.toyStore.model.ReviewManagement.ServiceReview" %>
<%
    List<Toy> toys = (List<Toy>) request.getAttribute("toys");
    List<ServiceReview> serviceReviews = (List<ServiceReview>) request.getAttribute("serviceReviews");
    int reviewCount = (serviceReviews != null) ? serviceReviews.size() : 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toy Store - Home</title>
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
            background: linear-gradient(120deg, #f9fafb 30%, #f6f0f0 40%, #ffc1cc 100%);
            color: #2d3436;
            font-family: 'Poppins', 'Segoe UI', Arial, sans-serif;
        }
        .carousel-item img {
            width: 100%;
            height: 500px;
            object-fit: cover;
            border-radius: 14px;
        }
        .carousel-indicators button {
            background-color: #2575fc;
        }
        .carousel-control-prev-icon, .carousel-control-next-icon {
            filter: invert(1);
        }
        .carousel-hero-overlay {
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: linear-gradient(90deg, rgba(108,92,231,0.8) 0%, rgba(253,121,168,0.6) 100%);
            z-index: 2;
            border-radius: 14px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
            padding: 3rem 4rem;
        }
        .carousel-hero-overlay h1 {
            color: #fff;
            font-size: 2.7rem;
            font-weight: 700;
            letter-spacing: 0.02em;
            margin-bottom: 1rem;
        }
        .carousel-hero-overlay p {
            color: #fff;
            font-size: 1.18rem;
            margin-bottom: 2rem;
        }
        .carousel-hero-overlay .btn-cta {
            background: #fff;
            color: #6c5ce7;
            font-weight: 600;
            border-radius: 12px;
            padding: 0.9em 2.5em;
            font-size: 1.1rem;
            box-shadow: 0 4px 16px rgba(253,121,168,0.13);
            transition: background 0.2s, color 0.2s;
        }
        .carousel-hero-overlay .btn-cta:hover {
            background: #fd79a8;
            color: #fff;
        }
        .carousel-wrapper {
            position: relative;
            margin-top: 2.5rem;
            margin-bottom: 2.5rem;
        }
        .features-section {
            margin-top: -2rem;
            margin-bottom: 3rem;
            padding: 2.5rem 0 0.5rem 0;
        }
        .feature-card {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 4px 18px rgba(108,92,231,0.08);
            padding: 1.5rem 1rem;
            text-align: center;
            margin-bottom: 1.5rem;
            transition: box-shadow 0.2s;
        }
        .feature-card:hover {
            box-shadow: 0 8px 32px rgba(253,121,168,0.16);
        }
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 0.7rem;
            color: #fd79a8;
        }
        .feature-title {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #6c5ce7;
        }
        .product-card {
            background: var(--card-bg);
            border-radius: 18px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.10);
            color: #222831;
            margin-bottom: 32px;
            transition: transform 0.22s, box-shadow 0.22s;
            overflow: hidden;
        }
        .product-card:hover {
            transform: translateY(-7px) scale(1.035);
            box-shadow: 0 12px 32px rgba(108,92,231,0.13);
        }
        .product-card img {
            width: 100%;
            height: 230px;
            object-fit: cover;
            border-radius: 18px 18px 0 0;
            background: #f8f9fa;
        }
        .card-body {
            padding: 1.4rem 1.1rem;
        }
        .card-title {
            font-weight: 700;
            font-size: 1.18rem;
            color: #6c5ce7;
        }
        .toy-price {
            color: #fd5e53;
            font-size: 1.1rem;
            font-weight: 600;
        }
        .btn-custom {
            background-color: #fd79a8;
            color: white;
            border-radius: 10px;
            font-weight: 600;
            letter-spacing: 0.03em;
            padding: 0.55em 1.5em;
            transition: background 0.2s;
        }
        .btn-custom:hover {
            background-color: #6c5ce7;
            color: #fff;
        }
        .badge-age {
            background: #6c5ce7;
            color: #fff;
            font-size: 0.95em;
            border-radius: 8px;
            padding: 0.3em 0.8em;
        }
        .action {
            background-color: #efdcdc;
            border-radius: 15px;
        }
        /* Service Reviews Section */
        #service-reviews .carousel-item { min-height: 210px; }
        #service-reviews .card { border-radius: 18px; }
        #service-reviews .fa-star,
        #service-reviews .fa-star-half-alt { color: #fd79a8; }
        #service-reviews .carousel-control-prev-icon,
        #service-reviews .carousel-control-next-icon { filter: invert(1); }
        @media (max-width: 991px) {
            .carousel-hero-overlay {
                padding: 2rem 1.5rem;
            }
            .carousel-hero-overlay h1 { font-size: 2rem; }
        }
        @media (max-width: 767px) {
            .carousel-item img { height: 250px; }
            .carousel-hero-overlay { position: static; border-radius: 0; padding: 1.2rem 0.5rem; }
            .features-section { margin-top: 0; }
            .product-card img { height: 180px; }
        }
    </style>
</head>
<body>

<%@ include file="/views/header.jsp" %>

<div class="container carousel-wrapper">
    <div style="position:relative;">
        <div id="toyCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#toyCarousel" data-bs-slide-to="0" class="active" aria-current="true"></button>
                <button type="button" data-bs-target="#toyCarousel" data-bs-slide-to="1"></button>
            </div>
            <div class="carousel-inner rounded">
                <div class="carousel-item active">
                    <img src="${pageContext.request.contextPath}/images/bannerImage.jpg" class="d-block w-100" alt="Toy 1">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/images/Art&CraftKit.png" class="d-block w-100" alt="Toy 2">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#toyCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#toyCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
            </button>
        </div>
        <!-- Hero Overlay -->
        <div class="carousel-hero-overlay d-none d-md-flex">
            <div>
                <h1><i class="fas fa-cube me-2"></i>Welcome to WonderToys!</h1>
                <p>
                    Discover a world of joy, learning, and imagination.<br>
                    Shop the best toys for every age, delivered right to your door.
                </p>
                <a href="#products" class="btn btn-cta shadow">
                    <i class="fas fa-shopping-bag me-2"></i>Shop Now
                </a>
            </div>
        </div>
    </div>
    <!-- For mobile, show hero below carousel -->
    <div class="d-block d-md-none mt-3 text-center">
        <h1 style="color:#6c5ce7;font-weight:700;"><i class="fas fa-cube me-2"></i>Welcome to WonderToys!</h1>
        <p style="color:#6c5ce7;">
            Discover a world of joy, learning, and imagination.<br>
            Shop the best toys for every age, delivered right to your door.
        </p>
        <a href="#products" class="btn btn-cta shadow mb-3" style="background:#fff;color:#6c5ce7;">
            <i class="fas fa-shopping-bag me-2"></i>Shop Now
        </a>
    </div>
</div>

/*<section class="features-section container">
    <div class="row g-4">
        <div class="col-md-4">
            <div class="feature-card">
                <div class="feature-icon"><i class="fas fa-shipping-fast"></i></div>
                <div class="feature-title">Fast & Free Delivery</div>
                <div>Get your toys delivered within 2 days, free for all orders above Rs 499!</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="feature-card">
                <div class="feature-icon"><i class="fas fa-award"></i></div>
                <div class="feature-title">Premium Quality</div>
                <div>All toys are certified, safe, and handpicked for quality and durability.</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="feature-card">
                <div class="feature-icon"><i class="fas fa-headset"></i></div>
                <div class="feature-title">24/7 Support</div>
                <div>Our toy experts are always here to help you choose and resolve queries.</div>
            </div>
        </div>
    </div>
</section>*/

<!-- Product Sorting -->
<div class="container" id="products">
    <h2 class="text-center mb-4" style="color:#6c5ce7;">All Toys</h2>

    <div class="d-flex justify-content-end mb-3">
        <form method="post" action="${pageContext.request.contextPath}/">
            <input type="hidden" name="action" value="sortByAgeGroup">
            <input type="hidden" name="order" value="asc">
            <button type="submit" class="btn btn-primary me-2">Sort by Age Group ↑</button>
        </form>
        <form method="post" action="${pageContext.request.contextPath}/">
            <input type="hidden" name="action" value="sortByAgeGroup">
            <input type="hidden" name="order" value="desc">
            <button type="submit" class="btn btn-secondary">Sort by Age Group ↓</button>
        </form>
    </div>

    <div class="row mt-4">
        <%
            if (toys != null && !toys.isEmpty()) {
                for (Toy toy : toys) {
        %>
        <div class="col-md-4 col-sm-6 mb-4">
            <div class="card product-card h-100">
                <a href="${pageContext.request.contextPath}/product?id=<%= toy.getId() %>">
                    <img src="<%= request.getContextPath() + "/" + toy.getImagePath() %>" alt="<%= toy.getName() %>">
                </a>
                <div class="card-body">
                    <h5 class="card-title"><%= toy.getName() %></h5>
                    <p class="card-text text-muted"><%= toy.getDescription() %></p>
                    <p class="toy-price mb-1">Rs <%= String.format("%.2f", toy.getPrice()) %></p>
                    <p class="mb-2"><span class="badge badge-age">Age <%= toy.getAgeGroup() %>+</span></p>
                    <a href="${pageContext.request.contextPath}/order?toyId=<%= toy.getId() %>" class="btn btn-custom w-100">
                        <i class="fas fa-shopping-cart me-2"></i>Order Now
                    </a>
                </div>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div class="col-12 text-center text-muted">
            <p>No toys available at the moment.</p>
        </div>
        <%
            }
        %>
    </div>

    /*<!-- Service Reviews Section -->
    <section class="container my-5" id="service-reviews">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="text-center mb-4">
                    <h2 class="fw-bold" style="color:#6c5ce7;">What Our Users Say</h2>
                    <div class="d-flex justify-content-center align-items-center mb-2">
                    <span class="me-2" style="font-size:1.7rem; color:#fd79a8;">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </span>
                        <span class="ms-2 text-muted" style="font-size:1rem;">
                        (<%= reviewCount %> reviews)
                    </span>
                    </div>
                    <a href="${pageContext.request.contextPath}/addServiceReview" class="btn btn-primary btn-lg shadow-sm mt-2" style="border-radius:12px;">
                        <i class="fas fa-pen-to-square me-1"></i> Add Service Review
                    </a>
                </div>
                /*<% if (serviceReviews != null && !serviceReviews.isEmpty()) { %>
                <!-- Review Carousel -->
                <div id="serviceReviewCarousel" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <%
                            int idx = 0;
                            for (ServiceReview review : serviceReviews) {
                                if (idx >= 5) break;
                        %>
                        <div class="carousel-item <%= (idx == 0) ? "active" : "" %>">
                            <div class="card shadow-sm border-0 p-4" style="border-radius:18px;">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="fas fa-user-circle fa-2x me-2" style="color:#6c5ce7;"></i>
                                    <div>
                                        <span class="fw-semibold" style="color:#6c5ce7;"><%= review.getReviewer().getUserName() %></span>
                                        <br>
                                        <small class="text-muted"><%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(review.getReviewDate()) %></small>
                                    </div>
                                </div>
                                <p class="mb-0" style="font-size:1.13rem;color:#444;">
                                    <i class="fas fa-quote-left me-2" style="color:#fd79a8;"></i>
                                    <%= review.getContent() %>
                                </p>
                            </div>
                        </div>
                        <%
                                idx++;
                            }
                        %>
                    </div>
                    <% if (reviewCount > 1) { %>
                    <button class="carousel-control-prev" type="button" data-bs-target="#serviceReviewCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#serviceReviewCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    </button>
                    <% } %>
                </div>*/
                <% } else { %>
                <div class="alert alert-info text-center mt-4">
                    <i class="fas fa-info-circle me-2"></i>No service reviews yet. Be the first to share your experience!
                </div>
                <% } %>
            </div>
        </div>
    </section>*/
</div>

<%@ include file="/views/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

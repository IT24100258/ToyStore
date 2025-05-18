<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toy Store - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #F6F0F0;
            color: #333;
            font-family: 'Poppins', sans-serif;
        }

        .carousel-item img {
            width: 100%;
            height: 500px;
            object-fit: cover;
            border-radius: 10px;
        }
        .carousel-indicators button {
            background-color: #2575fc;
        }
        .carousel-control-prev-icon, .carousel-control-next-icon {
            filter: invert(1);
        }
        .product-card {
            background-color: #F6F0F0;
            transition: transform 0.3s;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            color: #222831;
        }
        .product-card:hover {
            transform: scale(1.05);
        }
        .btn-custom {
            background-color: #dd6767;
            color: white;
            border-radius: 8px;
        }
        .btn-custom:hover {
            background-color: #c15a5a;
        }

        .product-card img{
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
        }

        .toy-price{
            color: #ff0404;
        }

        .action{
            background-color: #efdcdc;
            border-radius: 15px;
        }
    </style>
</head>
<body>

<%@ include file="/views/header.jsp" %>
<!-- Carousel -->
<div id="toyCarousel" class="carousel slide mt-4" data-bs-ride="carousel">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#toyCarousel" data-bs-slide-to="0" class="active" aria-current="true"></button>
        <button type="button" data-bs-target="#toyCarousel" data-bs-slide-to="1"></button>
    </div>
    <div class="carousel-inner rounded">
        <div class="carousel-item active">
            <img src="${pageContext.request.contextPath}/images/bannerImage.jpg" class="d-block w-100" alt="Toy 1">
        </div>
        <div class="carousel-item">
            <img src="${pageContext.request.contextPath}/images/delivery.png" class="d-block w-100" alt="Toy 2">
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#toyCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#toyCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
    </button>
</div>

<div class="container mt-5">
    <!-- Featured Products -->
    <h2 class="text-center">Featured Toys</h2>
    <div class="row mt-4">

        <div class="col-md-4">

            <div class="card product-card">
                <a href="${pageContext.request.contextPath}/views/ReviewManagement/review.jsp?toy=ToyCar">
                    <img src="${pageContext.request.contextPath}/images/Products/toycar.jpg" class="card-img-top" alt="Toy Car">
                </a>
                <div class="card-body">
                    <h5 class="card-title">Toy Car</h5>
                    <p class="card-text">A fun and fast toy car for kids!</p>
                    <p class="toy-price">Rs 1990</p>
                    <a href="#"class="btn btn-danger">Add to Cart</a>

                </div>
            </div>
        </div>
        <div class="col-md-4">

            <div class="card product-card">
                <a href="${pageContext.request.contextPath}/views/ReviewManagement/review.jsp?toy=DollHouse">
                    <img src="${pageContext.request.contextPath}/images/Products/dollhouse.jpg" class="card-img-top" alt="DollHouse">
                </a>
                <div class="card-body">
                    <h5 class="card-title">Doll House</h5>
                    <p class="card-text">A beautiful dollhouse for creative play.</p>
                    <p class="toy-price">Rs 4999</p>
                    <a href="#"class="btn btn-danger">Add to Cart</a>
                </div>

            </div>
        </div>
        <div class="col-md-4">
            <div class="card product-card">
                <a href="${pageContext.request.contextPath}/views/ReviewManagement/review.jsp?toy=Building">
                    <img src="${pageContext.request.contextPath}/images/Products/building.jpg" class="card-img-top" alt="Building Blocks">
                </a>
                <div class="card-body">
                    <h5 class="card-title">Building Blocks</h5>
                    <p class="card-text">Endless creativity with these building blocks.</p>
                    <p class="toy-price">Rs 2990</p>
                    <a href="#"class="btn btn-danger">Add to Cart</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Call to Action -->
    <div class="mt-5 p-5 text-center rounded action">
        <h3>Explore More Toys!</h3>
        <p>Find the perfect toy for your little one.</p>
        <a href="#" class="btn btn-warning">Shop Now</a>
    </div>
</div>

<%@ include file="/views/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
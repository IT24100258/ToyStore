<header>
  <style>
    :root {
      --primary-color: #dd6767;
      --secondary-color: #222831;
      --light-color: #F6F0F0;
      --dark-color: #333;
    }

    .navbar {
      background-color: var(--secondary-color) !important;
    }

    .navbar-brand, .nav-link {
      color: var(--light-color) !important;
    }

    .btn-outline-light {
      border-color: var(--primary-color);
      color: var(--primary-color);
    }

    .btn-outline-light:hover {
      background-color: var(--primary-color);
      color: var(--light-color);
    }
  </style>

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

  <nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
      <a class="navbar-brand" href="${pageContext.request.contextPath}/">
        <img src="${pageContext.request.contextPath}/images/logoImage.jpg" alt="Toy Shop Logo" height="40" width="40">
        TOY SHOP
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Home</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Shop</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
          <li class="nav-item"><a class="nav-link" href="#">About</a></li>
        </ul>
        <ul class="navbar-nav ms-3">
          <li class="nav-item">
            <a class="btn btn-outline-light rounded-circle" href="${pageContext.request.contextPath}/${not empty sessionScope.user ? 'profile' : 'login'}">
              <i class="fa-duotone fa-regular fa-circle-user"></i>
            </a>
            <c:if test="${not empty sessionScope.user}">
              <span class="ms-2 text-light">${sessionScope.user.userName}</span>
            </c:if>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</header>

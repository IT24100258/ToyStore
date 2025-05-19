<header>
  <style>
    :root {
      --primary-color: #dd6767;
      --secondary-color: #222831;
      --light-color: #F6F0F0;
      --dark-color: #333;
      --nav-glass: rgba(34,40,49,0.93);
    }

    .navbar {
      background: var(--nav-glass);
      box-shadow: 0 2px 16px rgba(34,40,49,0.07);
      backdrop-filter: blur(8px);
      -webkit-backdrop-filter: blur(8px);
      border-bottom: 1.5px solid rgba(221,103,103,0.07);
    }
    .navbar-brand, .nav-link {
      color: var(--light-color) !important;
      font-weight: 600;
      letter-spacing: 0.04em;
      transition: color 0.18s;
    }
    .navbar-brand:hover, .nav-link:hover, .nav-link.active {
      color: var(--primary-color) !important;
    }
    .navbar-brand img {
      border-radius: 12px;
      margin-right: 0.5em;
      box-shadow: 0 2px 8px rgba(221,103,103,0.09);
    }
    .btn-outline-light {
      border-color: var(--primary-color);
      color: var(--primary-color);
      background: rgba(221,103,103,0.07);
      transition: background 0.2s, color 0.2s, box-shadow 0.2s;
      font-weight: 700;
    }
    .btn-outline-light:hover {
      background-color: var(--primary-color);
      color: var(--light-color);
      box-shadow: 0 2px 8px rgba(221,103,103,0.13);
    }
    .profile-name {
      font-weight: 600;
      color: var(--light-color);
      margin-left: 0.5em;
      font-size: 1.07em;
      letter-spacing: 0.01em;
    }
    .nav-profile {
      display: flex;
      align-items: center;
      gap: 0.5em;
    }
    @media (max-width: 991px) {
      .navbar-brand { font-size: 1.1rem; }
      .profile-name { font-size: 0.98em; }
    }
  </style>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

  <nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
      <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/">
        <img src="${pageContext.request.contextPath}/images/logoImage.jpg" alt="Toy Shop Logo" height="40" width="40">
        WONDER TOYS
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Home</a></li>
          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/views/Contact.jsp">Contact</a></li>
          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/views/About.jsp">About</a></li>
        </ul>
        <ul class="navbar-nav ms-3 nav-profile">
          <li class="nav-item">
            <a class="btn btn-outline-light rounded-circle" href="${pageContext.request.contextPath}/${not empty sessionScope.user ? 'profile' : 'login'}" title="Profile">
              <i class="fa-regular fa-circle-user"></i>
            </a>
            <c:if test="${not empty sessionScope.user}">
              <span class="profile-name">${sessionScope.user.userName}</span>
            </c:if>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</header>

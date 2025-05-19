<footer class="text-center">
  <style>
    footer {
      background: linear-gradient(90deg, #222831 80%, #dd6767 100%);
      color: white;
      padding: 2.5rem 0 1.2rem 0;
      box-shadow: 0 -2px 14px rgba(34,40,49,0.07);
      font-size: 1.07rem;
      letter-spacing: 0.01em;
    }
    footer a {
      color: #ffb3b3;
      text-decoration: none;
      transition: color 0.2s;
    }
    footer a:hover {
      color: #fff;
      text-decoration: underline;
    }
    .footer-title {
      color: #ffb3b3;
      font-weight: 700;
      margin-bottom: 0.7em;
      letter-spacing: 0.02em;
      font-size: 1.12rem;
    }
    .footer-social a {
      color: #ffb3b3;
      margin-right: 0.7em;
      font-size: 1.35rem;
      transition: color 0.2s, transform 0.2s;
    }
    .footer-social a:hover {
      color: #fff;
      transform: scale(1.18);
    }
    .footer-hr {
      border-top: 1.5px solid #444;
      margin: 2em 0 1em 0;
    }
    .footer-bottom {
      color: #bbb;
      font-size: 0.98em;
      margin-top: 1.2em;
    }
    @media (max-width: 767px) {
      .footer-title { font-size: 1rem; }
      footer { padding: 1.2rem 0 0.7rem 0; font-size: 0.98rem; }
    }
  </style>
  <div class="container">
    <div class="row text-center text-md-start">
      <div class="col-md-4 mb-4 mb-md-0">
        <div class="footer-title">About Us</div>
        <p>We provide high-quality toys for kids of all ages. Explore our collections and find the best products!</p>
      </div>
      <div class="col-md-4 mb-4 mb-md-0">
        <div class="footer-title">Quick Links</div>
        <ul class="list-unstyled">
          <li><a href="${pageContext.request.contextPath}/">Home</a></li>
          <li><a href="#">Shop</a></li>
          <li><a href="${pageContext.request.contextPath}/views/Contact.jsp">Contact</a></li>
          <li><a href="#">Privacy Policy</a></li>
        </ul>
      </div>
      <div class="col-md-4">
        <div class="footer-title">Follow Us</div>
        <div class="footer-social mb-2">
          <a href="#"><i class="fab fa-facebook fa-lg"></i></a>
          <a href="#"><i class="fab fa-instagram fa-lg"></i></a>
          <a href="#"><i class="fab fa-twitter fa-lg"></i></a>
        </div>
      </div>
    </div>
    <div class="footer-hr"></div>
    <div class="footer-bottom">&copy; 2025 Wonder Toys. All Rights Reserved.</div>
  </div>
</footer>

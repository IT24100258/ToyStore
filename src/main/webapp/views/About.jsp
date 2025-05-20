<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>About Us | WonderToys</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(120deg, #fd79a8 0%, #6c5ce7 100%);
            min-height: 100vh;
            font-family: 'Poppins', 'Segoe UI', Arial, sans-serif;
            color: #2d3436;
        }
        .about-glass {
            background: rgba(255,255,255,0.95);
            border-radius: 28px;
            box-shadow: 0 12px 48px rgba(108,92,231,0.13);
            padding: 3rem 2rem 2.5rem 2rem;
            max-width: 900px;
            margin: 4rem auto 2rem auto;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1.5px solid rgba(108,92,231,0.09);
        }
        .about-title {
            font-size: 2.6rem;
            font-weight: 900;
            color: #fd79a8;
            letter-spacing: 0.03em;
            margin-bottom: 1.2rem;
            text-align: center;
            text-shadow: 0 2px 8px rgba(253,121,168,0.09);
        }
        .about-lead {
            font-size: 1.15rem;
            color: #636e72;
            text-align: center;
            margin-bottom: 2.2rem;
        }
        .about-section {
            display: flex;
            flex-wrap: wrap;
            gap: 2.5rem;
            align-items: flex-start;
            margin-bottom: 2.2rem;
            justify-content: center;
        }
        .about-block {
            background: #f6f6ff;
            border-radius: 16px;
            box-shadow: 0 6px 24px rgba(108,92,231,0.09);
            padding: 2rem 1.3rem;
            flex: 1 1 260px;
            min-width: 220px;
            max-width: 320px;
            text-align: center;
            margin-bottom: 1.5rem;
        }
        .about-block .fa {
            font-size: 2.3rem;
            color: #6c5ce7;
            margin-bottom: 0.7em;
        }
        .about-block-title {
            font-weight: 700;
            color: #fd79a8;
            margin-bottom: 0.5em;
            font-size: 1.13rem;
            letter-spacing: 0.01em;
        }
        .about-block-desc {
            color: #636e72;
            font-size: 1.02rem;
        }
        .about-values {
            margin-top: 2.5rem;
            text-align: center;
        }
        .about-values h3 {
            color: #6c5ce7;
            font-weight: 800;
            margin-bottom: 1rem;
            font-size: 1.4rem;
            letter-spacing: 0.02em;
        }
        .about-values-list {
            display: flex;
            flex-wrap: wrap;
            gap: 1.5rem;
            justify-content: center;
        }
        .about-value {
            background: #fff;
            color: #fd79a8;
            border-radius: 10px;
            padding: 0.7em 1.6em;
            font-weight: 600;
            font-size: 1.07rem;
            box-shadow: 0 2px 8px rgba(253,121,168,0.09);
            margin-bottom: 0.4em;
        }
        @media (max-width: 900px) {
            .about-section { flex-direction: column; gap: 1.5rem; }
            .about-glass { padding: 1.2rem 0.7rem; }
        }
    </style>
</head>
<body>
<%@ include file="/views/header.jsp" %>
<div class="about-glass">
    <div class="about-title"><i class="fas fa-child me-2"></i>About WonderToys</div>
    <div class="about-lead">
        WonderToys is where joy, learning, and imagination come together. <br>
        Our mission: to inspire every child’s creativity and happiness, one toy at a time.
    </div>
    <div class="about-section">
        <div class="about-block">
            <i class="fas fa-rocket"></i>
            <div class="about-block-title">Our Story</div>
            <div class="about-block-desc">
                Founded in 2020 by passionate parents and educators, WonderToys began as a dream to make playtime magical and meaningful for every child.
            </div>
        </div>
        <div class="about-block">
            <i class="fas fa-leaf"></i>
            <div class="about-block-title">Sustainability</div>
            <div class="about-block-desc">
                We’re committed to eco-friendly practices, safe materials, and giving back to our planet. Every toy is chosen for its quality and positive impact.
            </div>
        </div>
        <div class="about-block">
            <i class="fas fa-heart"></i>
            <div class="about-block-title">Why Choose Us?</div>
            <div class="about-block-desc">
                Fast delivery, expert support, and a curated selection of toys for all ages. We guarantee smiles-with every order.
            </div>
        </div>
    </div>
    <div class="about-values">
        <h3>Our Values</h3>
        <div class="about-values-list">
            <div class="about-value"><i class="fas fa-smile-beam me-2"></i>Joyful Play</div>
            <div class="about-value"><i class="fas fa-book-reader me-2"></i>Learning</div>
            <div class="about-value"><i class="fas fa-globe-asia me-2"></i>Sustainability</div>
            <div class="about-value"><i class="fas fa-users me-2"></i>Community</div>
            <div class="about-value"><i class="fas fa-award me-2"></i>Quality</div>
        </div>
    </div>
</div>
<%@ include file="/views/footer.jsp" %>
</body>
</html>

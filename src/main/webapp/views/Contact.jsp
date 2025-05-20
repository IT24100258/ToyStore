<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Us | WonderToys</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(120deg, #6c5ce7 0%, #fd79a8 100%);
            min-height: 100vh;
            font-family: 'Poppins', 'Segoe UI', Arial, sans-serif;
            color: #2d3436;
        }
        .contact-glass {
            background: rgba(255,255,255,0.92);
            border-radius: 24px;
            box-shadow: 0 10px 40px rgba(108,92,231,0.14);
            padding: 2.5rem 2rem;
            max-width: 550px;
            margin: 4rem auto 2rem auto;
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1.5px solid rgba(108,92,231,0.08);
        }
        .contact-title {
            font-size: 2.3rem;
            font-weight: 800;
            color: #6c5ce7;
            letter-spacing: 0.03em;
            margin-bottom: 1.2rem;
            text-align: center;
            text-shadow: 0 2px 8px rgba(108,92,231,0.08);
        }
        .contact-intro {
            font-size: 1.08rem;
            color: #636e72;
            text-align: center;
            margin-bottom: 2rem;
        }
        .contact-info {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }
        .contact-info a, .contact-info span {
            display: flex;
            align-items: center;
            gap: 0.6em;
            color: #6c5ce7;
            font-weight: 600;
            text-decoration: none;
            font-size: 1.05rem;
            background: #f6f6ff;
            border-radius: 10px;
            padding: 0.5em 1.1em;
            transition: background 0.2s, color 0.2s;
        }
        .contact-info a:hover {
            background: #fd79a8;
            color: #fff;
        }
        .form-label {
            color: #636e72;
            font-weight: 600;
        }
        .form-control, .form-control:focus {
            border-radius: 10px;
            border-color: #6c5ce7;
            box-shadow: 0 0 0 0.13rem rgba(108, 92, 231, 0.08);
        }
        .btn-send {
            background: linear-gradient(90deg, #6c5ce7 0%, #fd79a8 100%);
            color: #fff;
            border-radius: 10px;
            font-weight: 700;
            padding: 0.7em 2em;
            font-size: 1.1rem;
            letter-spacing: 0.02em;
            box-shadow: 0 4px 16px rgba(253,121,168,0.10);
            transition: background 0.2s;
            border: none;
        }
        .btn-send:hover {
            background: linear-gradient(90deg, #fd79a8 0%, #6c5ce7 100%);
            color: #fff;
        }
        @media (max-width: 600px) {
            .contact-glass { padding: 1.2rem 0.5rem; }
            .contact-title { font-size: 1.5rem; }
            .contact-info { flex-direction: column; gap: 0.8rem; }
        }
    </style>
</head>
<body>
<%@ include file="/views/header.jsp" %>
<div class="contact-glass">
    <div class="contact-title"><i class="fas fa-envelope-open-text me-2"></i>Contact Us</div>
    <div class="contact-intro">
        We'd love to hear from you! Whether you have a question, feedback, or just want to say hello, our team is here for you.
    </div>
    <div class="contact-info">
        <a href="mailto:hello@wondertoys.com"><i class="fas fa-envelope"></i> hello@wondertoys.com</a>
        <a href="tel:+94123456789"><i class="fas fa-phone"></i> +94 123 456 789</a>
        <a href="https://maps.google.com/?q=WonderToys,Colombo" target="_blank"><i class="fas fa-map-marker-alt"></i> Colombo, Sri Lanka</a>
    </div>
    <form method="post" action="/sendContactMessage">
        <div class="mb-3">
            <label class="form-label">Your Name</label>
            <input type="text" name="name" class="form-control" required placeholder="Enter your name">
        </div>
        <div class="mb-3">
            <label class="form-label">Email Address</label>
            <input type="email" name="email" class="form-control" required placeholder="you@email.com">
        </div>
        <div class="mb-3">
            <label class="form-label">Message</label>
            <textarea name="message" class="form-control" rows="4" required placeholder="Type your message"></textarea>
        </div>
        <div class="text-center">
            <button type="submit" class="btn btn-send"><i class="fas fa-paper-plane me-2"></i>Send Message</button>
        </div>
    </form>
</div>
<%@ include file="/views/footer.jsp" %>
</body>
</html>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zerodech — Smart Waste Management</title>
    <meta name="description" content="Zerodech simplifies waste collection in Cameroon. Schedule your pickups, track your requests, and manage your subscriptions.">
    <link rel="stylesheet" href="css/main.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <div class="navbar-brand">🌿 Zero<span>dech</span></div>
    <ul class="navbar-nav">
        <li><a href="#features">Features</a></li>
        <li><a href="login.jsp" class="btn-nav">Login</a></li>
        <li><a href="register.jsp" class="btn-nav" style="background:#f39c12;">Register</a></li>
    </ul>
</nav>

<!-- Hero -->
<section class="hero">
    <h1>Waste collection<br><span>reinvented</span> for Cameroon</h1>
    <p>Schedule your pickups, track your requests in real-time and manage your subscriptions — all in one place.</p>
    <div class="hero-btns">
        <a href="register.jsp" class="btn-hero-primary">Start for free</a>
        <a href="login.jsp" class="btn-hero-outline">I already have an account</a>
    </div>
</section>

<!-- Features -->
<section class="features-section" id="features">
    <h2>Why choose Zerodech?</h2>
    <div class="features-grid">
        <div class="feature-card">
            <div class="feature-icon">📅</div>
            <h3>Pickup Requests</h3>
            <p>Schedule your pickups at a date and time that suits you. Choose your waste type and address.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">📍</div>
            <h3>Real-time Tracking</h3>
            <p>Track the status of your requests at every step — Pending, Assigned, In Progress, Completed.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">💳</div>
            <h3>Flexible Subscriptions</h3>
            <p>Choose from our Basic, Standard or Premium plans depending on your needs and budget.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">⭐</div>
            <h3>Customer Feedback</h3>
            <p>Rate the service quality after every collection and help us continuously improve.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">🚛</div>
            <h3>Dedicated Collectors</h3>
            <p>Our certified collectors are assigned to your areas to guarantee efficient and punctual collection.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">🛡️</div>
            <h3>Secure & Reliable</h3>
            <p>Your account and your data are protected. Manage your profile with confidence.</p>
        </div>
    </div>
</section>

<!-- CTA Banner -->
<section style="background:var(--green-dark);padding:4rem 2rem;text-align:center;color:#fff;">
    <h2 style="font-size:2rem;margin-bottom:1rem;">Ready to join Zerodech?</h2>
    <p style="color:rgba(255,255,255,.75);margin-bottom:2rem;">Join hundreds of clients who trust our service.</p>
    <a href="register.jsp" class="btn-hero-primary">Create my account</a>
</section>

<footer class="footer">
    &copy; 2026 <strong>Zerodech</strong> — Waste Management Solution, Cameroon.
</footer>

</body>
</html>

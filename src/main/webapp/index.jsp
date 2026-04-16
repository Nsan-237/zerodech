<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zerodech — Gestion des Déchets Intelligente</title>
    <meta name="description" content="Zerodech simplifie la collecte des déchets au Cameroun. Planifiez vos enlèvements, suivez vos demandes et gérez vos abonnements.">
    <link rel="stylesheet" href="css/main.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <div class="navbar-brand">🌿 Zero<span>dech</span></div>
    <ul class="navbar-nav">
        <li><a href="#features">Fonctionnalités</a></li>
        <li><a href="login.jsp" class="btn-nav">Se Connecter</a></li>
        <li><a href="register.jsp" class="btn-nav" style="background:#f39c12;">S'inscrire</a></li>
    </ul>
</nav>

<!-- Hero -->
<section class="hero">
    <h1>La collecte des déchets<br><span>réinventée</span> pour le Cameroun</h1>
    <p>Planifiez vos enlèvements, suivez vos demandes en temps réel et gérez vos abonnements — le tout en un seul endroit.</p>
    <div class="hero-btns">
        <a href="register.jsp" class="btn-hero-primary">Commencer gratuitement</a>
        <a href="login.jsp" class="btn-hero-outline">J'ai déjà un compte</a>
    </div>
</section>

<!-- Features -->
<section class="features-section" id="features">
    <h2>Pourquoi choisir Zerodech ?</h2>
    <div class="features-grid">
        <div class="feature-card">
            <div class="feature-icon">📅</div>
            <h3>Demandes de collecte</h3>
            <p>Planifiez vos enlèvements à la date et l'heure qui vous conviennent. Choisissez votre type de déchets et votre adresse.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">📍</div>
            <h3>Suivi en temps réel</h3>
            <p>Suivez l'état de vos demandes à chaque étape — En attente, Assigné, En cours, Complété.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">💳</div>
            <h3>Abonnements flexibles</h3>
            <p>Choisissez parmi nos plans Basic, Standard ou Premium selon vos besoins et votre budget.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">⭐</div>
            <h3>Retours clients</h3>
            <p>Évaluez la qualité du service après chaque collecte et aidez-nous à nous améliorer continuellement.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">🚛</div>
            <h3>Collecteurs dédiés</h3>
            <p>Nos collecteurs agréés sont assignés à vos zones pour garantir une collecte efficace et ponctuelle.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">🛡️</div>
            <h3>Sécurisé & fiable</h3>
            <p>Votre compte et vos données sont protégés. Gérez votre profil en toute confiance.</p>
        </div>
    </div>
</section>

<!-- CTA Banner -->
<section style="background:var(--green-dark);padding:4rem 2rem;text-align:center;color:#fff;">
    <h2 style="font-size:2rem;margin-bottom:1rem;">Prêt à rejoindre Zerodech ?</h2>
    <p style="color:rgba(255,255,255,.75);margin-bottom:2rem;">Rejoignez des centaines de clients qui font confiance à notre service.</p>
    <a href="register.jsp" class="btn-hero-primary">Créer mon compte</a>
</section>

<footer class="footer">
    &copy; 2026 <strong>Zerodech</strong> — Solution de gestion des déchets, Cameroun.
</footer>

</body>
</html>

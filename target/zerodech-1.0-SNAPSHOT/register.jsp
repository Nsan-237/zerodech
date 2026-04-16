<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zerodech — Créer un compte</title>
    <link rel="stylesheet" href="css/main.css">
</head>
<body>
<div class="auth-page">
    <div class="form-card wide">
        <div class="auth-logo">
            <h2>🌿 Zerodech</h2>
            <p>Créez votre compte et rejoignez notre réseau.</p>
        </div>

        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
        <div class="error-box">⚠️ <%= error %></div>
        <% } %>

        <form id="registerForm" action="register" method="post" novalidate>

            <div class="form-row">
                <div class="form-group">
                    <label for="regName">Nom complet *</label>
                    <input type="text" id="regName" name="fullName"
                           placeholder="Marie Dupont" required>
                </div>
                <div class="form-group">
                    <label for="regPhone">Téléphone</label>
                    <input type="tel" id="regPhone" name="phone"
                           placeholder="+237 6XX XXX XXX">
                </div>
            </div>

            <div class="form-group">
                <label for="regEmail">Adresse email *</label>
                <input type="email" id="regEmail" name="email"
                       placeholder="exemple@email.com" required autocomplete="email">
            </div>

            <div class="form-group">
                <label for="regPassword">Mot de passe *</label>
                <input type="password" id="regPassword" name="password"
                       placeholder="Minimum 6 caractères" required autocomplete="new-password">
                <span class="form-hint">Au moins 6 caractères.</span>
            </div>

            <div class="form-group">
                <label for="regRole">Type de compte *</label>
                <select id="regRole" name="role" required>
                    <option value="CLIENT">Client — Je veux faire collecter mes déchets</option>
                    <option value="COLLECTOR">Collecteur — Je collecte les déchets</option>
                </select>
            </div>

            <div class="form-group">
                <label for="regAddress">Adresse / Quartier</label>
                <input type="text" id="regAddress" name="address"
                       placeholder="Douala Akwa, Cameroun">
            </div>

            <button type="submit" class="btn btn-primary btn-block" style="margin-top:.5rem;">
                Créer mon compte
            </button>
        </form>

        <div class="divider"></div>
        <p style="text-align:center;font-size:.9rem;color:var(--text-mid);">
            Déjà inscrit ? <a href="login.jsp">Se connecter</a>
        </p>
    </div>
</div>
<script src="js/validation.js"></script>
</body>
</html>
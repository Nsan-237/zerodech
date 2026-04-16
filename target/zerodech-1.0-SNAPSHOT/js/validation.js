/* ================================================================
   ZERODECH — Client-Side Form Validation
   ================================================================ */

(function () {
  'use strict';

  // Utility: show inline error under a field
  function showError(input, message) {
    clearError(input);
    input.classList.add('input-error');
    const err = document.createElement('span');
    err.className = 'field-error';
    err.textContent = message;
    err.style.cssText = 'color:#b91c1c;font-size:.78rem;margin-top:.2rem;display:block;';
    input.parentNode.appendChild(err);
  }

  function clearError(input) {
    input.classList.remove('input-error');
    const existing = input.parentNode.querySelector('.field-error');
    if (existing) existing.remove();
  }

  function isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  }

  function isValidPhone(phone) {
    return /^[\+]?[\d\s\-]{7,16}$/.test(phone.trim());
  }

  // ── LOGIN FORM ──────────────────────────────────────────────
  const loginForm = document.getElementById('loginForm');
  if (loginForm) {
    loginForm.addEventListener('submit', function (e) {
      let valid = true;
      const email    = document.getElementById('loginEmail');
      const password = document.getElementById('loginPassword');

      clearError(email); clearError(password);

      if (!email.value.trim()) {
        showError(email, 'L\'adresse email est requise.'); valid = false;
      } else if (!isValidEmail(email.value.trim())) {
        showError(email, 'Adresse email invalide.'); valid = false;
      }
      if (!password.value) {
        showError(password, 'Le mot de passe est requis.'); valid = false;
      }
      if (!valid) e.preventDefault();
    });
  }

  // ── REGISTER FORM ───────────────────────────────────────────
  const registerForm = document.getElementById('registerForm');
  if (registerForm) {
    registerForm.addEventListener('submit', function (e) {
      let valid = true;
      const name     = document.getElementById('regName');
      const email    = document.getElementById('regEmail');
      const password = document.getElementById('regPassword');
      const phone    = document.getElementById('regPhone');

      [name, email, password, phone].forEach(clearError);

      if (!name.value.trim() || name.value.trim().length < 3) {
        showError(name, 'Nom complet requis (min. 3 caractères).'); valid = false;
      }
      if (!email.value.trim() || !isValidEmail(email.value.trim())) {
        showError(email, 'Adresse email valide requise.'); valid = false;
      }
      if (!password.value || password.value.length < 6) {
        showError(password, 'Mot de passe requis (min. 6 caractères).'); valid = false;
      }
      if (phone.value && !isValidPhone(phone.value)) {
        showError(phone, 'Numéro de téléphone invalide.'); valid = false;
      }
      if (!valid) e.preventDefault();
    });
  }

  // ── PICKUP REQUEST FORM ─────────────────────────────────────
  const pickupForm = document.getElementById('pickupForm');
  if (pickupForm) {
    pickupForm.addEventListener('submit', function (e) {
      let valid = true;
      const location = document.getElementById('pickupLocation');
      const date     = document.getElementById('pickupDate');

      clearError(location); clearError(date);

      if (!location.value.trim() || location.value.trim().length < 5) {
        showError(location, 'Adresse de collecte requise (min. 5 caractères).'); valid = false;
      }
      if (!date.value) {
        showError(date, 'Veuillez choisir une date de collecte.'); valid = false;
      } else {
        const chosen = new Date(date.value);
        const today  = new Date();
        today.setHours(0,0,0,0);
        if (chosen < today) {
          showError(date, 'La date doit être aujourd\'hui ou dans le futur.'); valid = false;
        }
      }
      if (!valid) e.preventDefault();
    });
  }

  // ── INPUT STYLE: red border for invalid ─────────────────────
  const style = document.createElement('style');
  style.textContent = '.input-error { border-color: #e74c3c !important; box-shadow: 0 0 0 3px rgba(231,76,60,.12) !important; }';
  document.head.appendChild(style);

})();

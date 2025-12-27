
(function() {
  function autoCloseAlerts() {
    try {
      const els = document.querySelectorAll('.alert[data-autoclose="true"]');
      els.forEach(el => {
        // Wait a short moment (3s) then close via Bootstrap's Alert API if available
        setTimeout(() => {
          try {
            if (window.bootstrap && bootstrap.Alert) {
              new bootstrap.Alert(el).close();
            } else {
              // fallback: remove element gracefully
              el.classList.remove('show');
              el.style.display = 'none';
            }
          } catch (e) {
            // fallback hide
            el.classList.remove('show');
            el.style.display = 'none';
          }
        },5000);
      });
    } catch (e) { /* ignore */ }
  }
  document.addEventListener('DOMContentLoaded', autoCloseAlerts);
  // Turbo (if used) fires this on each page change
  document.addEventListener('turbo:load', autoCloseAlerts);
})();
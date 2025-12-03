document.addEventListener("turbo:load", () => {
  const loginModalElement = document.getElementById("loginModal");
  
  if (!loginModalElement) return;

  const loginModal = new bootstrap.Modal(loginModalElement);

  document.querySelectorAll('[data-bs-target="#loginModal"]').forEach((button) => {
    button.addEventListener("click", (event) => {
      event.preventDefault();
      loginModal.show();
    });
  });
});

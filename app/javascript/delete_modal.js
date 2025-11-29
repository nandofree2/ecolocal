document.addEventListener("turbo:load", () => {
  const modalElement = document.getElementById("deleteConfirmModal");
  const deleteForm = document.getElementById("deleteConfirmForm");
  const itemNameElement = document.getElementById("delete-item-name");
  const itemSkuElement = document.getElementById("delete-item-sku");
  const fadeItem = document.querySelector(".fade-item");

  if (!modalElement || !deleteForm || !itemNameElement || !itemSkuElement) return;

  const modal = new bootstrap.Modal(modalElement);

  document.querySelectorAll(".show-delete-modal").forEach((button) => {
    button.addEventListener("click", (event) => {
      event.preventDefault();

      const url  = button.dataset.url;
      const name = button.dataset.name;
      const sku  = button.dataset.sku;

      deleteForm.action = url;

      // Set name + sku
      itemNameElement.textContent = name;
      itemSkuElement.textContent  = sku;

      // Fade-in animation
      fadeItem.classList.remove("showing");
      setTimeout(() => fadeItem.classList.add("showing"), 10);

      modal.show();
    });
  });
});

document.addEventListener("turbo:load", () => {
  const modalElement = document.getElementById("category-deleteConfirmModal");
  const deleteForm = document.getElementById("category-deleteConfirmForm");
  const itemNameElement = document.getElementById("category-delete-item-name");
  const itemSkuElement = document.getElementById("category-delete-item-sku");
  const fadeItem = document.querySelector(".fade-item");

  if (!modalElement || !deleteForm || !itemNameElement || !itemSkuElement) return;

  const modal = new bootstrap.Modal(modalElement);

  document.querySelectorAll(".category-show-delete-modal").forEach((button) => {
    button.addEventListener("click", (event) => {
      event.preventDefault();

      const url  = button.dataset.url;
      const name = button.dataset.name;
      const sku  = button.dataset.sku;

      deleteForm.action = url;

      itemNameElement.textContent = name;
      itemSkuElement.textContent  = sku;

      fadeItem.classList.remove("showing");
      setTimeout(() => fadeItem.classList.add("showing"), 10);

      modal.show();
    });
  });
});

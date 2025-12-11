document.addEventListener("turbo:load", () => {
  const modalElement = document.getElementById("product-deleteConfirmModal");
  const deleteForm = document.getElementById("product-deleteConfirmForm");
  const itemNameElement = document.getElementById("product-delete-item-name");
  const itemSkuElement = document.getElementById("product-delete-item-sku");
  const fadeItem = document.querySelector(".fade-item");
  console.log("product_delete_modal loaded");

  if (!modalElement || !deleteForm || !itemNameElement || !itemSkuElement) return;

  const modal = new bootstrap.Modal(modalElement);

  document.querySelectorAll(".product-show-delete-modal").forEach((button) => {
    button.addEventListener("click", (event) => {
      event.preventDefault();
      console.log("Delete button clicked");

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

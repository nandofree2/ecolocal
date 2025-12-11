document.addEventListener("turbo:load", () => {
  const modalElement = document.getElementById("province-deleteConfirmModal");
  const deleteForm = document.getElementById("province-deleteConfirmForm");
  const itemNameElement = document.getElementById("province-delete-item-name");
  const itemSkuElement = document.getElementById("province-delete-item-sku");
  const fadeItem = document.querySelector(".fade-item");

  if (!modalElement || !deleteForm || !itemNameElement || !itemSkuElement) return;

  const modal = new bootstrap.Modal(modalElement);

  document.querySelectorAll(".province-show-delete-modal").forEach((button) => {
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

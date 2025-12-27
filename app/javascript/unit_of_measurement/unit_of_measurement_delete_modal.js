document.addEventListener("turbo:load", () => {
  const modalElement = document.getElementById("unit-of-measurement-deleteConfirmModal");
  const deleteForm = document.getElementById("unit-of-measurement-deleteConfirmForm");
  const itemNameElement = document.getElementById("unit-of-measurement-delete-item-name");
  const itemSkuElement = document.getElementById("unit-of-measurement-delete-item-sku");
  const fadeItem = document.querySelector(".fade-item");

  if (!modalElement || !deleteForm || !itemNameElement || !itemSkuElement) return;

  const modal = new bootstrap.Modal(modalElement);

  document.querySelectorAll(".unit-of-measurement-show-delete-modal").forEach((button) => {
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

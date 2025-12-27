document.addEventListener("turbo:load", () => {
  const carousel = document.querySelector("#productCarousel");
  const bsCarousel = carousel ? new bootstrap.Carousel(carousel) : null;

  document.querySelectorAll(".thumb-img").forEach(thumb => {
    thumb.addEventListener("click", () => {
      const index = thumb.dataset.index;
      bsCarousel.to(index);

      document.querySelectorAll(".thumb-img").forEach(t => t.classList.remove("active-thumb"));
      thumb.classList.add("active-thumb");
    });
  });

  document.querySelectorAll(".gallery-main-img").forEach(img => {
    img.addEventListener("click", () => {
      document.getElementById("fullscreenImage").src = img.dataset.full;
      const modal = new bootstrap.Modal(document.getElementById("fullscreenGalleryModal"));
      modal.show();
    });
  });

  const first = document.querySelector(".thumb-img");
  if (first) first.classList.add("active-thumb");
});

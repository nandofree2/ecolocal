window.previewCoverImage = function(event) {
  const reader = new FileReader();
  reader.onload = function() {
    const output = document.getElementById("coverPreview");
    output.src = reader.result;
    output.classList.remove("d-none");
  };
  reader.readAsDataURL(event.target.files[0]);
};

window.previewMultipleImages = function(event) {
  const container = document.getElementById("previewContainer");
  container.innerHTML = "";

  Array.from(event.target.files).slice(0, 5).forEach(file => {
    const reader = new FileReader();
    reader.onload = function(e) {
      const img = document.createElement("img");
      img.src = e.target.result;
      img.classList.add("img-thumbnail", "mr-2", "mb-2");
      img.style.maxHeight = "120px";
      container.appendChild(img);
    };
    reader.readAsDataURL(file);
  });
};

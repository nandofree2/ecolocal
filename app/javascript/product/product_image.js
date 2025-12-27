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
  if (!container) return;

  const existingCount = container.querySelectorAll('img.img-thumbnail').length;
  const files = Array.from(event.target.files || []).filter(f => f && f.size > 0);

  // enforce client-side max of 5 total images
  const maxAllowed = Math.max(0, 5 - existingCount);
  if (files.length > maxAllowed) {
    alert(`You can only add ${maxAllowed} more preview image(s).`);
  }

  files.slice(0, maxAllowed).forEach(file => {
    const reader = new FileReader();
    reader.onload = function(e) {
      const wrapper = document.createElement('div');
      wrapper.classList.add('me-2', 'mb-2');

      const img = document.createElement("img");
      img.src = e.target.result;
      img.classList.add("img-thumbnail");
      img.style.maxHeight = "120px";
      img.classList.add('temp-preview');
      wrapper.appendChild(img);

      container.appendChild(wrapper);
    };
    reader.readAsDataURL(file);
  });
};

document.addEventListener('DOMContentLoaded', () => {
  // Delegate remove preview button clicks
  document.addEventListener('click', async (e) => {
    const btn = e.target.closest && e.target.closest('.remove-preview-btn');
    if (!btn) return;
    e.preventDefault();

    const url = btn.dataset.url;
    if (!url) return;

    if (!confirm('Remove this image?')) return;

    btn.disabled = true;
    const token = document.querySelector('meta[name=csrf-token]')?.content;

    try {
      const resp = await fetch(url, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': token || '',
          'Accept': 'application/json'
        }
      });

      if (resp.ok) {
        // remove the thumbnail wrapper
        const wrapper = btn.closest('.me-2');
        if (wrapper) wrapper.remove();
      } else {
        const text = await resp.text();
        alert('Failed to remove image');
        console.error('Remove preview failed', resp.status, text);
      }
    } catch (err) {
      console.error(err);
      alert('Failed to remove image');
    } finally {
      btn.disabled = false;
    }
  });
});

function initCategoryForm() {
  const form = document.getElementById("category-form");
  const tableBody = document.querySelector('#category-table-body');
  const submitBtn = document.getElementById("submit-btn");
  form.onsubmit = function(event) {
    event.preventDefault();
    clearErrors();
    submitBtn.disabled = true;
    submitBtn.innerText = "Saving...";
    const formData = new FormData(form);
    fetch(form.action, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: formData
    })
    .then(async response => {
      const data = await response.json();
      if (!response.ok) throw data;
      return data;
    })
    .then(category => {
      function escapeHTML(str) {
        return String(str || '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;');
      }

      const newRowHTML = `
        <tr id="category_row_${category.id}" class="fade-in-row">
          <td class="row-number"></td>
          <td>${escapeHTML(category.name)}</td>
          <td>${escapeHTML(category.sku)}</td>
          <td>${escapeHTML(category.description || '')}</td>
          <td class="text-right">
            <a href="/categories/${category.id}" class="btn btn-sm btn-info"><i class="fas fa-eye"></i></a>
            <a href="#" class="btn btn-sm btn-warning edit-category-btn" data-bs-toggle="modal" data-bs-target="#categoryModalEdit" data-id="${category.id}" data-name="${escapeHTML(category.name)}" data-sku="${escapeHTML(category.sku)}" data-description="${escapeHTML(category.description || '')}" data-url="/categories/${category.id}"><i class="fas fa-pencil-alt"></i></a>
            <button type="button" class="btn btn-sm btn-danger category-show-delete-modal" data-url="/categories/${category.id}" data-name="${escapeHTML(category.name)}" data-sku="${escapeHTML(category.sku)}"><i class="fas fa-trash"></i></button>
          </td>
        </tr>
      `;
      tableBody.insertAdjacentHTML('afterbegin', newRowHTML);
      updateTableNumbers();
      form.reset();
      showMiniPopup(category.name, category.sku);
      
      document.getElementById('cat_name').focus();
    })
    .catch(errors => {
      displayErrors(errors);
    })
    .finally(() => {
      submitBtn.disabled = false;
      submitBtn.innerText = "Create Category";
    });
  };
}
function showMiniPopup(name, sku) {
  const popup = document.createElement('div');
  popup.className = 'alert alert-success success-toast animate__animated animate__fadeInDown';
  popup.innerHTML = `
    <div class="d-flex align-items-center">
      <i class="fas fa-check-circle mr-2"></i>
      <span><strong> Category: ${name}</strong> with SKU: ${sku} created!</span>
    </div>
  `;
  document.body.appendChild(popup);
  setTimeout(() => {
    popup.classList.replace('animate__fadeInDown', 'animate__fadeOutUp');
    setTimeout(() => popup.remove(), 3000);
  }, 3000);
}
function updateTableNumbers() {
  const rows = document.querySelectorAll("#category-table-body tr");

  rows.forEach((row, index) => {
      const numberCell = row.cells[0]; 
      
      if (numberCell) {
          numberCell.innerText = index + 1;
      }
  });
}
function clearErrors() {
  document.querySelectorAll('.is-invalid').forEach(el => el.classList.remove('is-invalid'));
  document.querySelectorAll('.invalid-feedback').forEach(el => el.innerText = '');
}
function displayErrors(errors) {
  for (const [field, messages] of Object.entries(errors)) {
    const input = document.getElementById(`cat_${field}`);
    const errorDiv = document.getElementById(`error-${field}`);
    if (input && errorDiv) {
      input.classList.add('is-invalid');
      const customMsg = messages.map(m => {
        if (m.includes("taken")) return `Duplicate ${field}`;
        return m;
      }).join(", ");
      errorDiv.innerText = customMsg;
    }
  }
}
document.addEventListener("turbo:load", initCategoryForm);
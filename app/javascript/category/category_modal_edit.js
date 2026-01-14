function initCategoryEditForm() {
  const form = document.getElementById("category-form-edit");
  const tableBody = document.querySelector('#category-table-body');
  const submitBtn = document.getElementById("submit-btn-edit");
  document.addEventListener("click", (e) => {
    const editBtn = e.target.closest(".edit-category-btn");
    if (editBtn) {
      e.preventDefault();
      clearErrorsEdit();
      const id = editBtn.dataset.id;
      const row = editBtn.closest('tr');
      if (row && id && !row.id) row.id = `category_row_${id}`;
      form.dataset.editingId = id || '';
      form.dataset.originalName = editBtn.dataset.name || '';
      form.dataset.originalSku = editBtn.dataset.sku || '';
      form.dataset.originalDescription = editBtn.dataset.description || '';
      document.getElementById("cat_name_edit").value = editBtn.dataset.name || '';
      document.getElementById("cat_sku_edit").value = editBtn.dataset.sku || '';
      document.getElementById("cat_description_edit").value = editBtn.dataset.description || '';
      form.action = editBtn.dataset.url;
      const modalEl = document.getElementById('categoryModalEdit');
      const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
      modal.show();
    }
  });
  form.onsubmit = function(event) {
    event.preventDefault();
    clearErrorsEdit();
    const name = document.getElementById('cat_name_edit').value.trim();
    const sku = document.getElementById('cat_sku_edit').value.trim();
    const description = document.getElementById('cat_description_edit').value.trim();
    const origName = form.dataset.originalName || '';
    const origSku = form.dataset.originalSku || '';
    const origDescription = form.dataset.originalDescription || '';
    if (name === origName && sku === origSku && description === origDescription) {
      let existingAlert = form.querySelector('.alert-no-changes');
      if (!existingAlert) {
        const alertDiv = document.createElement('div');
        alertDiv.className = 'alert alert-warning alert-no-changes';
        alertDiv.innerText = 'No changes detected.';
        form.querySelector('.modal-body').prepend(alertDiv);
        setTimeout(() => alertDiv.remove(), 2500);
      }
      return;
    }
    submitBtn.disabled = true;
    submitBtn.innerText = "Saving...";
    const formData = new FormData(form);
    fetch(form.action, {
      method: "PUT",
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
      const row = document.getElementById(`category_row_${category.id}`);
      const rowHTML = `
        <td class="row-number"></td>
        <td>${category.name}</td>
        <td>${category.sku}</td>
        <td>${category.description || ''}</td>
        <td class="text-right">
          <a href="/categories/${category.id}" class="btn btn-sm btn-info"><i class="fas fa-eye"></i></a>
          <a href="#" class="btn btn-sm btn-warning edit-category-btn" data-bs-toggle="modal" data-bs-target="#categoryModalEdit" data-id="${category.id}" data-name="${category.name}" data-sku="${category.sku}" data-description="${category.description || ''}" data-url="/categories/${category.id}"><i class="fas fa-pencil-alt"></i></a>
          <form class="d-inline" action="/categories/${category.id}" method="post">
            <input type="hidden" name="_method" value="delete">
            <input type="hidden" name="authenticity_token" value="${document.querySelector('meta[name="csrf-token"]').content}">
            <button type="submit" class="btn btn-sm btn-danger"><i class="fas fa-trash"></i></button>
          </form>
        </td>
      `;
      if (row) {
        row.innerHTML = rowHTML;
      } else {
        tableBody.insertAdjacentHTML('afterbegin', `<tr id="category_row_${category.id}" class="fade-in-row">${rowHTML}</tr>`);
      }
      updateTableNumbersEdit();
      form.reset();
      showMiniPopupEdit(category.name, category.sku, 'updated');
      const modalEl = document.getElementById('categoryModalEdit');
      const modalInstance = bootstrap.Modal.getOrCreateInstance(modalEl);
      modalInstance.hide();
      document.getElementById('cat_name_edit').focus();
    })
    .catch(errors => {
      displayErrorsEdit(errors);
    })
    .finally(() => {
      submitBtn.disabled = false;
      submitBtn.innerText = "Update Category";
    });
  };
}
function showMiniPopupEdit(name, sku, action = 'created') {
  const popup = document.createElement('div');
  popup.className = 'alert alert-success success-toast animate__animated animate__fadeInDown';
  popup.innerHTML = `
    <div class="d-flex align-items-center">
      <i class="fas fa-check-circle mr-2"></i>
      <span><strong> Category: ${name}</strong> with SKU: ${sku} ${action}!</span>
    </div>
  `;
  document.body.appendChild(popup);
  setTimeout(() => {
    popup.classList.replace('animate__fadeInDown', 'animate__fadeOutUp');
    setTimeout(() => popup.remove(), 3000);
  }, 3000);
}
function updateTableNumbersEdit() {
  const rows = document.querySelectorAll("#category-table-body tr");
  rows.forEach((row, index) => {
    const numberCell = row.cells[0];
    if (numberCell) numberCell.innerText = index + 1;
  });
}
function clearErrorsEdit() {
  document.querySelectorAll('.is-invalid').forEach(el => el.classList.remove('is-invalid'));
  document.querySelectorAll('.invalid-feedback').forEach(el => el.innerText = '');
  const noChange = document.querySelector('.alert-no-changes');
  if (noChange) noChange.remove();
}
function displayErrorsEdit(errors) {
  for (const [field, messages] of Object.entries(errors)) {
    const input = document.getElementById(`cat_${field}_edit`) || document.getElementById(`cat_${field}`);
    const errorDiv = document.querySelector('#category-form-edit #error-' + field) || document.getElementById(`error-${field}`);
    if (input && errorDiv) {
      input.classList.add('is-invalid');
      const customMsg = messages.map(m => {
        if (m.includes("taken")) return `Duplicate ${field}`;
        return m;
      }).join(", ");
      errorDiv.innerText = customMsg;
      errorDiv.style.display = '';
    }
  }
}
document.addEventListener("turbo:load", initCategoryEditForm);
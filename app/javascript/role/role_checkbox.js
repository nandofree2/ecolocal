document.addEventListener('DOMContentLoaded', function () {
  // Select all in a row
  document.querySelectorAll('.select-all-row').forEach(function (checkbox) {
    checkbox.addEventListener('change', function () {
      const resource = this.dataset.resource;
      const isChecked = this.checked;
      document.querySelectorAll('.permission-checkbox[data-resource="' + resource + '"]').forEach(function (cb) {
        cb.checked = isChecked;
      });
    });
  });

  // Select all in a column
  document.querySelectorAll('.select-all-column').forEach(function (checkbox) {
    checkbox.addEventListener('change', function () {
      const action = this.dataset.action;
      const isChecked = this.checked;
      document.querySelectorAll('.permission-checkbox[data-action="' + action + '"]').forEach(function (cb) {
        cb.checked = isChecked;
      });
      updateRowSelectAll();
    });
  });

  // Select all permissions
  document.addEventListener('DOMContentLoaded', function () {
    const selectAllBtn = document.getElementById('select-all-permissions');
    
    // Check if the element exists first to avoid errors on other pages
    if (selectAllBtn) {
        selectAllBtn.addEventListener('click', function () {
            const allChecked = document.querySelectorAll('.permission-checkbox:checked').length ===
                               document.querySelectorAll('.permission-checkbox').length;
            
            document.querySelectorAll('.permission-checkbox').forEach(function (cb) {
                cb.checked = !allChecked;
            });
            
            document.querySelectorAll('.select-all-row, .select-all-column').forEach(function (cb) {
                cb.checked = !allChecked;
            });
        });
    }
});

  // Update row select-all checkboxes based on individual checkboxes
  function updateRowSelectAll() {
    document.querySelectorAll('.select-all-row').forEach(function (rowCheckbox) {
      const resource = rowCheckbox.dataset.resource;
      const total = document.querySelectorAll('.permission-checkbox[data-resource="' + resource + '"]').length;
      const checked = document.querySelectorAll('.permission-checkbox[data-resource="' + resource + '"]:checked').length;
      rowCheckbox.checked = total === checked;
    });
  }

  // Update column select-all checkboxes based on individual checkboxes
  function updateColumnSelectAll() {
    document.querySelectorAll('.select-all-column').forEach(function (colCheckbox) {
      const action = colCheckbox.dataset.action;
      const total = document.querySelectorAll('.permission-checkbox[data-action="' + action + '"]').length;
      const checked = document.querySelectorAll('.permission-checkbox[data-action="' + action + '"]:checked').length;
      colCheckbox.checked = total === checked;
    });
  }

  // Listen for changes on individual checkboxes
  document.querySelectorAll('.permission-checkbox').forEach(function (cb) {
    cb.addEventListener('change', function () {
      updateRowSelectAll();
      updateColumnSelectAll();
    });
  });

  // Initialize select-all states on page load
  updateRowSelectAll();
  updateColumnSelectAll();
});
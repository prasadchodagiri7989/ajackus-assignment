document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('employee-grid');

  const renderEmployees = () => {
    container.innerHTML = '';
    mockEmployees.forEach(emp => {
      const card = document.createElement('div');
      card.className = 'employee-card';
      card.innerHTML = `
        <h3>${emp.firstName} ${emp.lastName}</h3>
        <p>Email: ${emp.email}</p>
        <p>Department: ${emp.department}</p>
        <p>Role: ${emp.role}</p>
        <button class="edit-btn" data-id="${emp.id}">Edit</button>
        <button class="delete-btn" data-id="${emp.id}">Delete</button>
      `;
      container.appendChild(card);
    });
  };

  const handleDelete = (id) => {
    const index = mockEmployees.findIndex(emp => emp.id == id);
    if (index > -1) {
      mockEmployees.splice(index, 1);
      renderEmployees();
    }
  };

  container.addEventListener('click', event => {
    if (event.target.classList.contains('delete-btn')) {
      const id = event.target.getAttribute('data-id');
      if (confirm('Are you sure you want to delete this employee?')) {
        handleDelete(id);
      }
    }

    if (event.target.classList.contains('edit-btn')) {
      const id = event.target.getAttribute('data-id');
      alert(`Edit functionality for employee ID ${id} not implemented yet.`);
    }
  });

  renderEmployees();
});

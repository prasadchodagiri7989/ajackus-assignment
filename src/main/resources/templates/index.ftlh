<#assign employees = mockEmployeeList>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Employee Directory</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    html, body {
      height: 100%;
      display: flex;
      flex-direction: column;
      font-family: Arial, sans-serif;
      background-color: #f4f6f8;
    }

    main {
      flex: 1;
      display: flex;
      flex-direction: column;
      padding: 20px;
    }

    header {
      background-color: #007BFF;
      color: white;
      padding: 20px;
      text-align: center;
    }

    header h1 {
      margin-bottom: 15px;
    }

    .controls {
      display: flex;
      gap: 10px;
      flex-wrap: wrap;
      justify-content: center;
      margin-bottom: 25px;
    }

    .controls input,
    .controls select {
      padding: 8px;
      border-radius: 4px;
      border: 1px solid #ccc;
      min-width: 160px;
    }

    .employee-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 20px;
      width: 100%;
      max-width: 1200px;
      margin: auto;
    }

    .employee-card {
      background-color: #fff;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      transition: transform 0.2s ease;
    }

    .employee-card:hover {
      transform: translateY(-5px);
    }

    .employee-card h3 {
      margin: 0 0 10px;
      color: #222;
    }

    .employee-card p {
      margin: 4px 0;
      color: #555;
      font-size: 14px;
    }

    button {
      margin-top: 10px;
      margin-right: 8px;
      padding: 8px 12px;
      border: none;
      border-radius: 4px;
      font-size: 14px;
      cursor: pointer;
      color: #fff;
    }

    .edit-btn {
      background-color: #007BFF;
    }

    .delete-btn {
      background-color: #DC3545;
    }

    .add-button {
      background-color: green;
      color: #fff;
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      font-size: 16px;
      margin-top: 20px;
      display: block;
      margin-left: auto;
      margin-right: auto;
    }

    footer {
      background-color: #000;
      color: #fff;
      padding: 15px 0;
      text-align: center;
      font-size: 14px;
    }

    .employee-card a {
      display: inline-block;
    }

    @media (max-width: 600px) {
      .controls {
        flex-direction: column;
        align-items: stretch;
      }
    }
  </style>
</head>
<body>
  <header>
    <h1>Employee Directory</h1>
    <div class="controls">
      <input type="text" id="searchInput" placeholder="Search..." onkeyup="filterEmployees()" />

      <select id="departmentFilter" onchange="filterEmployees()">
        <option value="">All Departments</option>
        <#assign departments = []>
        <#list employees as emp>
          <#if !(departments?seq_contains(emp.department))>
            <#assign departments += [emp.department]>
          </#if>
        </#list>
        <#list departments?sort as dept>
          <option value="${dept}">${dept}</option>
        </#list>
      </select>

      <select id="sortSelect" onchange="filterEmployees()">
        <option value="az">Sort: A-Z</option>
        <option value="za">Sort: Z-A</option>
      </select>
    </div>
  </header>

  <main>
    <div class="employee-grid" id="employee-grid">
      <#if employees?? && employees?size gt 0>
        <#list employees as emp>
          <div class="employee-card"
               data-id="${emp.id}"
               data-name="${emp.firstName?lower_case} ${emp.lastName?lower_case}"
               data-email="${emp.email?lower_case}"
               data-department="${emp.department?lower_case}"
               data-role="${emp.role?lower_case}">
            <h3>${emp.firstName} ${emp.lastName}</h3>
            <p>Email: ${emp.email}</p>
            <p>Department: ${emp.department}</p>
            <p>Role: ${emp.role}</p>
            <a href="/form?action=edit&id=${emp.id}">
              <button class="edit-btn">Edit</button>
            </a>
            <a href="/?action=delete&id=${emp.id}" onclick="return confirm('Are you sure to delete this employee?');">
              <button class="delete-btn">Delete</button>
            </a>
          </div>
        </#list>
      <#else>
        <p style="text-align:center;">No employees found.</p>
      </#if>
    </div>

    <form action="/form" method="get" style="text-align:center;">
      <button class="add-button">Add Employee</button>
    </form>
  </main>

  <footer>
    <p>&copy; 2025 Employee Directory WebApp. All rights reserved.</p>
  </footer>

  <script>
    function filterEmployees() {
      const searchText = document.getElementById('searchInput').value.toLowerCase()
      const deptFilter = document.getElementById('departmentFilter').value.toLowerCase()
      const sortOrder = document.getElementById('sortSelect').value

      const cards = [...document.querySelectorAll('.employee-card')]

      cards.forEach(card => {
        const name = card.dataset.name
        const email = card.dataset.email
        const department = card.dataset.department
        const role = card.dataset.role

        const matchesSearch = name.includes(searchText) || email.includes(searchText) || role.includes(searchText)
        const matchesDept = deptFilter === '' || department === deptFilter

        card.style.display = matchesSearch && matchesDept ? 'block' : 'none'
      })

      const grid = document.getElementById('employee-grid')
      const visibleCards = cards.filter(card => card.style.display !== 'none')

      visibleCards.sort((a, b) => {
        const nameA = a.dataset.name
        const nameB = b.dataset.name
        return sortOrder === 'az' ? nameA.localeCompare(nameB) : nameB.localeCompare(nameA)
      })

      visibleCards.forEach(card => grid.appendChild(card))
    }
  </script>
</body>
</html>

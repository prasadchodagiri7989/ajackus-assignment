<#if editEmployee??>
  <#assign formData = editEmployee>
<#else>
  <#assign formData = {} >
</#if>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>${formData?has_content?then("Edit", "Add")} Employee</title>
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
      background: #f4f6f8;
    }

    header {
      background-color: #007BFF;
      padding: 20px;
      text-align: center;
      color: white;
    }

    header h1 {
      margin: 0;
    }

    main {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 40px 20px;
    }

    .form-container {
      background: white;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.1);
      width: 100%;
      max-width: 500px;
      animation: fadeIn 0.3s ease-in-out;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    h2 {
      text-align: center;
      color: #333;
      margin-bottom: 25px;
    }

    .form-group {
      margin-bottom: 1.2rem;
    }

    label {
      display: block;
      margin-bottom: 0.5rem;
      font-weight: bold;
      color: #444;
    }

    input[type="text"],
    input[type="email"] {
      width: 100%;
      padding: 0.8rem;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 15px;
      transition: border-color 0.2s;
    }

    input:focus {
      outline: none;
      border-color: #007BFF;
    }

    .error-message {
      color: red;
      font-size: 0.85rem;
      margin-top: 0.3rem;
    }

    button {
      width: 100%;
      padding: 0.9rem;
      background-color: #007BFF;
      border: none;
      color: white;
      font-size: 1rem;
      border-radius: 5px;
      cursor: pointer;
      transition: background 0.3s;
    }

    button:hover {
      background-color: #0056b3;
    }

    .back-link {
      display: block;
      text-align: center;
      margin-top: 1rem;
      color: #007BFF;
      text-decoration: none;
      font-weight: bold;
    }

    .back-link:hover {
      text-decoration: underline;
    }

    footer {
      background-color: #000;
      color: #fff;
      padding: 15px 0;
      text-align: center;
      font-size: 14px;
    }

    @media (max-width: 600px) {
      .form-container {
        padding: 20px;
      }
    }
  </style>
</head>
<body>

  <header>
    <h1>Employee Directory</h1>
  </header>

  <main>
    <div class="form-container">
      <h2>${formData?has_content?then("Edit", "Add")} Employee</h2>
      <form id="employee-form" method="POST" action="/form">
        <input type="hidden" name="id" value="${formData.id!}" />

        <div class="form-group">
          <label for="firstName">First Name *</label>
          <input type="text" id="firstName" name="firstName" required value="${formData.firstName!}" />
          <div class="error-message" id="firstNameError"></div>
        </div>

        <div class="form-group">
          <label for="lastName">Last Name *</label>
          <input type="text" id="lastName" name="lastName" required value="${formData.lastName!}" />
          <div class="error-message" id="lastNameError"></div>
        </div>

        <div class="form-group">
          <label for="email">Email *</label>
          <input type="email" id="email" name="email" required value="${formData.email!}" />
          <div class="error-message" id="emailError"></div>
        </div>

        <div class="form-group">
          <label for="department">Department *</label>
          <input type="text" id="department" name="department" required value="${formData.department!}" />
          <div class="error-message" id="departmentError"></div>
        </div>

        <div class="form-group">
          <label for="role">Role *</label>
          <input type="text" id="role" name="role" required value="${formData.role!}" />
          <div class="error-message" id="roleError"></div>
        </div>

        <button type="submit">Save Employee</button>
      </form>

      <a class="back-link" href="/">← Back to Directory</a>
    </div>
  </main>

  <footer>
    <p>&copy; 2025 Employee Directory WebApp. All rights reserved.</p>
  </footer>

</body>
</html>

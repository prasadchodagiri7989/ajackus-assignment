# Employee Directory WebApp

A simple employee directory management system built using **Java**, **Freemarker templates**, **Jetty server**, and **HTML/CSS/JavaScript**.

## Features

- List all employees
- Add a new employee
- Edit existing employee details
- Delete an employee
- Filter and sort employees by department or name

## Tech Stack

- Java 17+
- Jetty Server (embedded)
- Freemarker Template Engine
- HTML, CSS, JavaScript

## Folder Structure

```
employee-directory/
├── src/
│   ├── main/
│   │   ├── java/com/example/employees/  → Java source code
│   │   ├── resources/
│   │   │   ├── templates/               → Freemarker templates
│   │   │   ├── static/css/              → CSS styles
│   │   │   └── static/                  → Static assets
```

## How to Run This Project

### Prerequisites

- Java JDK 19
- Maven

### Steps

1. **Clone or Download the project**

```bash
git clone https://github.com/prasadchodagiri7989/ajackus-assignment.git
```

2. **Navigate to project folder**

```bash
cd ajackus-assignment
```

3. **Compile and Run**

You can use any Java IDE or run using CLI:

```bash
mvn clean compile
mvn exec:java -Dexec.mainClass="com.example.employees.Main"
```

4. **Open the Web App**

Visit `http://localhost:8081` in your browser.

## Author

Developed by Prasad Chodagiri


package com.example.employees;

import freemarker.template.*;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.servlet.*;

import java.io.*;
import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception {
        Server server = new Server(8081);

        ServletContextHandler context = new ServletContextHandler(ServletContextHandler.SESSIONS);
        context.setContextPath("/");
        context.setResourceBase("src/main/resources");

        // Serve static resources
        ServletHolder defaultServlet = new ServletHolder("default", DefaultServlet.class);
        defaultServlet.setInitParameter("dirAllowed", "true");
        defaultServlet.setInitParameter("resourceBase", new File("src/main/resources/static").getAbsolutePath());
        context.addServlet(defaultServlet, "/static/*");

        // Register servlet
        context.addServlet(EmployeeServlet.class, "/");

        server.setHandler(context);
        server.start();
        server.join();
    }

    public static class EmployeeServlet extends HttpServlet {
        private Configuration cfg;
        private final List<Map<String, String>> employeeList = new ArrayList<>();

        @Override
        public void init() throws ServletException {
            cfg = new Configuration(Configuration.VERSION_2_3_31);
            cfg.setClassLoaderForTemplateLoading(getClass().getClassLoader(), "templates");
            cfg.setDefaultEncoding("UTF-8");

            // Sample Indian employees
            employeeList.add(new HashMap<>(Map.of(
                    "id", "1",
                    "firstName", "Aarav",
                    "lastName", "Mehra",
                    "email", "aarav.mehra@example.com",
                    "department", "Human Resources",
                    "role", "HR Executive")));

            employeeList.add(new HashMap<>(Map.of(
                    "id", "2",
                    "firstName", "Neha",
                    "lastName", "Reddy",
                    "email", "neha.reddy@example.com",
                    "department", "IT",
                    "role", "Frontend Developer")));

            employeeList.add(new HashMap<>(Map.of(
                    "id", "3",
                    "firstName", "Raj",
                    "lastName", "Kapoor",
                    "email", "raj.kapoor@example.com",
                    "department", "Finance",
                    "role", "Accountant")));

            employeeList.add(new HashMap<>(Map.of(
                    "id", "4",
                    "firstName", "Priya",
                    "lastName", "Verma",
                    "email", "priya.verma@example.com",
                    "department", "Marketing",
                    "role", "Content Strategist")));

            employeeList.add(new HashMap<>(Map.of(
                    "id", "5",
                    "firstName", "Vikram",
                    "lastName", "Singh",
                    "email", "vikram.singh@example.com",
                    "department", "Sales",
                    "role", "Sales Manager")));
        }

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            String uri = req.getRequestURI();
            String action = req.getParameter("action");
            String id = req.getParameter("id");

            Map<String, Object> dataModel = new HashMap<>();
            dataModel.put("mockEmployeeList", employeeList);

            try {
                Template template;

                if ("/form".equals(uri)) {
                    // Edit form
                    if ("edit".equals(action) && id != null) {
                        for (Map<String, String> emp : employeeList) {
                            if (emp.get("id").equals(id)) {
                                dataModel.put("editEmployee", emp);
                                break;
                            }
                        }
                    }
                    template = cfg.getTemplate("form.ftlh");

                } else if ("delete".equals(action) && id != null) {
                    employeeList.removeIf(emp -> emp.get("id").equals(id));
                    resp.sendRedirect("/");
                    return;
                } else {
                    template = cfg.getTemplate("index.ftlh");
                }

                resp.setContentType("text/html");
                Writer out = resp.getWriter();
                template.process(dataModel, out);

            } catch (TemplateException e) {
                throw new ServletException("Template processing failed", e);
            }
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            req.setCharacterEncoding("UTF-8");

            String id = req.getParameter("id");
            String firstName = req.getParameter("firstName");
            String lastName = req.getParameter("lastName");
            String email = req.getParameter("email");
            String department = req.getParameter("department");
            String role = req.getParameter("role");

            if (id != null && !id.isEmpty()) {
                // Edit existing
                for (int i = 0; i < employeeList.size(); i++) {
                    Map<String, String> emp = employeeList.get(i);
                    if (emp.get("id").equals(id)) {
                        Map<String, String> updated = new HashMap<>();
                        updated.put("id", id);
                        updated.put("firstName", firstName);
                        updated.put("lastName", lastName);
                        updated.put("email", email);
                        updated.put("department", department);
                        updated.put("role", role);
                        employeeList.set(i, updated);
                        break;
                    }
                }
            } else {
                // Add new
                String newId = UUID.randomUUID().toString();
                Map<String, String> newEmp = new HashMap<>();
                newEmp.put("id", newId);
                newEmp.put("firstName", firstName);
                newEmp.put("lastName", lastName);
                newEmp.put("email", email);
                newEmp.put("department", department);
                newEmp.put("role", role);
                employeeList.add(newEmp);
            }

            resp.sendRedirect("/");
        }
    }
}

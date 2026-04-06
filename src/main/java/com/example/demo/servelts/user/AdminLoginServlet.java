package com.example.demo.servelts.user;


import com.example.demo.utils.FileHandler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "AdminLoginServlet", value = "/admin-login")
public class AdminLoginServlet extends HttpServlet {

    private static final String USERS_FILE = "users.txt"; // Format: firstName,lastName,email,password,role

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String[] records = FileHandler.readFromFile(USERS_FILE);

        for (String record : records) {
            String[] parts = record.split(",");

            if (parts.length == 5) {
                String firstName = parts[0];
                String lastName = parts[1];
                String storedEmail = parts[2];
                String storedPassword = parts[3];
                String role = parts[4];

                if (storedEmail.equals(email) && storedPassword.equals(password) && role.equals("admin")) {
                    HttpSession session = request.getSession();
                    session.setAttribute("email", storedEmail);
                    session.setAttribute("firstName", firstName);
                    session.setAttribute("lastName", lastName);
                    session.setAttribute("role", role);

                    response.sendRedirect("admin-dashboard");
                    return;
                }
            }
        }

        // Invalid credentials or not an admin
        response.sendRedirect("pages/admin/adminlogin.jsp?error=Invalid email or password");
    }
}

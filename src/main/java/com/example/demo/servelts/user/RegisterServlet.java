package com.example.demo.servelts.user;

import com.example.demo.models.User;
import com.example.demo.models.Seller;  // Import Seller class
import com.example.demo.service.UserManager;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Check if user or seller already exists
        UserManager userManager = new UserManager(role);

        if (userManager.findUserByEmail(email) != null) {
            response.sendRedirect("pages/common/register.jsp?error=Email already exists");
            return;
        }

        // Create and add the new user or seller
        User newUser;
        if ("seller".equals(role)) {
            // Create Seller object for seller role
            newUser = new Seller(firstName, lastName, email, password);
        } else {
            // Create regular User object for user role
            newUser = new User(firstName, lastName, email, password, role);
        }

        // Add the user to the system
        userManager.addUser(newUser);

        // Redirect to login page after successful registration
        response.sendRedirect("pages/common/login.jsp");
    }
}

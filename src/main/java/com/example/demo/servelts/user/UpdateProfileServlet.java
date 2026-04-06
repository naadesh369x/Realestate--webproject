package com.example.demo.servelts.user;

import com.example.demo.models.User;
import com.example.demo.service.UserManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/updateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form fields
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String newPassword = request.getParameter("newPassword");

        // Get session and role
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        // Validate fields
        if (email == null || firstName == null || lastName == null || newPassword == null ||
                email.isEmpty() || firstName.isEmpty() || lastName.isEmpty() || newPassword.isEmpty() || role == null) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("updateprofile.jsp").forward(request, response);
            return;
        }

        // Load user manager for current role
        UserManager userManager = new UserManager(role);
        User existingUser = userManager.findUserByEmail(email);

        if (existingUser != null) {
            // Perform update
            boolean updated = userManager.updateUser(email, firstName, lastName, newPassword);

            if (updated) {
                // Update session with new info
                session.setAttribute("firstName", firstName);
                session.setAttribute("lastName", lastName);

                // Redirect to correct dashboard
                if ("seller".equalsIgnoreCase(role)) {
                    response.sendRedirect("seller-dashboard");
                } else {
                    response.sendRedirect("user-dashboard");
                }
            } else {
                request.setAttribute("error", "Failed to update profile.");
                request.getRequestDispatcher("updateprofile.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "User not found.");
            request.getRequestDispatcher("updateprofile.jsp").forward(request, response);
        }
    }
}

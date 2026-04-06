package com.example.demo.servlets;

import com.example.demo.models.User;
import com.example.demo.models.Property;

import com.example.demo.service.UserManager;
import com.example.demo.service.PropertyManager;
import com.example.demo.service.InquiryManager;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if the user is an admin
        String role = (String) request.getSession().getAttribute("role");
        if (role == null || !role.equals("admin")) {
            response.sendRedirect("pages/common/login.jsp");
            return;
        }

        // Load all users
        UserManager userManager = new UserManager("admin");
        List<User> users = userManager.getAllUsers();
        int totalUsers = users.size();

        // Load all properties
        PropertyManager propertyManager = new PropertyManager();
        List<Property> properties = propertyManager.getProperties();
        int totalProperties = properties.size();

        // Load all pending inquiries

        // Set attributes
        request.setAttribute("users", users);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalProperties", totalProperties);


        // Forward to JSP
        request.getRequestDispatcher("pages/admin/admindashboard.jsp").forward(request, response);
    }
}

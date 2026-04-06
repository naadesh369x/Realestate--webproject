package com.example.demo.servelts.property;

import com.example.demo.models.Property;
import com.example.demo.service.PropertyManager;
import com.example.demo.bst.PropertyTree;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UserDashboardServlet", value = "/user-dashboard")
public class UserDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Load properties from file
        PropertyManager.readProperties();

        // Get list of properties
        List<Property> properties = PropertyManager.getProperties();
        System.out.println("Loaded properties: " + properties.size());

        // Initialize or reuse PropertyTree
        PropertyTree propertyTree = (PropertyTree) getServletContext().getAttribute("propertyTree");
        if (propertyTree == null) {
            propertyTree = new PropertyTree();
            for (Property property : properties) {
                propertyTree.insert(property);
            }
            getServletContext().setAttribute("propertyTree", propertyTree);
        }

        // Retrieve sorted properties
        ArrayList<Property> sortedProperties = propertyTree.getAllProperties();

        // Forward to JSP
        request.setAttribute("properties", sortedProperties);
        request.getRequestDispatcher("pages/user/userdashboard.jsp").forward(request, response);
    }
}

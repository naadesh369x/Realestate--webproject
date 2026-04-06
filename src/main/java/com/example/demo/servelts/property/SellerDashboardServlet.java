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

@WebServlet(name = "SellerDashboardServlet", value = "/seller-dashboard")
public class SellerDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //  Get logged-in seller's email from session
        HttpSession session = request.getSession();
        String sellerEmail = (String) session.getAttribute("email");

        if (sellerEmail == null || sellerEmail.isEmpty()) {
            response.sendRedirect("pages/common/login.jsp");
            return;
        }

        // Load all properties from file
        PropertyManager.readProperties();

        //  Filter by seller email
        List<Property> sellerProperties = PropertyManager.getPropertiesBySeller(sellerEmail);

        //  Optional: Use BST to sort seller's properties
        PropertyTree propertyTree = new PropertyTree();
        for (Property property : sellerProperties) {
            propertyTree.insert(property);
        }

        ArrayList<Property> sortedSellerProperties = propertyTree.getAllProperties();

        // Send seller's sorted properties to JSP
        request.setAttribute("properties", sortedSellerProperties);
        request.getRequestDispatcher("pages/seller/sellerdashboard.jsp").forward(request, response);
    }
}

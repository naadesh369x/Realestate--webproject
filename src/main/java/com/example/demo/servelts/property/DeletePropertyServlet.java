package com.example.demo.servelts.property;

import com.example.demo.service.PropertyManager;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "deletePropertyServlet", value = "/delete-property")
public class DeletePropertyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String propertyId = request.getParameter("id");

        if (propertyId == null || propertyId.isEmpty()) {
            response.sendRedirect("pages/seller/sellerdashboard.jsp?error=Invalid+Property+ID");
            return;
        }

        PropertyManager.removeProperty(propertyId);

        response.sendRedirect("seller-dashboard?message=Property+Deleted+Successfully");
    }

    // Optional: Handle GET if needed
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET not supported");
    }
}

package com.example.demo.servelts.property;
import com.example.demo.models.Property;
import com.example.demo.service.PropertyManager;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.*;
import java.nio.file.*;

@WebServlet("/update-property")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1,    // 1MB
        maxFileSize = 1024 * 1024 * 5,      // 5MB
        maxRequestSize = 1024 * 1024 * 10)  // 10MB
public class UpdatePropertyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String propertyId = request.getParameter("id");
        String title = request.getParameter("title");
        String location = request.getParameter("location");
        String type = request.getParameter("type");
        String description = request.getParameter("description");
        String phoneNumber = request.getParameter("phoneNumber");

        String priceStr = request.getParameter("price");
        String radiusStr = request.getParameter("radius");

        double price = 0.00;
        double radius = 0.0;

        try {
            if (priceStr != null && !priceStr.trim().isEmpty()) {
                price = Double.parseDouble(priceStr.trim());
            }
            if (radiusStr != null && !radiusStr.trim().isEmpty()) {
                radius = Double.parseDouble(radiusStr.trim());
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
            return;
        }

        // Handle optional image
        Part imagePart = request.getPart("image");
        String imageFileName = null;

        if (imagePart != null && imagePart.getSize() > 0) {
            String uploadDir = getServletContext().getRealPath("/images");
            imageFileName = saveFile(imagePart, uploadDir);
        }

        // Get existing property to retain fields
        Property existing = PropertyManager.findPropertyById(propertyId);
        if (existing == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        if (imageFileName == null) {
            imageFileName = existing.getImageFileName();
        }

        Property updatedProperty = new Property(
                propertyId, title, location, type, price, radius,
                description, imageFileName,
                existing.getBookedBy(), existing.getSellerEmail(), phoneNumber
        );

        boolean isUpdated = PropertyManager.updateProperty(updatedProperty);

        if (isUpdated) {
            response.sendRedirect("seller-dashboard");
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    private String saveFile(Part part, String uploadDir) throws IOException {
        String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        File file = new File(uploadDir, fileName);
        try (InputStream input = part.getInputStream()) {
            Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        return fileName;
    }
}

package com.example.demo.servelts.property;

import com.example.demo.models.Media;
import com.example.demo.models.Property;
import com.example.demo.service.MediaService;
import com.example.demo.service.PropertyManager;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@WebServlet("/add-property")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50)
public class AddPropertyServlet extends HttpServlet {

    private final MediaService mediaService = new MediaService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Form fields
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String location = request.getParameter("location");
        String type = request.getParameter("type");
        String priceStr = request.getParameter("price");
        String radiusStr = request.getParameter("radius");
        String description = request.getParameter("description");
        String sellerPhone = request.getParameter("sellerPhone");

        double price = 0.0;
        double radius = 0.0;
        try {
            price = Double.parseDouble(priceStr);
            radius = Double.parseDouble(radiusStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // Seller email from session
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("email");

        // Define upload directories
        // Priority 1: Persistent Project Folder (Source)
        String projectBase = "d:\\java web apps\\estate\\src\\main\\webapp\\images";
        String mainImageUploadDir = projectBase;
        String mediaUploadDir = projectBase + "1";
        
        File mainImageFolder = new File(mainImageUploadDir);
        File mediaFolder = new File(mediaUploadDir);
        
        if (!mainImageFolder.exists()) mainImageFolder.mkdirs();
        if (!mediaFolder.exists()) mediaFolder.mkdirs();

        // Upload and save main image
        Part mainImagePart = request.getPart("image");
        String mainImageFileName = null;
        if (mainImagePart != null && mainImagePart.getSize() > 0) {
            String submittedName = Paths.get(mainImagePart.getSubmittedFileName()).getFileName().toString();
            mainImageFileName = System.currentTimeMillis() + "_" + submittedName;
            File mainImageFile = new File(mainImageFolder, mainImageFileName);
            mainImagePart.write(mainImageFile.getAbsolutePath());
        }

        // Build Property object
        Property property = new Property(id, title, location, type, price, radius, description, mainImageFileName, null, userEmail, sellerPhone);

        PropertyManager.addProperty(property);

        // Handle multiple additional media uploads
        Collection<Part> parts = request.getParts();
        List<File> additionalMediaFiles = new ArrayList<>();
        for (Part part : parts) {
            if ("mediaImages".equals(part.getName()) && part.getSize() > 0) {
                String submittedName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String uniqueFileName = System.currentTimeMillis() + "_" + submittedName;
                File mediaFile = new File(mediaFolder, uniqueFileName);
                part.write(mediaFile.getAbsolutePath());
                additionalMediaFiles.add(mediaFile);
            }
        }

        // Save additional media (if any)
        if (!additionalMediaFiles.isEmpty()) {
            int propertyId = Integer.parseInt(id);
            mediaService.addMultipleMedia(propertyId, "image", additionalMediaFiles, mediaUploadDir);
        }

        // Redirect
        response.sendRedirect("seller-dashboard");
    }
}

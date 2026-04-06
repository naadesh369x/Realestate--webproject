package com.example.demo.servelts;

import com.example.demo.models.Media;
import com.example.demo.service.MediaService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.UUID;

@WebServlet("/upload-media")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1,    // 1MB
        maxFileSize = 1024 * 1024 * 10,                  // 10MB
        maxRequestSize = 1024 * 1024 * 50)               // 50MB
public class FileUploadServlet extends HttpServlet {

    private final MediaService mediaService = new MediaService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String propertyIdStr = request.getParameter("propertyId");

        if (propertyIdStr == null || propertyIdStr.isEmpty()) {
            response.getWriter().println("Missing property ID.");
            return;
        }

        int propertyId;
        try {
            propertyId = Integer.parseInt(propertyIdStr);
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid property ID.");
            return;
        }

        // ✅ Directory to store media: /images1/
        String uploadDir = getServletContext().getRealPath("/images1/");
        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        Collection<Part> parts = request.getParts();
        boolean anyUploaded = false;

        for (Part part : parts) {
            if ("mediaFiles".equals(part.getName()) && part.getSize() > 0) {
                String originalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String uniqueFileName = UUID.randomUUID() + "_" + originalFileName;
                File mediaFile = new File(uploadFolder, uniqueFileName);

                // Save file to /images1/
                part.write(mediaFile.getAbsolutePath());

                // Determine media type
                String contentType = part.getContentType();
                String mediaType = (contentType != null && contentType.startsWith("video")) ? "video" : "image";

                // Store relative path (for later use in JSP)
                String relativePath = "images1/" + uniqueFileName;

                // Save media object
                Media media = new Media(UUID.randomUUID().hashCode(), propertyId, relativePath, mediaType);
                mediaService.addMedia(media, mediaFile);

                anyUploaded = true;
            }
        }

        if (anyUploaded) {
            response.sendRedirect("property-details.jsp?id=" + propertyId);
        } else {
            response.getWriter().println("No valid media files uploaded.");
        }
    }
}

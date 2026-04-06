package com.example.demo.servelts.property;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/remove-favorite-property")
public class RemoveFavoritePropertyServlet extends HttpServlet {

    private static final String FAVORITES_FILE_NAME = "favorites.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the user's email from the session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String userEmail = ((String) session.getAttribute("email")).trim();

        // Retrieve the property ID from the request
        String propertyId = request.getParameter("propertyId");
        if (propertyId == null || propertyId.trim().isEmpty()) {
            response.sendRedirect("favorites.jsp");
            return;
        }
        propertyId = propertyId.trim();

        // Path to favorites.txt file
        String filePath = getServletContext().getRealPath("/") + FAVORITES_FILE_NAME;
        File file = new File(filePath);

        // Remove matching userEmail,propertyId line
        List<String> updatedLines = new ArrayList<>();
        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String trimmedLine = line.trim();
                    // Only keep lines that don't match the user's favorite being removed
                    if (!trimmedLine.equals(userEmail + "," + propertyId)) {
                        updatedLines.add(line);
                    }
                }
            }

            // Write the updated lines back to the file
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, false))) {
                for (String line : updatedLines) {
                    writer.write(line);
                    writer.newLine();
                }
            }
        }

        // Redirect back to favorites page
        response.sendRedirect("favorites.jsp");
    }
}

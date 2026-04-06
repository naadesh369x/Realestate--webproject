package com.example.demo.servelts.property;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet("/favorite-property")
public class FavoriteServlet extends HttpServlet {

    private static final String FAV_FILE = "favorites.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userEmail = (String) request.getSession().getAttribute("email");
        String propertyId = request.getParameter("propertyId");

        if (userEmail != null && propertyId != null && !propertyId.isEmpty()) {
            File file = new File(FAV_FILE);
            boolean alreadyFavorited = false;

            // Read existing favorites to check for duplicates
            if (file.exists()) {
                try (BufferedReader br = new BufferedReader(new FileReader(file))) {
                    String line;
                    while ((line = br.readLine()) != null) {
                        if (line.trim().equals(userEmail + "," + propertyId)) {
                            alreadyFavorited = true;
                            break;
                        }
                    }
                }
            }

            // Only write if not already favorited
            if (!alreadyFavorited) {
                try (BufferedWriter bw = new BufferedWriter(new FileWriter(file, true))) {
                    bw.write(userEmail + "," + propertyId);
                    bw.newLine();
                }
            }
        }

        response.sendRedirect("user-dashboard");
    }
}

package com.example.demo.servelts.booking;

import com.example.demo.service.PropertyManager;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.*;
import java.util.*;

@WebServlet(name = "ConfirmBookingServlet", value = "/confirm-booking")
public class ConfirmBookingServlet extends HttpServlet {

    private static final String BOOKINGS_FILE_PATH =
            System.getProperty("catalina.home") + File.separator + "bin" + File.separator + "bookings.txt";
    private static final String CONFIRMED_BOOKINGS_FILE_PATH =
            System.getProperty("catalina.home") + File.separator + "bin" + File.separator + "confirmed_bookings.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String propertyId = request.getParameter("propertyId");
        String userEmail = request.getParameter("userEmail");

        // 1. Remove property using your PropertyManager
        PropertyManager.removeProperty(propertyId);

        // 2. Remove the booking line from bookings.txt and move to confirmed_bookings.txt
        File file = new File(BOOKINGS_FILE_PATH);
        String confirmedLine = null;
        if (file.exists()) {
            List<String> updatedLines = new ArrayList<>();
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length >= 3) {
                        String pid = parts[1].trim();
                        String email = parts[2].trim();
                        if (pid.equals(propertyId) && email.equalsIgnoreCase(userEmail)) {
                            confirmedLine = line; // Found the one to move
                        } else {
                            updatedLines.add(line);
                        }
                    }
                }
            }

            // Write back filtered lines
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, false))) {
                for (String updatedLine : updatedLines) {
                    writer.write(updatedLine);
                    writer.newLine();
                }
            }
        }

        // 3. Save to confirmed_bookings.txt
        if (confirmedLine != null) {
            String loggedInSeller = (String) request.getSession().getAttribute("email");
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(CONFIRMED_BOOKINGS_FILE_PATH, true))) {
                writer.write(confirmedLine + "," + loggedInSeller + "," + System.currentTimeMillis()); // Append seller and timestamp
                writer.newLine();
            }
        }

        request.setAttribute("message", "Booking confirmed and property removed.");
        request.getRequestDispatcher("pages/seller/seller-bookings.jsp").forward(request, response);
    }
}

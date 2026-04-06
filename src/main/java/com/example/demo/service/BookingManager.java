package com.example.demo.service;

import com.example.demo.models.Booking;
import com.example.demo.utils.FileHandler;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class BookingManager {

    private static final String BOOKING_FILE = "bookings.txt";

    // Save a new booking
    public void addBooking(Booking booking) {
        String filePath = getBookingFilePath();
        System.out.println("Booking file path: " + filePath);

        File file = new File(filePath);
        try {
            // Create file if it doesn't exist
            if (!file.exists()) {
                boolean created = file.createNewFile();
                System.out.println("Booking file created: " + created);
            }

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
                String line = String.join(",",
                        booking.getBookingId(),
                        booking.getPropertyId(),
                        booking.getUserEmail(),
                        booking.getFirstName(),
                        booking.getLastName(),
                        booking.getPhoneNumber(),
                        booking.getBookingDateTime()
                );
                writer.write(line);
                writer.newLine();
                System.out.println("Booking saved: " + line);
            }
        } catch (IOException e) {
            System.err.println("Error saving booking:");
            e.printStackTrace();
        }
    }

    // Load all bookings
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        File file = new File(getBookingFilePath());

        if (!file.exists()) {
            System.out.println("Booking file does not exist yet.");
            return bookings;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 7) {
                    Booking booking = new Booking();
                    booking.setBookingId(parts[0].trim());
                    booking.setPropertyId(parts[1].trim());
                    booking.setUserEmail(parts[2].trim());
                    booking.setFirstName(parts[3].trim());
                    booking.setLastName(parts[4].trim());
                    booking.setPhoneNumber(parts[5].trim());
                    booking.setBookingDateTime(parts[6].trim());

                    bookings.add(booking);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading bookings:");
            e.printStackTrace();
        }

        return bookings;
    }

    // Remove a booking by propertyId and userEmail
    public void removeBooking(String propertyId, String userEmail) {
        List<Booking> bookings = getAllBookings();
        List<Booking> updated = new ArrayList<>();

        for (Booking b : bookings) {
            if (!(b.getPropertyId().equals(propertyId) && b.getUserEmail().equalsIgnoreCase(userEmail))) {
                updated.add(b);
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(getBookingFilePath()))) {
            for (Booking b : updated) {
                String line = String.join(",",
                        b.getBookingId(),
                        b.getPropertyId(),
                        b.getUserEmail(),
                        b.getFirstName(),
                        b.getLastName(),
                        b.getPhoneNumber(),
                        b.getBookingDateTime()
                );
                writer.write(line);
                writer.newLine();
            }
            System.out.println("Updated bookings saved after removal.");
        } catch (IOException e) {
            System.err.println("Error saving bookings after removal:");
            e.printStackTrace();
        }
    }

    // Check if a property is already booked by a specific user
    public boolean isPropertyBookedByUser(String propertyId, String userEmail) {
        if (propertyId == null || userEmail == null) return false;
        List<Booking> bookings = getAllBookings();
        for (Booking b : bookings) {
            String bPid = (b.getPropertyId() != null) ? b.getPropertyId().trim() : "";
            String bEmail = (b.getUserEmail() != null) ? b.getUserEmail().trim() : "";
            if (bPid.equals(propertyId.trim()) && bEmail.equalsIgnoreCase(userEmail.trim())) {
                return true;
            }
        }
        return false;
    }

    // Get full path to bookings.txt
    // Get full path to bookings.txt in Tomcat bin directory
    private String getBookingFilePath() {
        return System.getProperty("catalina.home") + File.separator + "bin" + File.separator + BOOKING_FILE;
    }



}


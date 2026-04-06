package com.example.demo.service;

import java.io.*;
import java.nio.file.*;
import java.util.*;

public class InquiryManager {

    private static final String INQUIRIES_FILE = "inquiries.txt";
    private static final String REPLIES_FILE = "replies.txt";

    // Save a new inquiry
    public static void saveInquiry(String propertyId, String userName, String userEmail, String message) throws IOException {
        StringBuilder record = new StringBuilder();
        record.append("Property ID: ").append(propertyId).append(System.lineSeparator());
        record.append("User Name: ").append(userName).append(System.lineSeparator());
        record.append("Email: ").append(userEmail).append(System.lineSeparator());
        record.append("Message: ").append(message).append(System.lineSeparator());
        record.append("----").append(System.lineSeparator());

        Files.write(Paths.get(INQUIRIES_FILE), record.toString().getBytes(), StandardOpenOption.CREATE, StandardOpenOption.APPEND);
    }

    // Get all inquiries
    public static List<Map<String, String>> getAllInquiries() throws IOException {
        List<Map<String, String>> inquiries = new ArrayList<>();
        List<String> lines = Files.readAllLines(Paths.get(INQUIRIES_FILE));
        Map<String, String> current = new HashMap<>();

        for (String line : lines) {
            if (line.equals("----")) {
                if (!current.isEmpty()) {
                    inquiries.add(new HashMap<>(current));
                    current.clear();
                }
            } else if (line.contains(":")) {
                String[] parts = line.split(":", 2);
                if (parts.length == 2) {
                    current.put(parts[0].trim(), parts[1].trim());
                }
            }
        }
        return inquiries;
    }

    // Save a reply based on propertyId
    public static boolean saveReplyToInquiry(String propertyId, String reply) throws IOException {
        List<String> inquiryDetails = new ArrayList<>();
        boolean found = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(INQUIRIES_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.startsWith("Property ID:")) {
                    if (line.substring(12).trim().equals(propertyId)) {
                        found = true;
                        inquiryDetails.clear();
                        inquiryDetails.add(line); // Property ID
                        for (int i = 0; i < 3; i++) {
                            inquiryDetails.add(reader.readLine());
                        }
                    }
                }
            }
        }

        if (found && !inquiryDetails.isEmpty()) {
            try (FileWriter writer = new FileWriter(REPLIES_FILE, true);
                 PrintWriter out = new PrintWriter(writer)) {

                for (String detail : inquiryDetails) {
                    out.println(detail);
                }
                out.println("Reply: " + reply);
                out.println("----");
            }
            return true;
        }
        return false;
    }
}

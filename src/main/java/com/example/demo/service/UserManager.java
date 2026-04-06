package com.example.demo.service;

import com.example.demo.models.User;
import com.example.demo.models.Seller;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserManager {
    private static final String FILE_PATH = "users.txt";
    private String role;
    private String filePath;

    public UserManager(String role) {
        this.role = role;
        this.filePath = getFilePathByRole(role);
    }

    // CREATE - Adds a new user or seller
    public boolean addUser(User user) {
        String data = user.getFirstName() + "," + user.getLastName() + ","
                + user.getEmail() + "," + user.getPassword() + "," + user.getRole() + "\n";
        return writeToFile(filePath, true, data);
    }

    // READ - Get all users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String[] lines = readFromFile(filePath);
        for (String line : lines) {
            String[] parts = line.split(",");
            if (parts.length >= 5) {
                String firstName = parts[0];
                String lastName = parts[1];
                String email = parts[2];
                String password = parts[3];
                String role = parts[4];

                if ("seller".equalsIgnoreCase(role)) {
                    users.add(new Seller(firstName, lastName, email, password));
                } else {
                    users.add(new User(firstName, lastName, email, password, role));
                }
            }
        }
        return users;
    }

    // FIND by email
    public User findUserByEmail(String email) {
        for (User user : getAllUsers()) {
            if (user.getEmail().equalsIgnoreCase(email)) {
                return user;
            }
        }
        return null;
    }

    // CHECK if email exists
    public boolean emailExists(String email) {
        return findUserByEmail(email) != null;
    }

    // UPDATE user details
    public boolean updateUser(String email, String newFirstName, String newLastName, String newPassword) {
        File file = new File(filePath);
        if (!file.exists()) return false;

        List<String> updatedLines = new ArrayList<>();
        boolean updated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 5 && parts[2].equalsIgnoreCase(email) && parts[4].equalsIgnoreCase(role)) {
                    String newLine = newFirstName + "," + newLastName + "," + email + "," + newPassword + "," + role;
                    updatedLines.add(newLine);
                    updated = true;
                } else {
                    updatedLines.add(line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        if (!updated) return false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (String updatedLine : updatedLines) {
                writer.write(updatedLine);
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // DELETE user
    public boolean deleteUserByEmail(String email) {
        File file = new File(filePath);
        if (!file.exists()) return false;

        List<String> updatedLines = new ArrayList<>();
        boolean deleted = false;

        String[] lines = readFromFile(filePath);
        for (String line : lines) {
            String[] parts = line.split(",");
            if (parts.length >= 1) {
                String fileEmail = parts[2].trim();
                if (fileEmail.equalsIgnoreCase(email.trim())) {
                    deleted = true;
                    continue;
                }
            }
            updatedLines.add(line);
        }

        if (!deleted) return false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String updatedLine : updatedLines) {
                writer.write(updatedLine);
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Static finder with role
    public static User findUserByEmail(String email, String role) {
        UserManager userManager = new UserManager(role);
        return userManager.findUserByEmail(email);
    }

    // Internal utility methods (previously in FileHandler)
    private boolean writeToFile(String fileName, boolean append, String data) {
        File file = new File(fileName);
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                System.out.println("Error creating file: " + fileName);
                return false;
            }
        }

        try (FileWriter writer = new FileWriter(fileName, append)) {
            writer.write(data);
            return true;
        } catch (IOException e) {
            System.out.println("Write error: " + e.getMessage());
            return false;
        }
    }

    private String[] readFromFile(String fileName) {
        File file = new File(fileName);
        if (!file.exists()) return new String[0];

        StringBuilder data = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                data.append(line).append("\n");
            }
        } catch (IOException e) {
            System.out.println("Read error: " + e.getMessage());
        }

        return data.toString().isEmpty() ? new String[0] : data.toString().split("\n");
    }

    private String getFilePathByRole(String role) {

        return FILE_PATH; // Simplified for unified user file
    }
}

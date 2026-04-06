package com.example.demo.servelts.user;



import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/deleteProfile")
public class DeleteProfileServlet extends HttpServlet {
    private static final String USER_FILE_PATH = "D:/Tomcat 10.1/bin/users.txt"; // Update to your path

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("jsp/login.jsp");
            return;
        }

        String userEmail = (String) session.getAttribute("email");
        String userPassword = (String) session.getAttribute("password");

        File file = new File(USER_FILE_PATH);
        List<String> lines = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            // Read all lines and exclude the one that matches the current user
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 2 && !(parts[0].equals(userEmail) && parts[1].equals(userPassword))) {
                    lines.add(line);
                }
            }
        }

        // Write back the filtered lines (excluding the deleted user)
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, false))) {
            for (String l : lines) {
                writer.write(l);
                writer.newLine();
            }
        }

        // Invalidate session and redirect
        session.invalidate();
        response.sendRedirect("login.jsp");
    }
}

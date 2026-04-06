package com.example.demo.servelts.user;

import com.example.demo.utils.FileHandler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "DeleteUserServlet", value = "/delete-user")
public class DeleteUserServlet extends HttpServlet {
    private static final String USERS_FILE = "users.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");

        // Read all lines from users.txt
        String[] lines = FileHandler.readFromFile(USERS_FILE);
        StringBuilder updatedContent = new StringBuilder();

        boolean found = false;

        for (String line : lines) {
            if (!line.startsWith(email + ",")) {
                updatedContent.append(line).append("\n");
            } else {
                found = true;
            }
        }

        if (found) {
            // Overwrite the users.txt with updated content
            FileHandler.writeToFile(USERS_FILE, false, updatedContent.toString());
        }

        // Redirect back to admin dashboard
        response.sendRedirect("admin-dashboard");
    }
}

package com.example.demo.servelts.inquiry;

import com.example.demo.service.InquiryManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/inquiry")
public class InquiryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters from the form
        String propertyId = request.getParameter("propertyId");
        String userEmail = request.getParameter("userEmail");
        String userName = request.getParameter("userName");
        String message = request.getParameter("message");

        try {
            // Save inquiry using InquiryManager
            InquiryManager.saveInquiry(propertyId, userName, userEmail, message);

            // Confirmation message
            HttpSession session = request.getSession();
            session.setAttribute("inquiryMessage", "Inquiry submitted successfully!");

            // Redirect to user dashboard or confirmation page
            response.sendRedirect("user-dashboard");
        } catch (IOException e) {
            throw new ServletException("Error saving inquiry", e);
        }
    }
}

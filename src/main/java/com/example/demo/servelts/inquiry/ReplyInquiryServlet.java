package com.example.demo.servelts.inquiry;

import com.example.demo.service.InquiryManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/ReplyInquiryServlet")
public class ReplyInquiryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String propertyId = request.getParameter("propertyId");
        String reply = request.getParameter("reply");

        boolean success = InquiryManager.saveReplyToInquiry(propertyId, reply);

        if (success) {
            response.sendRedirect("pages/seller/viewinquiries.jsp?message=Reply+saved+successfully");
        } else {
            response.sendRedirect("pages/seller/viewinquiries.jsp?message=Inquiry+not+found");
        }
    }
}

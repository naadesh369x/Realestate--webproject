package com.example.demo.servelts.booking;

import com.example.demo.service.BookingManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/cancelBooking")
public class BookingCancelServlet extends HttpServlet {

    private final BookingManager bookingManager = new BookingManager();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String propertyId = request.getParameter("propertyId");
        HttpSession session = request.getSession(false);
        String userEmail = (session != null) ? (String) session.getAttribute("email") : null;

        if (propertyId == null || userEmail == null) {
            response.sendRedirect("login.jsp?error=Please+login+again");
            return;
        }

        bookingManager.removeBooking(propertyId, userEmail);

        // Redirect to updated bookings page
        response.sendRedirect("viewBookings.jsp?msg=Booking+cancelled+successfully");
    }
}
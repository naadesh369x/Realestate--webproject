package com.example.demo.servelts.booking;

import com.example.demo.models.Booking;
import com.example.demo.models.Property;
import com.example.demo.service.BookingManager;
import com.example.demo.service.PropertyManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@WebServlet(name = "addBookingServlet", value = "/add-booking")
public class AddBookingServlet extends HttpServlet {

    private final BookingManager bookingManager = new BookingManager();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String propertyId = request.getParameter("propertyId");
        String userEmail = request.getParameter("userEmail");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNumber = request.getParameter("phoneNumber");

        // Validate input
        if (propertyId == null || userEmail == null ||
                firstName == null || lastName == null || phoneNumber == null ||
                propertyId.isEmpty() || userEmail.isEmpty() ||
                firstName.isEmpty() || lastName.isEmpty() || phoneNumber.isEmpty()) {

            response.sendRedirect("userdashboard.jsp?error=Missing+booking+information");
            return;
        }

        String bookingId = UUID.randomUUID().toString();
        String bookingDateTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        Booking booking = new Booking();
        booking.setBookingId(bookingId);
        booking.setUserEmail(userEmail);
        booking.setPropertyId(propertyId);
        booking.setFirstName(firstName);
        booking.setLastName(lastName);
        booking.setPhoneNumber(phoneNumber);
        booking.setBookingDateTime(bookingDateTime);

        bookingManager.addBooking(booking);

        // Update property booked status
        Property property = PropertyManager.findPropertyById(propertyId);
        if (property != null) {
            property.setBookedBy(userEmail);
            PropertyManager.updateProperty(property);
        }

        response.sendRedirect("pages/user/user-property-details.jsp?id=" + propertyId + "&bookingStatus=SUCCESS");
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET not supported");
    }
}

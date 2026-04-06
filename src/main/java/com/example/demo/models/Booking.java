package com.example.demo.models;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


public class Booking {
    private String bookingId;
    private String propertyId;
    private String userEmail;
    private String firstName;
    private String lastName;
    private String phoneNumber;
    private String bookingDateTime;

    // Default constructor (generates bookingId and timestamp)
    public Booking() {

        this.bookingDateTime = getCurrentDateTime();
    }

    // Parameterized constructor
    public Booking(String bookingId, String propertyId, String userEmail,
                   String firstName, String lastName, String phoneNumber) {
        this.bookingId = bookingId;
        this.propertyId = propertyId;
        this.userEmail = userEmail;
        this.firstName = firstName;
        this.lastName = lastName;
        this.phoneNumber = phoneNumber;
        this.bookingDateTime = getCurrentDateTime();
    }

    // Generate current date and time string
    private String getCurrentDateTime() {
        LocalDateTime now = LocalDateTime.now();
        return now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    // Getters and setters
    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(String propertyId) {
        this.propertyId = propertyId;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getBookingDateTime() {
        return bookingDateTime;
    }

    public void setBookingDateTime(String bookingDateTime) {
        this.bookingDateTime = bookingDateTime;
    }
}

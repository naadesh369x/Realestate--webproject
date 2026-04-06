package com.example.demo.models;

public class Comment {
    private String userEmail;
    private String propertyId;
    private String text;
    private int rating; // New field

    public Comment() {}

    public Comment(String userEmail, String propertyId, String text, int rating) {
        this.userEmail = userEmail;
        this.propertyId = propertyId;
        this.text = text;
        this.rating = rating;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(String propertyId) {
        this.propertyId = propertyId;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }
}

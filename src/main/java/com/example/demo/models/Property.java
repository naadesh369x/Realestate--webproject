package com.example.demo.models;

public class Property {
    private String id;
    private String title;
    private String location;
    private String type;
    private double price;
    private double radius;
    private String description;
    private String imageFileName;
    private String bookedBy;
    private String sellerEmail;
    private String sellerPhone;

    //Default constructor
    public Property(String id, String title, String location, double price, String type, String description, double radius, String imageFileName, String phoneNumber) {

        this.id = id;
        this.title = title;
        this.location = location;
        this.price = price;
        this.type = type;
        this.description = description;
        this.radius = radius;
        this.imageFileName = imageFileName;
        this.sellerPhone = phoneNumber;
        this.bookedBy = "";
        this.sellerEmail = "";
    }

    // constructor
    public Property(String id, String title, String location, String type, double price,
                    double radius, String description, String imageFileName,
                    String bookedBy, String sellerEmail, String sellerPhone) {
        this.id = id;
        this.title = title;
        this.location = location;
        this.type = type;
        this.price = price;
        this.radius = radius;
        this.description = description;
        this.imageFileName = imageFileName;
        this.bookedBy = bookedBy;
        this.sellerEmail = sellerEmail;
        this.sellerPhone = sellerPhone;
    }

    // Getters and Setters

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public double getRadius() {
        return radius;
    }
    public void setRadius(double radius) {
        this.radius = radius;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public String getImageFileName() {
        return imageFileName;
    }
    public void setImageFileName(String imageFileName) {
        this.imageFileName = imageFileName;
    }
    public String getBookedBy() {
        return bookedBy;
    }
    public void setBookedBy(String bookedBy) {
        this.bookedBy = bookedBy;
    }
    public String getSellerEmail() {
        return sellerEmail;
    }
    public void setSellerEmail(String sellerEmail) {
        this.sellerEmail = sellerEmail;
    }
    public String getSellerPhone() {
        return sellerPhone;
    }
    public void setSellerPhone(String sellerPhone) {
        this.sellerPhone = sellerPhone;
    }

    // Format for saving to file
    public String toFileString() {
        return String.join(";",
                id,
                title,
                location,
                type,
                String.valueOf(price),
                String.valueOf(radius),
                description,
                imageFileName != null ? imageFileName : "",
                bookedBy != null ? bookedBy : "",
                sellerEmail != null ? sellerEmail : "",
                sellerPhone != null ? sellerPhone : ""
        ) + "\n";
    }
}

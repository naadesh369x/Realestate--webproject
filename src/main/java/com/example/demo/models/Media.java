package com.example.demo.models;

public class Media implements Comparable<Media> {
    private int id;
    private int propertyId;
    private String url; // Example: "media/image1.jpg"
    private String type; // photo, video

    public Media(int id, int propertyId, String url, String type) {
        this.id = id;
        this.propertyId = propertyId;
        this.url = url;
        this.type = type;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPropertyId() { return propertyId; }
    public void setPropertyId(int propertyId) { this.propertyId = propertyId; }

    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }


    public String getFileName() {
        if (url != null && !url.isEmpty()) {
            return url.substring(url.lastIndexOf("/") + 1);
        }
        return "default.jpg"; // fallback if URL is missing
    }

    @Override
    public int compareTo(Media other) {
        return Integer.compare(this.id, other.id);
    }
}

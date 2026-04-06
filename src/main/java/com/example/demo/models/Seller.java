package com.example.demo.models;

public class Seller extends User {

    // Constructor to initialize Seller with first name, last name, email, password, and role "seller"
    public Seller(String firstName, String lastName, String email, String password) {
        super(firstName, lastName, email, password, "seller");
    }
}

package com.example.demo.bst;

import com.example.demo.models.Property;

import java.util.ArrayList;

public class PropertyTree {

    private Node root;

    //  represent each node in the BST
    private static class Node {
        Property property;
        Node left, right;

        public Node(Property property) {
            this.property = property;
            left = right = null;
        }
    }

    // Insert method for adding properties based on their IDs (UUID as String)
    public void insert(Property property) {
        root = insertRec(root, property);
    }

    // insert method
    private Node insertRec(Node root, Property property) {
        if (root == null) {
            root = new Node(property);
            return root;
        }

        // Compare the UUIDs as Strings (lexicographically)
        if (property.getId().compareTo(root.property.getId()) < 0) {
            root.left = insertRec(root.left, property);
        } else if (property.getId().compareTo(root.property.getId()) > 0) {
            root.right = insertRec(root.right, property);
        }

        return root;
    }

    // Method to get all properties in sorted order
    public ArrayList<Property> getAllProperties() {
        ArrayList<Property> properties = new ArrayList<>();
        inOrderRec(root, properties);
        return properties;
    }

    // In-order traversal to add properties to the list
    private void inOrderRec(Node root, ArrayList<Property> properties) {
        if (root != null) {
            inOrderRec(root.left, properties);
            properties.add(root.property);
            inOrderRec(root.right, properties);
        }
    }
}

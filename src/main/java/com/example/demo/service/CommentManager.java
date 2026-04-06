package com.example.demo.service;

import com.example.demo.models.Comment;

import java.io.*;
import java.nio.file.*;
import java.util.*;

public class CommentManager {

    private static final String COMMENTS_FILE = "comments.txt";


    public static void saveComment(Comment comment) throws IOException {
        StringBuilder record = new StringBuilder();
        record.append("User Email: ").append(comment.getUserEmail()).append(System.lineSeparator());
        record.append("Property ID: ").append(comment.getPropertyId()).append(System.lineSeparator());
        record.append("Comment Text: ").append(comment.getText()).append(System.lineSeparator());
        record.append("Rating: ").append(comment.getRating()).append(System.lineSeparator());
        record.append("----").append(System.lineSeparator());

        Files.write(Paths.get(COMMENTS_FILE), record.toString().getBytes(), StandardOpenOption.CREATE, StandardOpenOption.APPEND);
    }

    // Retrieve all comments from the file
    public static List<Comment> getAllComments() throws IOException {
        Path path = Paths.get(COMMENTS_FILE);
        if (!Files.exists(path)) {
            return new ArrayList<>();
        }
        List<Comment> comments = new ArrayList<>();
        List<String> lines = Files.readAllLines(path);
        Map<String, String> current = new HashMap<>();

        for (String line : lines) {
            if (line.equals("----")) {
                if (!current.isEmpty()) {
                    Comment comment = new Comment();
                    comment.setUserEmail(current.get("User Email"));
                    comment.setPropertyId(current.get("Property ID"));
                    comment.setText(current.get("Comment Text"));
                    try {
                        comment.setRating(Integer.parseInt(current.getOrDefault("Rating", "0")));
                    } catch (NumberFormatException e) {
                        comment.setRating(0); // fallback
                    }
                    comments.add(comment);
                    current.clear();
                }
            } else if (line.contains(":")) {
                String[] parts = line.split(":", 2);
                if (parts.length == 2) {
                    current.put(parts[0].trim(), parts[1].trim());
                }
            }
        }
        return comments;
    }

    // Retrieve comments specific to a property
    public static List<Comment> getCommentsByPropertyId(String propertyId) throws IOException {
        List<Comment> allComments = getAllComments();
        List<Comment> filtered = new ArrayList<>();

        for (Comment c : allComments) {
            if (c.getPropertyId() != null && c.getPropertyId().equals(propertyId)) {
                filtered.add(c);
            }
        }
        return filtered;
    }
}

package com.example.demo.servelts.comments;

import com.example.demo.models.Comment;
import com.example.demo.service.CommentManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/SubmitCommentServlet")
public class SubmitCommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userEmail = request.getParameter("userEmail");
        String propertyId = request.getParameter("propertyId");
        String commentText = request.getParameter("commentText");
        String ratingStr = request.getParameter("rating");

        if (userEmail == null || propertyId == null || commentText == null || commentText.trim().isEmpty()) {
            response.sendRedirect("comments.jsp?propertyId=" + propertyId + "&error=Missing fields");
            return;
        }

        int rating = 0;
        try {
            rating = Integer.parseInt(ratingStr);
        } catch (NumberFormatException e) {
            // Rating is optional or invalid
        }

        Comment comment = new Comment();
        comment.setUserEmail(userEmail);
        comment.setPropertyId(propertyId);
        comment.setText(commentText);
        comment.setRating(rating);

        CommentManager.saveComment(comment);

        response.sendRedirect("comments.jsp?propertyId=" + propertyId + "&success=1");
    }
}

package com.example.demo.servelts.comments;

import com.example.demo.models.Comment;
import com.example.demo.service.CommentManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/addComment")
public class AddCommentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String userEmail = request.getParameter("email");
        String propertyId = request.getParameter("propertyId");
        String text = request.getParameter("text");

        // Create comment object
        Comment comment = new Comment();
        comment.setUserEmail(userEmail);
        comment.setPropertyId(propertyId);
        comment.setText(text);

        try {
            // Save the comment
            CommentManager.saveComment(comment);

            // Optionally, add a message in session or request
            HttpSession session = request.getSession();
            session.setAttribute("commentMessage", "Comment added successfully!");

            // Redirect to comments page or wherever
            response.sendRedirect("comments.jsp");
        } catch (IOException e) {
            throw new ServletException("Failed to save comment", e);
        }
    }
}

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.demo.models.Comment" %>
<%@ page import="com.example.demo.models.Property" %>
<%@ page import="com.example.demo.service.CommentManager" %>
<%@ page import="com.example.demo.service.PropertyManager" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Global Sentiment Analysis | Estately</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .comment-view {
            padding: 4rem 10%;
            max-width: 1400px;
            margin: 0 auto;
        }

        .comment-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }

        .comment-card {
            background: white;
            padding: 2rem;
            border-radius: 24px;
            box-shadow: var(--shadow);
            border: 1px solid #f1f5f9;
            transition: all 0.3s;
        }

        .comment-card:hover {
            transform: translateY(-5px);
            border-color: #3b82f6;
        }

        .author-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .author-avatar {
            width: 44px;
            height: 44px;
            background: #eff6ff;
            color: #3b82f6;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        .property-link {
            display: inline-block;
            margin-bottom: 1.25rem;
            padding: 0.4rem 0.8rem;
            background: #f8fafc;
            border-radius: 8px;
            color: #3b82f6;
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 700;
            border: 1px solid #e2e8f0;
            transition: all 0.3s;
        }

        .property-link:hover {
            background: #3b82f6;
            color: white;
            border-color: #3b82f6;
        }

        .comment-body {
            color: #475569;
            line-height: 1.6;
            font-size: 0.95rem;
            margin-bottom: 1.5rem;
            font-style: italic;
        }

        .rating-stars {
            color: #fbbf24;
            font-size: 0.9rem;
            padding-top: 1rem;
            border-top: 1px solid #f1f5f9;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>
<body class="dashboard-container-ref">

    <jsp:include page="seller-sidebar.jsp" />

    <div class="main-ref-content">
        <header class="ref-header">
            <div>
                <h1 style="font-size: 1.75rem; font-weight: 800; color: #1e293b;">Public Sentiment</h1>
                <p style="font-size: 0.85rem; color: #64748b; font-weight: 600;">Market Perception Tracking Mode</p>
            </div>
            <div style="display: flex; align-items: center; gap: 1rem;">
                <div style="text-align: right;">
                    <p style="font-size: 0.8rem; font-weight: 800; color: #1e293b;"><%= session.getAttribute("email") %></p>
                    <p style="font-size: 0.7rem; color: #3b82f6; font-weight: 700;">Verified Seller</p>
                </div>
                <div style="width: 40px; height: 40px; background: #e69a4c; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.9rem;">S</div>
            </div>
        </header>

        <div class="ref-section">
            <div style="margin-bottom: 3rem;">
                <h2 class="ref-section-title" style="margin-bottom: 0.5rem;">Market Feedback Registry</h2>
                <p style="color: #64748b; font-size: 0.85rem; font-weight: 600;">A comprehensive overview of resident experiences across all property assets.</p>
            </div>

            <%
                List<Comment> allComments = new ArrayList<>();
                try {
                    allComments = CommentManager.getAllComments();
                } catch (Exception e) {}

                PropertyManager propertyManager = new PropertyManager();

                if (allComments == null || allComments.isEmpty()) {
            %>
            <div style="text-align: center; padding: 10rem 2rem; background: #f8fafc; border-radius: 32px; border: 2px dashed #e2e8f0;">
                <div style="width: 80px; height: 80px; background: white; color: #cbd5e1; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 2.5rem; margin: 0 auto 1.5rem; box-shadow: 0 4px 6px rgba(0,0,0,0.02);">
                    <i class="fas fa-comment-slash"></i>
                </div>
                <h2 style="font-size: 1.5rem; font-weight: 800; color: #1e293b;">No Feedback Records Found</h2>
                <p style="color: #64748b; margin-top: 0.5rem; font-weight: 600;">The public record of resident sentiment is currently empty for your assets.</p>
            </div>
            <%
            } else {
            %>
            <div class="comment-list" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(400px, 1fr)); gap: 2rem;">
                <%
                    for (Comment comment : allComments) {
                        Property property = null;
                        try {
                            property = propertyManager.findPropertyById(comment.getPropertyId());
                        } catch (Exception e) {}
                        
                        // Check if this property belongs to the seller (or user is admin)
                        if (property != null && (session.getAttribute("email").equals(property.getSellerEmail()) || "admin".equals(session.getAttribute("role")))) {
                %>
                <div class="comment-card" style="background: white; padding: 2rem; border-radius: 20px; border: 1px solid #f1f5f9; box-shadow: 0 4px 6px rgba(0,0,0,0.02); transition: all 0.3s; display: flex; flex-direction: column;">
                    <div class="author-info" style="display: flex; align-items: center; gap: 1rem; margin-bottom: 1.5rem;">
                        <div class="author-avatar" style="width: 40px; height: 40px; background: #eff6ff; color: #3b82f6; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 1rem; font-weight: 800;"><i class="fas fa-user-tie"></i></div>
                        <div>
                            <div style="font-weight: 800; color: #1e293b; font-size: 0.9rem;"><%= comment.getUserEmail() %></div>
                            <div style="font-size: 0.7rem; color: #3b82f6; font-weight: 700; text-transform: uppercase;">Resident Identity</div>
                        </div>
                    </div>

                    <a href="<%= request.getContextPath() %>/pages/user/user-property-details.jsp?id=<%= property.getId() %>" class="property-link" style="display: inline-block; margin-bottom: 1.25rem; padding: 0.5rem 0.75rem; background: #f8fafc; border-radius: 10px; color: #1e293b; text-decoration: none; font-size: 0.8rem; font-weight: 800; border: 1px solid #e2e8f0; align-self: flex-start; transition: all 0.3s;">
                        <i class="fas fa-home" style="margin-right: 0.5rem; color: #3b82f6;"></i> Asset: <%= property.getTitle() %>
                    </a>

                    <p class="comment-body" style="color: #475569; line-height: 1.7; font-size: 0.9rem; margin-bottom: 1.5rem; font-style: italic; font-weight: 600; flex-grow: 1;">
                        "<%= comment.getText() %>"
                    </p>

                    <div class="rating-stars" style="color: #fbbf24; font-size: 0.8rem; padding-top: 1rem; border-top: 1px solid #f8fafc; display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <% for (int i = 1; i <= 5; i++) { %>
                                <i class="<%= i <= comment.getRating() ? "fas" : "far" %> fa-star"></i>
                            <% } %>
                        </div>
                        <span style="color: #94a3b8; font-size: 0.65rem; font-weight: 800; text-transform: uppercase; letter-spacing: 0.05em;">Authorized Rating Value</span>
                    </div>
                </div>
                <% 
                        }
                    } 
                %>
            </div>
            <% } %>
        </div>
    </div>

</body>
</html>

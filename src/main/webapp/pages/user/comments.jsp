<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*, java.util.*" %>
<%
    String propertyId = request.getParameter("propertyId");
    String userEmail = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");

    if (propertyId == null || userEmail == null || role == null) {
        response.sendRedirect(request.getContextPath() + "/pages/common/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Share Your Experience | Estately</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            background: #f8fafc;
        }

        .comment-wrapper {
            max-width: 600px;
            margin: 5rem auto;
            background: white;
            padding: 3rem;
            border-radius: 28px;
            box-shadow: var(--shadow);
            border: 1px solid #f1f5f9;
        }

        .rating-group {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .rating-group input {
            display: none;
        }

        .rating-group label {
            font-size: 2.5rem;
            color: #e2e8f0;
            cursor: pointer;
            transition: all 0.2s;
        }

        .rating-group label:hover,
        .rating-group label:hover ~ label,
        .rating-group input:checked ~ label {
            color: #fbbf24;
            transform: scale(1.1);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 700;
            color: #475569;
            font-size: 0.85rem;
            text-transform: uppercase;
        }

        textarea {
            width: 100%;
            height: 150px;
            padding: 1.25rem;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            background: #f8fafc;
            font-family: inherit;
            resize: none;
            outline: none;
            transition: all 0.3s;
        }

        textarea:focus {
            background: white;
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
        }

        .info-strip {
            display: flex;
            gap: 1rem;
            margin-bottom: 2.5rem;
            padding: 1rem;
            background: #eff6ff;
            border-radius: 14px;
            color: #3b82f6;
            font-size: 0.85rem;
            font-weight: 600;
        }
    </style>
</head>
<body>

<jsp:include page="../common/header.jsp" />

<div class="comment-wrapper">
    <div style="text-align: center; margin-bottom: 2.5rem;">
        <h1 style="font-size: 2rem; font-weight: 800; color: #1e293b;">Resident Insight</h1>
        <p style="color: #64748b; margin-top: 0.5rem;">Share your professional perspective on this property asset.</p>
    </div>

    <div class="info-strip">
        <span><i class="fas fa-fingerprint"></i> Asset #<%= propertyId %></span>
        <span><i class="fas fa-user-shield"></i> Verified Author</span>
    </div>

    <%
        String success = request.getParameter("success");
        if ("1".equals(success)) {
    %>
    <div style="background: #f0fdf4; color: #166534; padding: 1rem; border-radius: 12px; margin-bottom: 2rem; text-align: center;">
        <i class="fas fa-check-circle"></i> Insight published successfully.
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/SubmitCommentServlet" method="post">
        <input type="hidden" name="userEmail" value="<%= userEmail %>">
        <input type="hidden" name="propertyId" value="<%= propertyId %>">

        <div class="form-group">
            <label class="form-label">Metric Evaluation</label>
            <div class="rating-group">
                <input type="radio" name="rating" id="star5" value="5" required><label for="star5">★</label>
                <input type="radio" name="rating" id="star4" value="4"><label for="star4">★</label>
                <input type="radio" name="rating" id="star3" value="3"><label for="star3">★</label>
                <input type="radio" name="rating" id="star2" value="2"><label for="star2">★</label>
                <input type="radio" name="rating" id="star1" value="1"><label for="star1">★</label>
            </div>
        </div>

        <div class="form-group">
            <label for="commentText" class="form-label">Narrative Feedback</label>
            <textarea name="commentText" id="commentText" placeholder="Describe the ambiance, infrastructure, and community experience..." required></textarea>
        </div>

        <div style="margin-top: 2.5rem; display: flex; gap: 1rem;">
            <button type="submit" class="btn btn-primary" style="flex: 2; padding: 1.25rem;">Publish Review</button>
            <a href="<%= request.getContextPath() %>/pages/user/user-property-details.jsp?id=<%= propertyId %>" class="btn btn-outline" style="flex: 1; text-align: center; padding: 1.25rem;">Discard</a>
        </div>
    </form>
</div>

</body>
</html>

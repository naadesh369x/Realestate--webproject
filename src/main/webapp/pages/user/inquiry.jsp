<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String propertyId = request.getParameter("propertyId");
  String userEmail = (String) session.getAttribute("email");
  String userName = (String) session.getAttribute("firstName"); 
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Inquiry | Estately</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            background: #f8fafc;
        }

        .inquiry-wrapper {
            max-width: 650px;
            margin: 5rem auto;
        }

        .inquiry-card {
            background: white;
            padding: 3rem;
            border-radius: 28px;
            box-shadow: var(--shadow);
            border: 1px solid #f1f5f9;
        }

        .info-pill-container {
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
            margin-bottom: 2rem;
        }

        .info-pill {
            background: #eff6ff;
            color: #3b82f6;
            padding: 0.5rem 1rem;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.75rem;
            font-weight: 600;
            color: #1e293b;
            font-size: 0.95rem;
        }

        textarea {
            width: 100%;
            height: 180px;
            padding: 1.25rem;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            background: #f8fafc;
            font-family: inherit;
            font-size: 1rem;
            resize: none;
            transition: all 0.3s;
            outline: none;
        }

        textarea:focus {
            background: white;
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
        }

        .submit-btn-row {
            margin-top: 2rem;
            display: flex;
            gap: 1rem;
        }
    </style>
</head>
<body>

<jsp:include page="../common/header.jsp" />

<div class="inquiry-wrapper">
    <div style="text-align: center; margin-bottom: 2.5rem;">
        <h1 style="font-size: 2.25rem; font-weight: 800; color: #1e293b;">Consult with Seller</h1>
        <p style="color: #64748b; margin-top: 0.5rem;">Direct communication line for asset clarifications.</p>
    </div>

    <div class="inquiry-card">
        <div class="info-pill-container">
            <div class="info-pill">
                <i class="fas fa-hashtag"></i> ID: <%= propertyId %>
            </div>
            <div class="info-pill" style="background: #f0fdf4; color: #10b981;">
                <i class="fas fa-user-check"></i> Verified Profile: <%= (userName != null) ? userName : "Default User" %>
            </div>
        </div>

        <form action="<%= request.getContextPath() %>/inquiry" method="post">
            <input type="hidden" name="propertyId" value="<%= propertyId %>">
            <input type="hidden" name="userEmail" value="<%= userEmail %>">
            <input type="hidden" name="userName" value="<%= userName %>">

            <div style="margin-bottom: 1.5rem;">
                <label class="form-label">Active Correspondent</label>
                <div style="padding: 1rem; background: #f8fafc; border-radius: 12px; border: 1px solid #e2e8f0; color: #64748b; font-size: 0.9rem;">
                    <i class="fas fa-envelope-open-text" style="color: #3b82f6; margin-right: 0.75rem;"></i>
                    <%= userEmail %>
                </div>
            </div>

            <div>
                <label for="message" class="form-label">Consultation Inquiry</label>
                <textarea name="message" id="message" placeholder="State your intent or questions regarding the property assets..." required></textarea>
            </div>

            <div class="submit-btn-row">
                <button type="submit" class="btn btn-primary" style="flex: 2; padding: 1.25rem;">
                    <i class="fas fa-paper-plane" style="margin-right: 0.75rem;"></i> Dispatch Inquiry
                </button>
                <a href="<%= request.getContextPath() %>/user-dashboard" class="btn btn-outline" style="flex: 1; text-align: center; padding: 1.25rem;">Cancel</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>
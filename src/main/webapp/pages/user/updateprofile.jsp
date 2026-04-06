<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");
    if (email == null || role == null) {
        response.sendRedirect(request.getContextPath() + "/pages/common/login.jsp");
        return;
    }
    String firstName = (String) session.getAttribute("firstName");
    String lastName = (String) session.getAttribute("lastName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Identity Control | Estately</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            background: #f8fafc;
        }

        .profile-wrapper {
            max-width: 600px;
            margin: 5rem auto;
            background: white;
            padding: 3rem;
            border-radius: 28px;
            box-shadow: var(--shadow);
            border: 1px solid #f1f5f9;
        }

        .profile-avatar-sec {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 3rem;
        }

        .avatar-circle {
            width: 90px;
            height: 90px;
            background: #eff6ff;
            color: #3b82f6;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            margin-bottom: 1rem;
            border: 4px solid white;
            box-shadow: 0 10px 15px -3px rgba(59, 130, 246, 0.1);
        }

        .role-indicator {
            background: #f1f5f9;
            color: #64748b;
            padding: 0.35rem 1rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
        }

        .form-section {
            display: grid;
            gap: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-size: 0.85rem;
            font-weight: 700;
            color: #475569;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        input {
            width: 100%;
            padding: 0.875rem 1.25rem;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            background: #f8fafc;
            font-family: inherit;
            transition: all 0.3s;
            outline: none;
        }

        input[readonly] {
            cursor: not-allowed;
            color: #94a3b8;
            background: #f1f5f9;
        }

        input:focus:not([readonly]) {
            background: white;
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
        }

        .alert-error {
            background: #fef2f2;
            color: #ef4444;
            padding: 1rem;
            border-radius: 12px;
            font-size: 0.875rem;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
    </style>
</head>
<body>

<jsp:include page="../common/header.jsp" />

<div class="profile-wrapper">
    <div class="profile-avatar-sec">
        <div class="avatar-circle">
            <i class="fas fa-user-gear"></i>
        </div>
        <h1 style="font-size: 1.5rem; font-weight: 800; color: #1e293b;">Account Identity</h1>
        <div class="role-indicator"><%= role %></div>
    </div>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert-error">
        <i class="fas fa-exclamation-circle"></i>
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/updateProfileServlet" method="post" class="form-section">
        <div>
            <label for="email">Account Core Identifier</label>
            <input type="text" id="email" name="email" value="<%= email %>" readonly>
            <p style="font-size: 0.7rem; color: #94a3b8; margin-top: 0.4rem;"><i class="fas fa-lock"></i> Permanent system identifier</p>
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
            <div>
                <label for="firstName">Given Name</label>
                <input type="text" id="firstName" name="firstName" value="<%= firstName %>" required>
            </div>
            <div>
                <label for="lastName">Family Name</label>
                <input type="text" id="lastName" name="lastName" value="<%= lastName %>" required>
            </div>
        </div>

        <div>
            <label for="newPassword">Security Credential Update</label>
            <input type="password" id="newPassword" name="newPassword" placeholder="Confirm new master key..." required>
        </div>

        <div style="margin-top: 1.5rem; display: flex; gap: 1rem;">
            <button type="submit" class="btn btn-primary" style="flex: 2; padding: 1rem;">Confirm Identity Update</button>
            <a href="<%= request.getContextPath() %>/mainpage.jsp" class="btn btn-outline" style="flex: 1; text-align: center; padding: 1rem;">Discard</a>
        </div>
    </form>
</div>

</body>
</html>

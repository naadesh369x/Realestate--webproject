<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Portal | Estately</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #0f172a; /* Dark sleek background for admin */
            overflow: hidden;
        }

        .admin-login-card {
            width: 100%;
            max-width: 400px;
            padding: 3rem;
            border-radius: 24px;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: white;
            animation: slideUp 0.8s ease-out;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .admin-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .admin-header i {
            font-size: 3rem;
            color: #3b82f6;
            margin-bottom: 1rem;
        }

        .admin-header h2 {
            font-size: 1.75rem;
            font-weight: 800;
            letter-spacing: -0.025em;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
            font-weight: 500;
            color: #94a3b8;
        }

        .input-box {
            position: relative;
        }

        .input-box i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
        }

        .input-box input {
            width: 100%;
            padding: 0.875rem 1rem 0.875rem 2.875rem;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            color: white;
            outline: none;
            transition: all 0.3s;
        }

        .input-box input:focus {
            background: rgba(255, 255, 255, 0.1);
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.2);
        }

        .error-msg {
            background: rgba(239, 68, 68, 0.1);
            color: #f87171;
            padding: 0.75rem 1rem;
            border-radius: 12px;
            font-size: 0.875rem;
            margin-bottom: 1.5rem;
            border: 1px solid rgba(239, 68, 68, 0.2);
            text-align: center;
        }

        .back-link {
            position: absolute;
            top: 2rem;
            left: 2rem;
            color: #94a3b8;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: color 0.3s;
        }

        .back-link:hover {
            color: white;
        }
    </style>
</head>
<body>

<a href="<%= request.getContextPath() %>/pages/common/mainpage.jsp" class="back-link">
    <i class="fas fa-arrow-left"></i> Main Portal
</a>

<div class="admin-login-card">
    <div class="admin-header">
        <i class="fas fa-shield-halved"></i>
        <h2>Admin Gateway</h2>
        <p style="color: #64748b; margin-top: 0.5rem;">Restricted area for authorized staff</p>
    </div>

    <% String error = request.getParameter("error"); %>
    <% if (error != null) { %>
    <div class="error-msg">
        <i class="fas fa-exclamation-triangle" style="margin-right: 0.5rem;"></i>
        <%= error %>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/admin-login" method="post">
        <div class="form-group">
            <label>Admin Email</label>
            <div class="input-box">
                <i class="fas fa-envelope"></i>
                <input type="email" name="email" placeholder="admin@estately.com" required>
            </div>
        </div>

        <div class="form-group">
            <label>Master Password</label>
            <div class="input-box">
                <i class="fas fa-key"></i>
                <input type="password" name="password" placeholder="••••••••" required>
            </div>
        </div>

        <button type="submit" class="btn btn-primary" style="width: 100%; padding: 1rem; margin-top: 1rem;">
            Authenticate
        </button>
    </form>
</div>

</body>
</html>

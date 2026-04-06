<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Back | Estately</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)), url('<%= request.getContextPath() %>/images/hero-bg.png');
            background-size: cover;
            background-position: center;
        }

        .login-card {
            width: 100%;
            max-width: 480px;
            padding: 3rem;
            animation: slideUp 0.8s cubic-bezier(0.4, 0, 0.2, 1);
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .login-header i {
            font-size: 2.25rem;
            margin-bottom: 1rem;
        }

        .login-header h2 {
            font-size: 1.5rem;
            color: var(--text-main);
            font-weight: 800;
        }

        .login-header p {
            color: var(--text-muted);
            font-size: 0.9rem;
            font-weight: 600;
            margin-top: 0.25rem;
        }

        .back-home {
            position: absolute;
            top: 2rem;
            left: 2rem;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 700;
            font-size: 0.85rem;
        }
    </style>
</head>
<body>

<a href="<%= request.getContextPath() %>/mainpage.jsp" class="back-home">
    <i class="fas fa-arrow-left"></i> Back to Home
</a>

<div class="login-card glass">
    <div class="login-header">
        <i class="fas fa-home"></i>
        <span>Estately</span>
        <h2 style="margin-top: 1rem;">Welcome Back</h2>
        <p>Sign in to continue to your dashboard</p>
    </div>

    <!-- Role Tabs -->
    <div class="auth-tabs">
        <div id="userTab" class="auth-tab active" onclick="setRole('user')">User</div>
        <div id="sellerTab" class="auth-tab" onclick="setRole('seller')">Seller</div>
    </div>

    <%
        String error = request.getParameter("error");
        if (error != null && !error.isEmpty()) {
    %>
    <div style="background: #fef2f2; color: #ef4444; padding: 0.75rem; border-radius: 12px; margin-bottom: 1.5rem; font-size: 0.8rem; font-weight: 700; text-align: center; border: 1px solid #fee2e2;">
        <i class="fas fa-exclamation-circle"></i> <%= error %>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/login" method="post">
        <input type="hidden" name="role" id="role" value="user">

        <div class="auth-input-group">
            <label class="auth-label">Email Address</label>
            <div class="auth-field-box">
                <i class="fas fa-envelope"></i>
                <input type="email" name="email" class="auth-input" placeholder="user3@gmail.com" required>
            </div>
        </div>

        <div class="auth-input-group">
            <label class="auth-label">Password</label>
            <div class="auth-field-box">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" class="auth-input" placeholder="••••••••" required>
            </div>
        </div>

        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
            <label style="display: flex; align-items: center; gap: 0.5rem; color: var(--text-muted); font-size: 0.8rem; font-weight: 700; cursor: pointer;">
                <input type="checkbox" name="rememberMe" style="accent-color: var(--primary);"> Remember me
            </label>
            <a href="#" style="color: var(--primary); font-size: 0.8rem; text-decoration: none; font-weight: 700;">Forgot Password?</a>
        </div>

        <button type="submit" class="btn btn-primary" style="width: 100%; padding: 1rem; border-radius: 16px;">Sign In</button>
    </form>

    <div style="text-align: center; margin-top: 1.5rem; font-size: 0.85rem; color: var(--text-muted); font-weight: 600;">
        Don't have an account? <a href="<%= request.getContextPath() %>/pages/common/register.jsp" style="color: var(--primary); font-weight: 800;">Create for free</a>
    </div>
</div>

<script>
    function setRole(role) {
        document.getElementById('role').value = role;
        const userTab = document.getElementById('userTab');
        const sellerTab = document.getElementById('sellerTab');
        
        if (role === 'user') {
            userTab.classList.add('active');
            sellerTab.classList.remove('active');
        } else {
            sellerTab.classList.add('active');
            userTab.classList.remove('active');
        }
    }
</script>

</body>
</html>

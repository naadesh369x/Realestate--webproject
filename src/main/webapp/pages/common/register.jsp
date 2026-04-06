<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account | Estately</title>
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
            padding: 2rem;
        }

        .register-card {
            width: 100%;
            max-width: 600px;
            padding: 3rem;
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .register-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .register-header i {
            font-size: 2rem;
            margin-bottom: 0.75rem;
        }

        .register-header h2 {
            font-size: 1.5rem;
            font-weight: 800;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.25rem;
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
        }

        @media (max-width: 640px) {
            .form-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<a href="<%= request.getContextPath() %>/mainpage.jsp" class="back-home">
    <i class="fas fa-arrow-left"></i> Home
</a>

<div class="register-card glass">
    <div class="register-header">
        <i class="fas fa-home"></i>
        <span>Estately</span>
        <h2 style="margin-top: 1rem;">Join Our Community</h2>
        <p style="color: var(--text-muted); font-size: 0.9rem; font-weight: 600;">Explore premium residential assets today</p>
    </div>

    <!-- Role Tabs -->
    <div class="auth-tabs">
        <div id="userTab" class="auth-tab active" onclick="setRole('user')">Buyer</div>
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

    <form action="<%= request.getContextPath() %>/register" method="post">
        <input type="hidden" name="role" id="role" value="user">

        <div class="form-grid">
            <div class="auth-input-group">
                <label class="auth-label">First Name</label>
                <div class="auth-field-box">
                    <i class="fas fa-user-circle"></i>
                    <input type="text" name="firstName" class="auth-input" placeholder="John" required>
                </div>
            </div>
            <div class="auth-input-group">
                <label class="auth-label">Last Name</label>
                <div class="auth-field-box">
                    <i class="fas fa-user"></i>
                    <input type="text" name="lastName" class="auth-input" placeholder="Doe" required>
                </div>
            </div>
        </div>

        <div class="auth-input-group">
            <label class="auth-label">Email Presence</label>
            <div class="auth-field-box">
                <i class="fas fa-envelope-open"></i>
                <input type="email" name="email" class="auth-input" placeholder="client@estately.com" required>
            </div>
        </div>

        <div class="form-grid">
            <div class="auth-input-group">
                <label class="auth-label">Create Key</label>
                <div class="auth-field-box">
                    <i class="fas fa-key"></i>
                    <input type="password" name="password" class="auth-input" placeholder="••••••••" required>
                </div>
            </div>
            <div class="auth-input-group">
                <label class="auth-label">Confirm Key</label>
                <div class="auth-field-box">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="confirmPassword" class="auth-input" placeholder="••••••••" required>
                </div>
            </div>
        </div>

        <div style="margin-bottom: 2rem;">
            <label style="display: flex; align-items: flex-start; gap: 0.75rem; color: var(--text-muted); font-size: 0.8rem; font-weight: 700; cursor: pointer; line-height: 1.5;">
                <input type="checkbox" name="rememberMe" style="accent-color: var(--primary); margin-top: 0.25rem;" required> 
                <span>I acknowledge the <a href="#" style="color: var(--primary); font-weight: 800;">Terms of Service</a> and <a href="#" style="color: var(--primary); font-weight: 800;">Privacy Shield</a>.</span>
            </label>
        </div>

        <button type="submit" class="btn btn-primary" style="width: 100%; padding: 1.15rem; border-radius: 16px;">Initialize Portfolio</button>
    </form>

    <div style="text-align: center; margin-top: 1.5rem; font-size: 0.85rem; color: var(--text-muted); font-weight: 600;">
        Already have an account? <a href="<%= request.getContextPath() %>/pages/common/login.jsp" style="color: var(--primary); font-weight: 800;">Sign in presence</a>
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

<%
  String contextPath = request.getContextPath();
  String userEmail = (String) session.getAttribute("email");
  // Redirection logic removed to allow Guest access on Mainpage/Discovery
%>
<link rel="stylesheet" href="<%= contextPath %>/css/modern.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
    .header-nav {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 1.25rem 8%;
      background: rgba(255, 255, 255, 0.9);
      backdrop-filter: blur(12px);
      -webkit-backdrop-filter: blur(12px);
      border-bottom: 1px solid #f1f5f9;
      position: sticky;
      top: 0;
      z-index: 1000;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
    }

    .header-nav .logo {
      display: flex;
      align-items: center;
      gap: 0.75rem;
      font-size: 1.5rem;
      font-weight: 800;
      color: #0f172a;
    }

    .header-right {
      display: flex;
      gap: 1.5rem;
      align-items: center;
    }

    .account-dropdown {
      position: relative;
    }

    .dropdown-btn {
      display: flex;
      align-items: center;
      gap: 1rem;
      padding: 0.6rem 1.25rem;
      background: #f8fafc;
      border-radius: 12px;
      cursor: pointer;
      border: 1px solid #e2e8f0;
      transition: all 0.3s;
    }

    .dropdown-btn:hover {
      background: #f1f5f9;
      border-color: #3b82f6;
    }

    .dropdown-menu {
      position: absolute;
      top: calc(100% + 0.75rem);
      right: 0;
      background: white;
      border-radius: 16px;
      box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
      width: 260px;
      padding: 0.75rem;
      opacity: 0;
      visibility: hidden;
      transform: translateY(10px);
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      border: 1px solid #f1f5f9;
    }

    .dropdown-menu.visible {
      opacity: 1;
      visibility: visible;
      transform: translateY(0);
    }

    .dropdown-menu a, .dropdown-menu button {
      display: flex;
      align-items: center;
      width: 100%;
      padding: 0.875rem 1rem;
      color: #475569;
      text-decoration: none;
      font-size: 0.85rem;
      font-weight: 700;
      border-radius: 10px;
      transition: all 0.2s;
      border: none;
      background: transparent;
      text-align: left;
      cursor: pointer;
      margin-bottom: 0.25rem;
    }

    .dropdown-menu a:hover, .dropdown-menu button:hover {
      background: #eff6ff;
      color: #3b82f6;
    }

    .auth-action-btn {
      padding: 0.6rem 1.5rem;
      background: #ef4444;
      color: white;
      border: none;
      border-radius: 10px;
      font-weight: 800;
      cursor: pointer;
      transition: all 0.3s;
      font-size: 0.85rem;
    }

    .auth-action-btn:hover {
      background: #dc2626;
      transform: translateY(-2px);
      box-shadow: 0 10px 15px -3px rgba(239, 68, 68, 0.3);
    }
</style>

<div class="header-nav">
  <a href="<%= contextPath %>/pages/common/mainpage.jsp" class="logo" style="text-decoration: none;">
    <i class="fas fa-home"></i>
    <span>Estately</span>
  </a>

  <div class="header-right">
    <% if (userEmail != null) { %>
    <div class="account-dropdown">
      <div class="dropdown-btn" onclick="toggleNavMenu()">
        <i class="fas fa-user-shield" style="color: #3b82f6;"></i>
        <div style="font-weight: 500; color: #1e293b;"><%= userEmail %></div>
        <i class="fas fa-chevron-down" style="font-size: 0.6rem; opacity: 0.5; color: #1e293b;"></i>
      </div>
      <div id="navAccountMenu" class="dropdown-menu">
        <a href="<%= contextPath %>/pages/user/updateprofile.jsp"><i class="fas fa-id-badge" style="margin-right: 1rem;"></i> Profile Node</a>
        <a href="<%= contextPath %>/pages/user/usermessage.jsp"><i class="fas fa-comment-dots" style="margin-right: 1rem;"></i> Messages</a>
        <a href="<%= contextPath %>/pages/user/userdashboard.jsp"><i class="fas fa-th-large" style="margin-right: 1rem;"></i> My Assets</a>
        <div style="height: 1px; background: #f1f5f9; margin: 0.5rem 0;"></div>
        <form action="<%= contextPath %>/pages/common/login.jsp" method="post" style="padding: 0; margin: 0;">
          <button type="submit" style="color: #ef4444;"><i class="fas fa-power-off" style="margin-right: 1rem;"></i> Log Out Presence</button>
        </form>
      </div>
    </div>
    <% } else { %>
    <div style="display: flex; gap: 1rem;">
      <a href="<%= contextPath %>/pages/common/login.jsp" class="btn btn-outline" style="padding: 0.6rem 1.5rem; border-radius: 12px; font-size: 0.85rem;">Login</a>
      <a href="<%= contextPath %>/pages/common/register.jsp" class="btn btn-primary" style="padding: 0.6rem 1.5rem; border-radius: 12px; font-size: 0.85rem;">Join Discovery</a>
    </div>
    <% } %>
  </div>
</div>

<script>
  function toggleNavMenu() {
    document.getElementById("navAccountMenu").classList.toggle("visible");
  }

  window.onclick = function(event) {
    if (!event.target.closest('.account-dropdown')) {
      var menu = document.getElementById("navAccountMenu");
      if (menu && menu.classList.contains('visible')) {
        menu.classList.remove('visible');
      }
    }
  }
</script>

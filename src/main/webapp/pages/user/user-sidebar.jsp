<%
    String currentPath = request.getRequestURI();
    String contextPath = request.getContextPath();
%>
<div class="sidebar-ref">
    <div class="sidebar-title-ref">Client Portal</div>
    
    <div class="sidebar-label-ref">Exploration</div>
    <ul class="sidebar-nav-list-ref">
        <li><a href="<%= contextPath %>/pages/user/userdashboard.jsp" class="sidebar-link-ref <%= currentPath.contains("userdashboard.jsp") ? "active" : "" %>"><i class="fas fa-search-location"></i> Global Portfolio</a></li>
    </ul>

    <div class="sidebar-label-ref">My Journey</div>
    <ul class="sidebar-nav-list-ref">
        <li><a href="<%= contextPath %>/pages/user/view-bookings.jsp" class="sidebar-link-ref <%= currentPath.contains("view-bookings.jsp") ? "active" : "" %>"><i class="fas fa-calendar-check"></i> Reserved Assets</a></li>
        <li><a href="<%= contextPath %>/pages/user/usermessage.jsp" class="sidebar-link-ref <%= currentPath.contains("usermessage.jsp") ? "active" : "" %>"><i class="fas fa-comment-dots"></i> Conversations</a></li>
    </ul>

    <div class="sidebar-label-ref">Identity</div>
    <ul class="sidebar-nav-list-ref">
        <li><a href="<%= contextPath %>/pages/user/updateprofile.jsp" class="sidebar-link-ref <%= currentPath.contains("updateprofile.jsp") ? "active" : "" %>"><i class="fas fa-id-card"></i> Personal Records</a></li>
    </ul>

    <div style="margin-top: auto; padding-top: 1rem; border-top: 1px solid rgba(255,255,255,0.05);">
        <form action="<%= contextPath %>/pages/common/login.jsp" method="post" style="padding: 0; margin: 0;">
            <button type="submit" class="sidebar-link-ref" style="color: #f87171; background: transparent; border: none; width: 100%; text-align: left; cursor: pointer;">
                <i class="fas fa-power-off"></i> Exit Portal
            </button>
        </form>
    </div>
</div>

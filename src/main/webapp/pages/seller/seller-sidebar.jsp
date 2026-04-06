<%
    String currentPath = request.getRequestURI();
    String contextPath = request.getContextPath();
%>
<div class="sidebar-ref">
    <div class="sidebar-title-ref">Asset Control Hub</div>
    
    <div class="sidebar-label-ref">Inventory</div>
    <ul class="sidebar-nav-list-ref">
        <li><a href="<%= contextPath %>/seller-dashboard" class="sidebar-link-ref <%= currentPath.contains("seller-dashboard") || currentPath.contains("sellerdashboard.jsp") ? "active" : "" %>"><i class="fas fa-layer-group"></i> My Portfolio</a></li>
        <li><a href="<%= contextPath %>/pages/seller/add-property.jsp" class="sidebar-link-ref <%= currentPath.contains("add-property.jsp") ? "active" : "" %>"><i class="fas fa-plus-circle"></i> Initialize Asset</a></li>
    </ul>

    <div class="sidebar-label-ref">Operations</div>
    <ul class="sidebar-nav-list-ref">
        <li><a href="<%= contextPath %>/pages/seller/seller-bookings.jsp" class="sidebar-link-ref <%= currentPath.contains("seller-bookings.jsp") ? "active" : "" %>"><i class="fas fa-calendar-check"></i> Pending Requests</a></li>
        <li><a href="<%= contextPath %>/pages/seller/finalized-deals.jsp" class="sidebar-link-ref <%= currentPath.contains("finalized-deals.jsp") ? "active" : "" %>"><i class="fas fa-handshake"></i> Finalized Deals</a></li>
        <li><a href="<%= contextPath %>/pages/seller/viewinquiries.jsp" class="sidebar-link-ref <%= currentPath.contains("viewinquiries.jsp") ? "active" : "" %>"><i class="fas fa-envelope-open-text"></i> Negotiations</a></li>
    </ul>

    <div class="sidebar-label-ref">Communication</div>
    <ul class="sidebar-nav-list-ref">
        <li><a href="<%= contextPath %>/pages/seller/seller-conversations.jsp" class="sidebar-link-ref <%= currentPath.contains("seller-conversations.jsp") ? "active" : "" %>"><i class="fas fa-comments"></i> Conversations</a></li>
        <li><a href="<%= contextPath %>/pages/seller/all-comments.jsp" class="sidebar-link-ref <%= currentPath.contains("all-comments.jsp") ? "active" : "" %>"><i class="fas fa-star-half-stroke"></i> Public Sentiment</a></li>
    </ul>

    <div class="sidebar-label-ref">Profile</div>
    <ul class="sidebar-nav-list-ref">
        <li><a href="<%= contextPath %>/pages/user/updateprofile.jsp" class="sidebar-link-ref <%= currentPath.contains("updateprofile.jsp") ? "active" : "" %>"><i class="fas fa-user-gear"></i> Master Settings</a></li>
    </ul>

    <div style="margin-top: auto; padding-top: 1rem; border-top: 1px solid rgba(255,255,255,0.05);">
        <a href="<%= contextPath %>/pages/common/login.jsp" class="sidebar-link-ref" style="color: #f87171;"><i class="fas fa-power-off"></i> Exit Hub</a>
    </div>
</div>

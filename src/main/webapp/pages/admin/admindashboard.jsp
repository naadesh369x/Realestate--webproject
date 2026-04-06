<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.models.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Support Admin | Estately Control</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="dashboard-container-ref">

    <!-- Reference-Matched Sidebar -->
    <div class="sidebar-ref">
        <div class="sidebar-title-ref">Support Admin</div>
        
        <div class="sidebar-label-ref">Main</div>
        <ul class="sidebar-nav-list-ref">
            <li><a href="#" class="sidebar-link-ref active"><i class="fas fa-th-large"></i> Dashboard</a></li>
        </ul>

        <div class="sidebar-label-ref">Menu & Content</div>
        <ul class="sidebar-nav-list-ref">
            <li><a href="<%= request.getContextPath() %>/seller-dashboard" class="sidebar-link-ref"><i class="fas fa-home"></i> Manage Assets</a></li>
            <li><a href="#" class="sidebar-link-ref"><i class="fas fa-star"></i> Manage Reviews</a></li>
            <li><a href="#" class="sidebar-link-ref"><i class="fas fa-bell"></i> Manage Notices</a></li>
        </ul>

        <div class="sidebar-label-ref">Operations</div>
        <ul class="sidebar-nav-list-ref">
            <li><a href="<%= request.getContextPath() %>/pages/user/view-bookings.jsp" class="sidebar-link-ref"><i class="fas fa-calendar-check"></i> Manage Bookings</a></li>
            <li><a href="<%= request.getContextPath() %>/pages/seller/viewinquiries.jsp" class="sidebar-link-ref"><i class="fas fa-envelope-open"></i> Inquiries</a></li>
        </ul>

        <div class="sidebar-label-ref">Users & Staff</div>
        <ul class="sidebar-nav-list-ref">
            <li><a href="#" class="sidebar-link-ref"><i class="fas fa-user-group"></i> Manage Users</a></li>
            <li><a href="#" class="sidebar-link-ref"><i class="fas fa-user-plus"></i> Add Staff</a></li>
        </ul>

        <div class="sidebar-label-ref">Payments</div>
        <ul class="sidebar-nav-list-ref">
            <li><a href="#" class="sidebar-link-ref"><i class="fas fa-credit-card"></i> Paid Payments</a></li>
            <li><a href="#" class="sidebar-link-ref"><i class="fas fa-file-invoice"></i> Payment Report</a></li>
        </ul>

        <div style="margin-top: auto; padding-top: 1rem; border-top: 1px solid rgba(255,255,255,0.05);">
            <a href="<%= request.getContextPath() %>/pages/admin/adminlogin.jsp" class="sidebar-link-ref" style="color: #f87171;"><i class="fas fa-power-off"></i> Terminate Session</a>
        </div>
    </div>

    <!-- Reference-Matched Main Content -->
    <div class="main-ref-content">
        <header class="ref-header">
            <h1 style="font-size: 1.75rem; font-weight: 800; color: #1e293b;">Admin Dashboard</h1>
            <div style="width: 40px; height: 40px; background: #e69a4c; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.9rem;">D</div>
        </header>

        <!-- KPI Grid -->
        <div class="ref-kpi-grid">
            <div class="ref-kpi-card green">
                <div class="ref-kpi-label">Active Users</div>
                <div class="ref-kpi-val"><%= (request.getAttribute("totalUsers") != null) ? request.getAttribute("totalUsers") : "12" %></div>
            </div>
            <div class="ref-kpi-card">
                <div class="ref-kpi-label">Property Listings</div>
                <div class="ref-kpi-val"><%= (request.getAttribute("totalProperties") != null) ? request.getAttribute("totalProperties") : "48" %></div>
            </div>
            <div class="ref-kpi-card red">
                <div class="ref-kpi-label">Pending Inquiries</div>
                <div class="ref-kpi-val">7</div>
            </div>
            <div class="ref-kpi-card orange">
                <div class="ref-kpi-label">Recent Acquisitions</div>
                <div class="ref-kpi-val">3</div>
            </div>
        </div>

        <!-- Reference Sections -->
        <div class="ref-section">
            <h2 class="ref-section-title">Critical System Events (Active)</h2>
            <div class="ref-list-item">
                <div style="font-weight: 700; color: #1e293b;">Skyward Glass Pavilion | <span style="color: #e69a4c;">ID: #103</span> | Status: High Priority</div>
                <span class="ref-badge-new">NEW</span>
            </div>
            <div class="ref-list-item">
                <div style="font-weight: 700; color: #1e293b;">Golden Coast Villa | <span style="color: #e69a4c;">ID: #1024</span> | Status: Review Pending</div>
                <span class="ref-badge-new">NEW</span>
            </div>
        </div>

        <div class="ref-section">
            <h2 class="ref-section-title">User Intelligence Registry</h2>
            <div style="overflow-x: auto;">
                <table style="width: 100%; border-collapse: collapse; margin-top: 1rem;">
                    <thead>
                        <tr style="text-align: left; border-bottom: 2px solid #f8fafc;">
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Reference ID</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Identity</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Privilege</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase; text-align: right;">Action Control</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<User> users = (List<User>) request.getAttribute("users");
                            if (users != null && !users.isEmpty()) {
                                for (User user : users) {
                        %>
                        <tr class="ref-list-item" style="display: table-row;">
                            <td style="padding: 1.25rem 1rem; font-family: monospace; color: #3b82f6;">#USR-<%= user.getEmail().hashCode() %></td>
                            <td style="padding: 1.25rem 1rem; font-weight: 700; color: #1e293b;"><%= user.getEmail() %></td>
                            <td style="padding: 1.25rem 1rem;"><span class="ref-badge-new" style="background: #f1f5f9; color: #64748b;"><%= user.getRole() %></span></td>
                            <td style="padding: 1.25rem 1rem; text-align: right;">
                                <button style="background: transparent; border: none; color: #ef4444; font-weight: 800; cursor: pointer; font-size: 0.8rem;">REVOKE</button>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="4" style="text-align: center; padding: 4rem; color: #94a3b8; font-weight: 700;">No system identity records retrieved.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

</body>
</html>

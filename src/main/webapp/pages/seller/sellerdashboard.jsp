<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.demo.models.Property" %>
<%@ page import="java.util.*, java.io.*" %>
<%
    String sellerEmail = (String) session.getAttribute("email");
    if (sellerEmail == null) {
        response.sendRedirect(request.getContextPath() + "/pages/common/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asset Control Hub | Estately Global</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="dashboard-container-ref">

    <!-- Reference-Matched Sidebar -->
    <jsp:include page="seller-sidebar.jsp" />

    <!-- Reference-Matched Main Content -->
    <div class="main-ref-content">
        <header class="ref-header">
            <div>
                <h1 style="font-size: 1.75rem; font-weight: 800; color: #1e293b;">Seller Portfolio</h1>
                <p style="font-size: 0.85rem; color: #64748b; font-weight: 600;">Inventory Node Tracking Mode</p>
            </div>
            <div style="display: flex; align-items: center; gap: 1rem;">
                <div style="text-align: right;">
                    <p style="font-size: 0.8rem; font-weight: 800; color: #1e293b;"><%= sellerEmail %></p>
                    <p style="font-size: 0.7rem; color: #3b82f6; font-weight: 700;">Verified Seller</p>
                </div>
                <div style="width: 40px; height: 40px; background: #e69a4c; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.9rem;">S</div>
            </div>
        </header>

        <!-- Stats Overview -->
        <%
            List<Property> properties = (List<Property>) request.getAttribute("properties");
            int totalProps = (properties != null) ? properties.size() : 0;
            
            // Count historical confirmed deals from confirmed_bookings.txt
            int confirmedDealsCount = 0;
            String confirmedFilePath = System.getProperty("catalina.home") + File.separator + "bin" + File.separator + "confirmed_bookings.txt";
            File confirmedFile = new File(confirmedFilePath);
            if (confirmedFile.exists()) {
                try (BufferedReader br = new BufferedReader(new FileReader(confirmedFile))) {
                    String line;
                    while ((line = br.readLine()) != null) {
                        String[] parts = line.split(",");
                        // Assuming new format: ...parts[7] is seller email (if added recently) or we check property list
                        // Let's check parts[7] (seller email) or parts[1] (property id)
                        if (parts.length >= 8) {
                            String sellerPart = parts[7].trim();
                            if (sellerPart.equalsIgnoreCase(sellerEmail)) confirmedDealsCount++;
                        }
                    }
                } catch (Exception e) {}
            }

            // Count pending inquiries from inquiries.txt
            int pendingInquiries = 0;
            String inquiriesPath = "inquiries.txt"; // Adjust if absolute path is needed
            File inquiriesFile = new File(inquiriesPath);
            if (inquiriesFile.exists()) {
                try (BufferedReader br = new BufferedReader(new FileReader(inquiriesFile))) {
                    String line;
                    String currentPropId = "";
                    while ((line = br.readLine()) != null) {
                        if (line.startsWith("Property ID:")) {
                            currentPropId = line.substring(12).trim();
                        } else if (line.startsWith("----")) {
                            // Check if property belongs to seller
                            Property p = com.example.demo.service.PropertyManager.findPropertyById(currentPropId);
                            if (p != null && p.getSellerEmail().equalsIgnoreCase(sellerEmail)) {
                                pendingInquiries++;
                            }
                            currentPropId = "";
                        }
                    }
                } catch (Exception e) {}
            }
        %>
        <div class="ref-kpi-grid">
            <div class="ref-kpi-card">
                <div class="ref-kpi-label">Active Listings</div>
                <div class="ref-kpi-val"><%= totalProps %></div>
            </div>
            <div class="ref-kpi-card green">
                <div class="ref-kpi-label">Confirmed Deals</div>
                <div class="ref-kpi-val"><%= confirmedDealsCount %></div>
            </div>
            <div class="ref-kpi-card red">
                <div class="ref-kpi-label">Pending Inquiries</div>
                <div class="ref-kpi-val"><%= pendingInquiries %></div>
            </div>

        </div>

        <!-- Portfolio Registry -->
        <div class="ref-section">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                <h2 class="ref-section-title" style="margin-bottom: 0;">Global Asset Registry</h2>
                <a href="<%= request.getContextPath() %>/pages/seller/add-property.jsp" class="btn btn-primary" style="padding: 0.6rem 1.25rem; font-size: 0.8rem; border-radius: 10px;">Deploy New</a>
            </div>

            <div style="overflow-x: auto;">
                <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="text-align: left; border-bottom: 2px solid #f8fafc;">
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Reference</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Asset Details</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Status</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase; text-align: right;">Action Control</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (properties != null && !properties.isEmpty()) {
                                for (Property property : properties) {
                                    boolean isBooked = property.getBookedBy() != null && !property.getBookedBy().isEmpty();
                        %>
                        <tr class="ref-list-item" style="display: table-row;">
                            <td style="padding: 1.25rem 1rem;">
                                <div style="display: flex; align-items: center; gap: 1rem;">
                                    <div style="width: 44px; height: 44px; background: url('<%= request.getContextPath() %>/images/<%= (property.getImageFileName() != null) ? property.getImageFileName() : "hero-bg.png" %>') center/cover; border-radius: 8px;"></div>
                                    <span style="font-family: monospace; color: #3b82f6; font-weight: 700;">#AST-<%= property.getId() %></span>
                                </div>
                            </td>
                            <td style="padding: 1.25rem 1rem;">
                                <div style="font-weight: 800; color: #1e293b;"><%= property.getTitle() %></div>
                                <div style="font-size: 0.75rem; color: #64748b;"><i class="fas fa-map-marker-alt"></i> <%= property.getLocation() %></div>
                            </td>
                            <td style="padding: 1.25rem 1rem;">
                                <span class="ref-badge-new" style="background: <%= isBooked ? "#fee2e2" : "#dcfce7" %>; color: <%= isBooked ? "#ef4444" : "#10b981" %>;">
                                    <%= isBooked ? "Held" : "Live" %>
                                </span>
                            </td>
                            <td style="padding: 1.25rem 1rem; text-align: right;">
                                <div style="display: flex; justify-content: flex-end; gap: 0.5rem;">
                                    <% if (isBooked) { %>
                                        <button disabled title="Asset is currently reserved" style="padding: 0.4rem 0.875rem; background: #f1f5f9; color: #94a3b8; border-radius: 8px; font-weight: 800; border: none; font-size: 0.75rem; cursor: not-allowed;">LOCKED</button>
                                    <% } else { %>
                                        <a href="<%= request.getContextPath() %>/pages/seller/editproperty.jsp?id=<%= property.getId() %>" style="padding: 0.4rem 0.875rem; background: #eff6ff; color: #3b82f6; border-radius: 8px; font-weight: 800; text-decoration: none; font-size: 0.75rem;">EDIT</a>
                                        <form action="<%= request.getContextPath() %>/delete-property" method="post" onsubmit="return confirm('Immediately Dispose Asset?');" style="display: contents;">
                                            <input type="hidden" name="id" value="<%= property.getId() %>">
                                            <button type="submit" style="padding: 0.4rem 0.875rem; background: transparent; border: 1px solid #fee2e2; color: #ef4444; border-radius: 8px; font-weight: 800; cursor: pointer; font-size: 0.75rem;">DISPOSE</button>
                                        </form>
                                    <% } %>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr><td colspan="4" style="text-align: center; padding: 4rem; color: #94a3b8; font-weight: 700;">No system asset records found.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

</body>
</html>

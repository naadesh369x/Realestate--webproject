<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="com.example.demo.service.PropertyManager" %>
<%@ page import="com.example.demo.models.Property" %>

<%
    String sellerEmail = (String) session.getAttribute("email");
    if (sellerEmail == null) {
        response.sendRedirect(request.getContextPath() + "/pages/common/login.jsp");
        return;
    }

    String confirmedFilePath = System.getProperty("catalina.home") + File.separator + "bin" + File.separator + "confirmed_bookings.txt";

    class ConfirmedBookingInfo {
        String propertyId, firstName, lastName, userEmail, phoneNumber, bookingDateTime, confirmationDateTime, propertyTitle;
        public ConfirmedBookingInfo(String pId, String fName, String lName, String uEmail, String phone, String bDateTime, String cDateTime, String pTitle) {
            this.propertyId = pId;
            this.firstName = fName;
            this.lastName = lName;
            this.userEmail = uEmail;
            this.phoneNumber = phone;
            this.bookingDateTime = bDateTime;
            this.confirmationDateTime = cDateTime;
            this.propertyTitle = pTitle;
        }
    }

    List<ConfirmedBookingInfo> finalizedDeals = new ArrayList<>();
    File confirmedFile = new File(confirmedFilePath);
    if (confirmedFile.exists()) {
        try (BufferedReader br = new BufferedReader(new FileReader(confirmedFile))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 7) {
                    String pId = parts[1].trim();
                    String uEmail = parts[2].trim();
                    String fName = parts[3].trim();
                    String lName = parts[4].trim();
                    String phone = parts[5].trim();
                    String bDateTime = parts[6].trim();
                    String cDateTime = (parts.length > 7) ? parts[7].trim() : "Archive Legacy";

                    // Even though property is removed from active listings, we might still want to see its historical title
                    // For now, if removed, we use the ID as title or store title in the text file
                    finalizedDeals.add(new ConfirmedBookingInfo(pId, fName, lName, uEmail, phone, bDateTime, cDateTime, "Authenticated Acquisition #" + pId));
                }
            }
        } catch (Exception e) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Finalized Deals | Estately Seller</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="dashboard-container-ref">

    <jsp:include page="seller-sidebar.jsp" />

    <div class="main-ref-content">
        <header class="ref-header">
            <div>
                <h1 style="font-size: 1.75rem; font-weight: 800; color: #1e293b;">Finalized Deals</h1>
                <p style="font-size: 0.85rem; color: #64748b; font-weight: 600;">Historical Acquisition Ledger Mode</p>
            </div>
            <div style="display: flex; align-items: center; gap: 1rem;">
                <div style="text-align: right;">
                    <p style="font-size: 0.8rem; font-weight: 800; color: #1e293b;"><%= sellerEmail %></p>
                    <p style="font-size: 0.7rem; color: #10b981; font-weight: 700;">Verified Elite Seller</p>
                </div>
                <div style="width: 40px; height: 40px; background: #10b981; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.9rem;">S</div>
            </div>
        </header>

        <div class="ref-section">
            <div style="margin-bottom: 3rem;">
                <h2 class="ref-section-title" style="margin-bottom: 0.5rem;">Successful Acquisition History</h2>
                <p style="color: #64748b; font-size: 0.85rem; font-weight: 600;">A persistent record of all property transfers and approved reservations.</p>
            </div>

            <% if (finalizedDeals.isEmpty()) { %>
            <div style="padding: 10rem 2rem; background: #f8fafc; border-radius: 32px; text-align: center; border: 2px dashed #e2e8f0;">
                <div style="width: 80px; height: 80px; background: white; color: #cbd5e1; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 2.5rem; margin: 0 auto 1.5rem; box-shadow: 0 4px 6px rgba(0,0,0,0.02);">
                    <i class="fas fa-file-invoice-dollar"></i>
                </div>
                <h3 style="color: #1e293b; font-size: 1.25rem; font-weight: 800;">No Finalized Deals Discovered</h3>
                <p style="color: #64748b; margin-top: 0.5rem; font-weight: 600;">When you approve reservation requests, they will be archived here permanently.</p>
                <a href="<%= request.getContextPath() %>/pages/seller/seller-bookings.jsp" class="btn btn-primary" style="margin-top: 2rem; padding: 0.75rem 2rem; border-radius: 10px; font-size: 0.85rem;">Check Pending Reservations</a>
            </div>
            <% } else { %>
            <div style="overflow-x: auto;">
                <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="text-align: left; border-bottom: 2px solid #f8fafc;">
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Asset Marker</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Acquirer Profile</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Contact Data</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Approval Seal</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase; text-align: right;">Authorization Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (ConfirmedBookingInfo deal : finalizedDeals) { %>
                        <tr class="ref-list-item" style="display: table-row;">
                            <td style="padding: 1.5rem 1rem;">
                                <div style="font-weight: 800; color: #1e293b;"><%= deal.propertyTitle %></div>
                                <div style="font-size: 0.7rem; color: #3b82f6; font-weight: 700; margin-top: 0.25rem;">REF-ID: <%= deal.propertyId %></div>
                            </td>
                            <td style="padding: 1.5rem 1rem;">
                                <div style="display: flex; align-items: center; gap: 0.75rem;">
                                    <div style="width: 36px; height: 36px; background: #f0fdf4; color: #10b981; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 0.8rem; font-weight: 800;"><i class="fas fa-check-double"></i></div>
                                    <div>
                                        <div style="font-weight: 800; color: #1e293b; font-size: 0.9rem;"><%= deal.firstName + " " + deal.lastName %></div>
                                        <div style="font-size: 0.75rem; color: #64748b; font-weight: 600;"><%= deal.userEmail %></div>
                                    </div>
                                </div>
                            </td>
                            <td style="padding: 1.5rem 1rem;">
                                <div style="font-size: 0.85rem; color: #334155; font-weight: 700;"><i class="fas fa-phone-alt" style="color: #10b981; margin-right: 0.5rem;"></i> <%= deal.phoneNumber %></div>
                            </td>
                            <td style="padding: 1.5rem 1rem;">
                                <span style="display: inline-block; padding: 0.4rem 0.75rem; background: #f0fdf4; border-radius: 8px; font-size: 0.75rem; font-weight: 800; color: #15803d; border: 1px solid #bbf7d0;">
                                    <i class="fas fa-stamp" style="margin-right: 0.4rem;"></i> SEALED: <%= deal.bookingDateTime %>
                                </span>
                            </td>
                            <td style="padding: 1.5rem 1rem; text-align: right;">
                                <span class="ref-badge-new" style="background: #10b981; color: white; padding: 0.5rem 1.25rem; border-radius: 100px; font-size: 0.65rem;">AUTHORIZED ACQUISITION</span>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } %>
        </div>
    </div>

</body>
</html>

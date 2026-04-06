<%@ page import="java.io.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String loggedInEmail = (String) session.getAttribute("email");
    if (loggedInEmail == null) {
        response.sendRedirect(request.getContextPath() + "/pages/common/login.jsp");
        return;
    }
    String bookingFilePath = System.getProperty("catalina.home") + File.separator + "bin" + File.separator + "bookings.txt";
    String confirmedFilePath = System.getProperty("catalina.home") + File.separator + "bin" + File.separator + "confirmed_bookings.txt";
    
    File bookingFile = new File(bookingFilePath);
    File confirmedFile = new File(confirmedFilePath);
    boolean hasPending = false;
    boolean hasConfirmed = false;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Investment Portfolio | Estately</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="dashboard-container-ref">

    <jsp:include page="user-sidebar.jsp" />

    <div class="main-ref-content">
        <header class="ref-header">
            <div>
                <h1 style="font-size: 1.75rem; font-weight: 800; color: #1e293b;">My Asset Hub</h1>
                <p style="font-size: 0.85rem; color: #64748b; font-weight: 600;">Portfolio Synchronization Mode</p>
            </div>
            <div style="display: flex; align-items: center; gap: 1rem;">
                <div style="text-align: right;">
                    <p style="font-size: 0.8rem; font-weight: 800; color: #1e293b;"><%= loggedInEmail %></p>
                    <p style="font-size: 0.7rem; color: #3b82f6; font-weight: 700;">Verified Explorer</p>
                </div>
                <div style="width: 40px; height: 40px; background: #3b82f6; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.9rem;">U</div>
            </div>
        </header>

        <div class="ref-section">
            <!-- Section 1: Pending Reservations -->
            <div style="margin-bottom: 3rem;">
                <h2 class="ref-section-title" style="margin-bottom: 0.5rem;">Ongoing Reservations</h2>
                <p style="color: #64748b; font-size: 0.85rem; font-weight: 600;">Active nodes currently awaiting seller validation.</p>
            </div>

            <div class="booking-list" style="display: flex; flex-direction: column; gap: 1rem; margin-bottom: 4rem;">
                <%
                    if (bookingFile.exists()) {
                        try (BufferedReader reader = new BufferedReader(new FileReader(bookingFile))) {
                            String line;
                            while ((line = reader.readLine()) != null) {
                                String[] parts = line.split(",");
                                if (parts.length >= 7 && parts[2].trim().equalsIgnoreCase(loggedInEmail)) {
                                    hasPending = true;
                %>
                <div class="ref-list-item" style="padding: 1.5rem; display: grid; grid-template-columns: 60px 1fr 1fr 1fr 150px; align-items: center; gap: 1.5rem;">
                    <div style="width: 44px; height: 44px; background: #eff6ff; color: #3b82f6; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.25rem;">
                        <i class="fas fa-hourglass-half"></i>
                    </div>
                    <div>
                        <div style="font-weight: 800; color: #1e293b; font-size: 0.95rem;"><%= parts[1] %></div>
                        <div style="font-size: 0.7rem; color: #3b82f6; font-weight: 700; margin-top: 0.25rem;">RESERVE-ID: <%= parts[0].trim().substring(Math.max(0, parts[0].trim().length() - 8)) %></div>
                    </div>
                    <div>
                        <div style="font-size: 0.65rem; color: #64748b; text-transform: uppercase; font-weight: 800;">Timestamp</div>
                        <div style="font-weight: 700; color: #334155; font-size: 0.8rem; margin-top: 0.2rem;"><%= parts[6] %></div>
                    </div>
                    <div>
                        <div style="font-size: 0.65rem; color: #64748b; text-transform: uppercase; font-weight: 800;">Status</div>
                        <div style="margin-top: 0.2rem;"><span class="ref-badge-new" style="background: #fef9c3; color: #a16207; font-size: 0.6rem;">AWAITING SELLER</span></div>
                    </div>
                    <div style="text-align: right;">
                        <form action="<%= request.getContextPath() %>/cancelBooking" method="post" onsubmit="return confirm('Immediately abort this reservation node?');" style="display: contents;">
                            <input type="hidden" name="propertyId" value="<%= parts[1] %>">
                            <button type="submit" style="padding: 0.4rem 1rem; border-radius: 8px; border: 1px solid #fee2e2; background: transparent; color: #ef4444; font-weight: 800; font-size: 0.7rem; cursor: pointer;">CANCEL</button>
                        </form>
                    </div>
                </div>
                <%
                                }
                            }
                        } catch (IOException e) {}
                    }
                    if (!hasPending) {
                %>
                <p style="padding: 2rem; background: #f8fafc; border-radius: 16px; color: #94a3b8; font-weight: 700; text-align: center; border: 2px dashed #e2e8f0;">No active reservation nodes in transit.</p>
                <% } %>
            </div>

            <!-- Section 2: Finalized Acquisitions -->
            <div style="margin-bottom: 3rem;">
                <h2 class="ref-section-title" style="margin-bottom: 0.5rem;">Finalized Acquisitions</h2>
                <p style="color: #64748b; font-size: 0.85rem; font-weight: 600;">Assets successfully synchronized and added to your permanent portfolio.</p>
            </div>

            <div class="booking-list" style="display: flex; flex-direction: column; gap: 1rem;">
                <%
                    if (confirmedFile.exists()) {
                        try (BufferedReader reader = new BufferedReader(new FileReader(confirmedFile))) {
                            String line;
                            while ((line = reader.readLine()) != null) {
                                String[] parts = line.split(",");
                                if (parts.length >= 7 && parts[2].trim().equalsIgnoreCase(loggedInEmail)) {
                                    hasConfirmed = true;
                %>
                <div class="ref-list-item" style="padding: 1.5rem; display: grid; grid-template-columns: 60px 1fr 1fr 1fr 150px; align-items: center; gap: 1.5rem; border-left: 4px solid #10b981;">
                    <div style="width: 44px; height: 44px; background: #f0fdf4; color: #10b981; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.25rem;">
                        <i class="fas fa-check-double"></i>
                    </div>
                    <div>
                        <div style="font-weight: 800; color: #1e293b; font-size: 0.95rem;"><%= parts[1] %></div>
                        <div style="font-size: 0.7rem; color: #10b981; font-weight: 700; margin-top: 0.25rem;">FINALIZED ASSET</div>
                    </div>
                    <div>
                        <div style="font-size: 0.65rem; color: #64748b; text-transform: uppercase; font-weight: 800;">Acquisition Date</div>
                        <div style="font-weight: 700; color: #334155; font-size: 0.8rem; margin-top: 0.2rem;"><%= parts[6] %></div>
                    </div>
                    <div>
                        <div style="font-size: 0.65rem; color: #64748b; text-transform: uppercase; font-weight: 800;">Verification</div>
                        <div style="margin-top: 0.2rem;"><span class="ref-badge-new" style="background: #dcfce7; color: #15803d; font-size: 0.6rem;">SELLER APPROVED</span></div>
                    </div>
                    <div style="text-align: right;">
                        <span style="font-size: 0.7rem; font-weight: 800; color: #10b981;"><i class="fas fa-shield-alt"></i> SECURED</span>
                    </div>
                </div>
                <%
                                }
                            }
                        } catch (IOException e) {}
                    }
                    if (!hasConfirmed) {
                %>
                <p style="padding: 2rem; background: #f8fafc; border-radius: 16px; color: #94a3b8; font-weight: 700; text-align: center; border: 2px dashed #e2e8f0;">No finalized acquisitions recorded yet.</p>
                <% } %>
            </div>

        </div>
    </div>

</body>
</html>

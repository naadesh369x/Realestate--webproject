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

    String bookingFilePath = System.getProperty("catalina.home") + File.separator + "bin" + File.separator + "bookings.txt";

    class BookingInfo {
        String propertyId, firstName, lastName, userEmail, phoneNumber, bookingDateTime, propertyTitle;
        public BookingInfo(String pId, String fName, String lName, String uEmail, String phone, String dateTime, String pTitle) {
            this.propertyId = pId;
            this.firstName = fName;
            this.lastName = lName;
            this.userEmail = uEmail;
            this.phoneNumber = phone;
            this.bookingDateTime = dateTime;
            this.propertyTitle = pTitle;
        }
    }

    List<BookingInfo> sellerBookings = new ArrayList<>();
    File bookingFile = new File(bookingFilePath);
    if (bookingFile.exists()) {
        try (BufferedReader br = new BufferedReader(new FileReader(bookingFile))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 7) {
                    String propertyId = parts[1].trim();
                    String uEmail = parts[2].trim();
                    String fName = parts[3].trim();
                    String lName = parts[4].trim();
                    String phone = parts[5].trim();
                    String bookingDateTime = parts[6].trim();

                    Property prop = PropertyManager.findPropertyById(propertyId);
                    if (prop != null && (sellerEmail.equalsIgnoreCase(prop.getSellerEmail()) || "admin".equalsIgnoreCase((String)session.getAttribute("role")))) {
                        sellerBookings.add(new BookingInfo(propertyId, fName, lName, uEmail, phone, bookingDateTime, prop.getTitle()));
                    }
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
    <title>Manage Reservations | Estately</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .bookings-container {
            padding: 4rem 5%;
            max-width: 1400px;
            margin: 0 auto;
        }

        .booking-table-wrapper {
            background: white;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: var(--shadow);
            border: 1px solid #f1f5f9;
        }

        .booking-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        .booking-table th {
            background: #f8fafc;
            padding: 1.25rem 1.5rem;
            color: #64748b;
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .booking-table td {
            padding: 1.25rem 1.5rem;
            border-top: 1px solid #f1f5f9;
            color: #334155;
            vertical-align: middle;
        }

        .user-pill {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .avatar-small {
            width: 32px;
            height: 32px;
            background: #eff6ff;
            color: #3b82f6;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
        }

        .date-badge {
            display: inline-block;
            padding: 0.35rem 0.75rem;
            background: #f1f5f9;
            border-radius: 8px;
            font-size: 0.8rem;
            font-weight: 600;
            color: #475569;
        }

        .btn-confirm {
            background: #10b981;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-confirm:hover {
            background: #059669;
            transform: translateY(-1px);
        }

        .empty-state {
            padding: 5rem;
            text-align: center;
            background: white;
            border-radius: 24px;
        }
    </style>
</head>
<body class="dashboard-container-ref">

    <jsp:include page="seller-sidebar.jsp" />

    <div class="main-ref-content">
        <header class="ref-header">
            <div>
                <h1 style="font-size: 1.75rem; font-weight: 800; color: #1e293b;">Closed Deals</h1>
                <p style="font-size: 0.85rem; color: #64748b; font-weight: 600;">Reservation Node Tracking Mode</p>
            </div>
            <div style="display: flex; align-items: center; gap: 1rem;">
                <div style="text-align: right;">
                    <p style="font-size: 0.8rem; font-weight: 800; color: #1e293b;"><%= session.getAttribute("email") %></p>
                    <p style="font-size: 0.7rem; color: #3b82f6; font-weight: 700;">Verified Seller</p>
                </div>
                <div style="width: 40px; height: 40px; background: #e69a4c; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.9rem;">S</div>
            </div>
        </header>

        <div class="ref-section">
            <div style="margin-bottom: 3rem;">
                <h2 class="ref-section-title" style="margin-bottom: 0.5rem;">Reservation Requests Portfolio</h2>
                <p style="color: #64748b; font-size: 0.85rem; font-weight: 600;">Review and manage active booking requests for your properties.</p>
            </div>

            <% if (sellerBookings.isEmpty()) { %>
            <div class="empty-state" style="padding: 10rem 2rem; background: #f8fafc; border-radius: 20px; text-align: center; border: 2px dashed #e2e8f0;">
                <div style="width: 80px; height: 80px; background: white; color: #cbd5e1; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 2.5rem; margin: 0 auto 1.5rem; box-shadow: 0 4px 6px rgba(0,0,0,0.02);">
                    <i class="fas fa-calendar-times"></i>
                </div>
                <h3 style="color: #1e293b; font-size: 1.25rem; font-weight: 800;">No Booking Records Found</h3>
                <p style="color: #64748b; margin-top: 0.5rem; font-weight: 600;">When buyers reserve your properties, they will be archived here.</p>
            </div>
            <% } else { %>
            <div style="overflow-x: auto;">
                <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="text-align: left; border-bottom: 2px solid #f8fafc;">
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Asset Details</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Buyer Profile</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Connectivity</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Timestamp</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase; text-align: right;">Action Control</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (BookingInfo booking : sellerBookings) { %>
                        <tr class="ref-list-item" style="display: table-row;">
                            <td style="padding: 1.25rem 1rem;">
                                <div style="font-weight: 800; color: #1e293b;"><%= booking.propertyTitle %></div>
                                <div style="font-size: 0.7rem; color: #3b82f6; font-weight: 700; margin-top: 0.25rem;">ID: <%= booking.propertyId %></div>
                            </td>
                            <td style="padding: 1.25rem 1rem;">
                                <div style="display: flex; align-items: center; gap: 0.75rem;">
                                    <div style="width: 36px; height: 36px; background: #eff6ff; color: #3b82f6; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 0.8rem; font-weight: 800;"><i class="fas fa-user"></i></div>
                                    <div>
                                        <div style="font-weight: 800; color: #1e293b; font-size: 0.9rem;"><%= booking.firstName + " " + booking.lastName %></div>
                                        <div style="font-size: 0.75rem; color: #64748b; font-weight: 600;"><%= booking.userEmail %></div>
                                    </div>
                                </div>
                            </td>
                            <td style="padding: 1.25rem 1rem;">
                                <div style="font-size: 0.85rem; color: #334155; font-weight: 700;"><i class="fas fa-phone" style="color: #3b82f6; margin-right: 0.5rem; width: 14px;"></i> <%= booking.phoneNumber %></div>
                            </td>
                            <td style="padding: 1.25rem 1rem;">
                                <span style="display: inline-block; padding: 0.4rem 0.75rem; background: #f1f5f9; border-radius: 8px; font-size: 0.75rem; font-weight: 800; color: #475569;">
                                    <i class="far fa-clock" style="margin-right: 0.4rem;"></i> <%= booking.bookingDateTime %>
                                </span>
                            </td>
                            <td style="padding: 1.25rem 1rem; text-align: right;">
                                <form method="post" action="<%= request.getContextPath() %>/confirm-booking" style="display: contents;">
                                    <input type="hidden" name="propertyId" value="<%= booking.propertyId %>">
                                    <input type="hidden" name="userEmail" value="<%= booking.userEmail %>">
                                    <button type="submit" style="padding: 0.5rem 1.25rem; background: #10b981; color: white; border: none; border-radius: 8px; font-weight: 800; cursor: pointer; transition: all 0.3s; font-size: 0.75rem;">APPROVE</button>
                                </form>
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

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.demo.service.PropertyManager" %>
<%@ page import="com.example.demo.models.Property" %>

<%
    String propertyId = request.getParameter("propertyId");
    Property property = PropertyManager.findPropertyById(propertyId);
    String firstName = (String) session.getAttribute("firstName");
    String lastName = (String) session.getAttribute("lastName");
    String userEmail = (String) session.getAttribute("email");
    String sellerEmail = property != null ? property.getSellerEmail() : null;

    String msg = null;
    if (session.getAttribute("msg") != null) {
        msg = (String) session.getAttribute("msg");
        session.removeAttribute("msg");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Reservation | Estately</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            background: #f8fafc;
        }

        .booking-page {
            max-width: 1000px;
            margin: 4rem auto;
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 2.5rem;
        }

        .booking-form-card {
            background: white;
            padding: 3rem;
            border-radius: 32px;
            box-shadow: var(--shadow);
            border: 1px solid #f1f5f9;
        }

        .property-preview-card {
            background: white;
            padding: 2rem;
            border-radius: 28px;
            box-shadow: var(--shadow);
            height: fit-content;
            position: sticky;
            top: 100px;
        }

        .preview-img {
            width: 100%;
            height: 200px;
            border-radius: 20px;
            object-fit: cover;
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 700;
            color: #475569;
            font-size: 0.8rem;
            text-transform: uppercase;
        }

        input {
            width: 100%;
            padding: 0.875rem 1.25rem;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            background: #f8fafc;
            font-family: inherit;
            outline: none;
            transition: all 0.3s;
        }

        input[readonly] {
            background: #f1f5f9;
            color: #94a3b8;
        }

        input:focus:not([readonly]) {
            background: white;
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
            font-size: 0.9rem;
            color: #64748b;
        }

        .total-row {
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 2px dashed #f1f5f9;
            display: flex;
            justify-content: space-between;
            font-weight: 800;
            color: #1e293b;
            font-size: 1.25rem;
        }

        @media (max-width: 900px) {
            .booking-page { grid-template-columns: 1fr; padding: 1rem; }
        }
    </style>
</head>
<body>

<jsp:include page="../common/header.jsp" />

<% if (property != null && userEmail != null) { %>
<div class="booking-page">
    <!-- Form Side -->
    <div class="booking-form-card">
        <h2 style="font-size: 1.75rem; font-weight: 800; color: #1e293b; margin-bottom: 0.5rem;">Secure Your Reservation</h2>
        <p style="color: #64748b; margin-bottom: 2.5rem; font-size: 0.95rem;">Please verify your acquisition credentials to proceed.</p>

        <% if (msg != null) { %>
            <div style="background: #fef2f2; color: #ef4444; padding: 1rem; border-radius: 12px; margin-bottom: 2rem; font-size: 0.85rem;">
                <i class="fas fa-exclamation-triangle"></i> <%= msg %>
            </div>
        <% } %>

        <form method="post" action="<%= request.getContextPath() %>/add-booking">
            <input type="hidden" name="propertyId" value="<%= property.getId() %>">
            <input type="hidden" name="userEmail" value="<%= userEmail %>">
            <input type="hidden" name="sellerEmail" value="<%= sellerEmail != null ? sellerEmail : "" %>">

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                <div class="form-group">
                    <label class="form-label">Given Name</label>
                    <input type="text" name="firstName" value="<%= firstName %>" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Family Name</label>
                    <input type="text" name="lastName" value="<%= lastName %>" required>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Authenticated Account</label>
                <input type="email" value="<%= userEmail %>" readonly>
            </div>

            <div class="form-group">
                <label class="form-label">Asset Correspondent</label>
                <input type="email" value="<%= sellerEmail != null ? sellerEmail : "Registry Managed" %>" readonly>
            </div>

            <div class="form-group">
                <label class="form-label">Direct Communication Line</label>
                <div style="position: relative;">
                    <i class="fas fa-phone" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #94a3b8; font-size: 0.9rem;"></i>
                    <input type="tel" name="phoneNumber" placeholder="+94 7X XXX XXXX" required style="padding-left: 2.75rem;">
                </div>
            </div>

            <div style="margin-top: 3rem;">
                <button type="submit" class="btn btn-primary" style="width: 100%; padding: 1.25rem; font-size: 1rem; font-weight: 700;">
                    Complete Authorization
                </button>
                <p style="text-align: center; font-size: 0.75rem; color: #94a3b8; margin-top: 1rem;">
                    <i class="fas fa-shield-alt"></i> SSL SECURE RESERVATION GATEWAY
                </p>
            </div>
        </form>
    </div>

    <!-- Preview Side -->
    <div class="property-preview-card">
        <img src="<%= request.getContextPath() %>/images/<%= (property.getImageFileName() != null) ? property.getImageFileName() : "hero-bg.png" %>" class="preview-img">
        <h3 style="font-size: 1.25rem; font-weight: 800; color: #1e293b; margin-bottom: 0.25rem;"><%= property.getTitle() %></h3>
        <p style="color: #64748b; font-size: 0.85rem; margin-bottom: 1.5rem;"><i class="fas fa-map-marker-alt"></i> <%= property.getLocation() %></p>
        
        <div style="margin-top: 2rem;">
            <div class="summary-item">
                <span>Asset Valuation</span>
                <span style="font-weight: 700;">RS. <%= String.format("%,.0f", property.getPrice()) %></span>
            </div>
            <div class="summary-item">
                <span>Platform Commission</span>
                <span style="font-weight: 700; color: #10b981;">FREE</span>
            </div>
            <div class="summary-item">
                <span>Verification Status</span>
                <span style="font-weight: 700; color: #3b82f6;">GUARANTEED</span>
            </div>

            <div class="total-row">
                <span>Immediate Deposit</span>
                <span>RS. <%= String.format("%,.0f", property.getPrice()) %></span>
            </div>
        </div>

        <div style="margin-top: 2rem; padding: 1rem; background: #f8fafc; border-radius: 16px; font-size: 0.8rem; color: #94a3b8;">
            <i class="fas fa-info-circle"></i> This reservation secures your prioritization for physical inspection and final legal acquisition process.
        </div>
    </div>
</div>
<% } else { %>
<div style="height: 80vh; display: flex; align-items: center; justify-content: center; text-align: center;">
    <div>
        <i class="fas fa-search-location" style="font-size: 4rem; color: #cbd5e1; margin-bottom: 1.5rem;"></i>
        <h2 style="font-size: 1.5rem; font-weight: 800; color: #1e293b;">Session Desynchronized</h2>
        <p style="color: #64748b; margin-top: 0.5rem;">Unable to identify property asset or user credentials.</p>
        <a href="<%= request.getContextPath() %>/user-dashboard" class="btn btn-primary" style="margin-top: 2rem;">Return to Hub</a>
    </div>
</div>
<% } %>

<jsp:include page="../common/footer.jsp" />

</body>
</html>

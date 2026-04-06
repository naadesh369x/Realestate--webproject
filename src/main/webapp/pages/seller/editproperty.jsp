<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.demo.models.Property" %>
<%@ page import="com.example.demo.service.PropertyManager" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Property Asset | Estately</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            background: #f8fafc;
        }

        .edit-container {
            max-width: 900px;
            margin: 4rem auto;
            background: white;
            padding: 3.5rem;
            border-radius: 32px;
            box-shadow: var(--shadow);
        }

        .edit-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .edit-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }

        .full-span {
            grid-column: 1 / -1;
        }

        .form-label {
            display: block;
            margin-bottom: 0.75rem;
            font-weight: 700;
            color: #1e293b;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.025em;
        }

        input[type="text"],
        input[type="number"],
        select,
        textarea {
            width: 100%;
            padding: 1rem 1.25rem;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            background: #f8fafc;
            font-family: inherit;
            font-size: 1rem;
            transition: all 0.3s;
            outline: none;
        }

        input:focus, select:focus, textarea:focus {
            background: white;
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
        }

        textarea {
            height: 150px;
            resize: vertical;
        }

        .image-preview-box {
            margin-top: 1.5rem;
            padding: 1.5rem;
            background: #f1f5f9;
            border-radius: 20px;
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .preview-thumb {
            width: 120px;
            height: 80px;
            border-radius: 12px;
            object-fit: cover;
            border: 2px solid white;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
        }

        .action-row {
            margin-top: 3rem;
            display: flex;
            gap: 1.5rem;
        }

        @media (max-width: 768px) {
            .edit-grid { grid-template-columns: 1fr; }
            .edit-container { padding: 2rem; margin: 1rem; }
        }
    </style>
</head>
<body class="dashboard-container-ref">

    <jsp:include page="seller-sidebar.jsp" />

    <div class="main-ref-content">
        <header class="ref-header">
            <div>
                <h1 style="font-size: 1.75rem; font-weight: 800; color: #1e293b;">Refine Asset</h1>
                <p style="font-size: 0.85rem; color: #64748b; font-weight: 600;">Node Modification Tracking Mode</p>
            </div>
            <div style="display: flex; align-items: center; gap: 1rem;">
                <div style="text-align: right;">
                    <p style="font-size: 0.8rem; font-weight: 800; color: #1e293b;"><%= session.getAttribute("email") %></p>
                    <p style="font-size: 0.7rem; color: #3b82f6; font-weight: 700;">Verified Seller</p>
                </div>
                <div style="width: 40px; height: 40px; background: #e69a4c; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.9rem;">S</div>
            </div>
        </header>

        <%
            String propertyId = request.getParameter("id");
            PropertyManager propertyManager = new PropertyManager();
            Property property = propertyManager.findPropertyById(propertyId);

            if (property == null && propertyId != null) {
                response.sendRedirect(request.getContextPath() + "/seller-dashboard");
                return;
            }
        %>

        <div class="ref-section">
            <div style="margin-bottom: 3rem;">
                <h2 class="ref-section-title" style="margin-bottom: 0.5rem;">Asset Configuration Blueprint</h2>
                <p style="color: #64748b; font-size: 0.85rem; font-weight: 600;">Update the public narrative and technical specifications of this property.</p>
            </div>

            <form action="<%= request.getContextPath() %>/<%= (propertyId != null) ? "update-property" : "create-property" %>" method="POST" enctype="multipart/form-data">
                <% if (propertyId != null) { %>
                    <input type="hidden" name="id" value="<%= property.getId() %>">
                <% } %>

                <div class="edit-grid">
                    <div class="full-span">
                        <label class="form-label" for="title">Asset Title</label>
                        <input type="text" name="title" id="title" value="<%= (propertyId != null) ? property.getTitle() : "" %>" required>
                    </div>

                    <div>
                        <label class="form-label" for="location">Geographical Location</label>
                        <input type="text" name="location" id="location" value="<%= (propertyId != null) ? property.getLocation() : "" %>" required>
                    </div>

                    <div>
                        <label class="form-label" for="type">Categorization</label>
                        <select name="type" id="type" required>
                            <option value="House" <%= (propertyId != null && "House".equals(property.getType())) ? "selected" : "" %>>House</option>
                            <option value="Apartment" <%= (propertyId != null && "Apartment".equals(property.getType())) ? "selected" : "" %>>Apartment</option>
                            <option value="Villa" <%= (propertyId != null && "Villa".equals(property.getType())) ? "selected" : "" %>>Villa</option>
                            <option value="Bungalow" <%= (propertyId != null && "Bungalow".equals(property.getType())) ? "selected" : "" %>>Bungalow</option>
                        </select>
                    </div>

                    <div class="full-span">
                        <label class="form-label" for="description">Property Narrative</label>
                        <textarea name="description" id="description" required><%= (propertyId != null) ? property.getDescription() : "" %></textarea>
                    </div>

                    <div>
                        <label class="form-label" for="price">Valuation (RS)</label>
                        <input type="number" name="price" id="price" value="<%= (propertyId != null) ? property.getPrice() : "" %>" required step="0.01">
                    </div>

                    <div>
                        <label class="form-label" for="radius">Surface Area (sqft)</label>
                        <input type="number" name="radius" id="radius" value="<%= (propertyId != null) ? property.getRadius() : "" %>" required step="1">
                    </div>

                    <div class="full-span">
                        <label class="form-label" for="image">Visual Update (Optional)</label>
                        <input type="file" name="image" id="image" accept="image/*" style="padding: 0.5rem; background: #fff; border-radius: 12px; border: 1px solid #e2e8f0; width: 100%;">
                        
                        <% if (propertyId != null && property.getImageFileName() != null) { %>
                        <div class="image-preview-box">
                            <img src="<%= request.getContextPath() %>/images/<%= property.getImageFileName() %>" class="preview-thumb" alt="Current">
                            <div>
                                <p style="font-weight: 700; color: #1e293b; font-size: 0.9rem;">Current Asset Visual</p>
                                <p style="font-size: 0.8rem; color: #64748b; font-weight: 600;">Replacing this will permanently update the global registry.</p>
                            </div>
                        </div>
                        <% } %>
                    </div>

                    <div class="full-span">
                        <label class="form-label" for="phoneNumber">Direct Consultation Phone</label>
                        <input type="text" name="phoneNumber" id="phoneNumber" value="<%= (propertyId != null) ? property.getSellerPhone() : "" %>" required>
                    </div>
                </div>

                <div class="action-row" style="justify-content: flex-end;">
                    <a href="<%= request.getContextPath() %>/pages/seller/sellerdashboard.jsp" class="btn btn-outline" style="min-width: 140px; border-radius: 10px;">Abort Modification</a>
                    <button type="submit" class="btn btn-primary" style="min-width: 250px; border-radius: 10px;">
                        <i class="fas fa-check-circle" style="margin-right: 0.75rem;"></i> Confirmed Modification
                    </button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>

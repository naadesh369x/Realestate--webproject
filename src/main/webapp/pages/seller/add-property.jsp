<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post Property | Estately</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            background: #f8fafc;
        }

        .form-container {
            max-width: 800px;
            margin: 4rem auto;
            background: white;
            padding: 3rem;
            border-radius: 24px;
            box-shadow: var(--shadow);
        }

        .form-header {
            margin-bottom: 2.5rem;
            text-align: center;
        }

        .form-header h1 {
            font-size: 2rem;
            color: #1e293b;
            font-weight: 800;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #475569;
            font-size: 0.9rem;
        }

        input[type="text"],
        input[type="number"],
        input[type="tel"],
        select,
        textarea {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            outline: none;
            transition: all 0.3s;
            font-family: inherit;
        }

        input:focus, select:focus, textarea:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
        }

        textarea {
            height: 120px;
            resize: vertical;
        }

        .file-upload {
            border: 2px dashed #e2e8f0;
            padding: 2rem;
            border-radius: 16px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: #f8fafc;
        }

        .file-upload:hover {
            border-color: #3b82f6;
            background: #eff6ff;
        }

        .file-upload i {
            font-size: 2rem;
            color: #94a3b8;
            margin-bottom: 1rem;
        }

        .submit-section {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        @media (max-width: 640px) {
            .form-grid { grid-template-columns: 1fr; }
            .form-container { margin: 1rem; padding: 1.5rem; }
        }
    </style>
</head>
<body class="dashboard-container-ref">

    <jsp:include page="seller-sidebar.jsp" />

    <div class="main-ref-content">
        <header class="ref-header">
            <div>
                <h1 style="font-size: 1.75rem; font-weight: 800; color: #1e293b;">Initialize Asset</h1>
                <p style="font-size: 0.85rem; color: #64748b; font-weight: 600;">Node Deployment Tracking Mode</p>
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
            <div style="margin-bottom: 2.5rem;">
                <h2 class="ref-section-title" style="margin-bottom: 0.5rem;">Global Asset Configuration</h2>
                <p style="color: #64748b; font-size: 0.85rem; font-weight: 600;">Define the parameters for your new market entry.</p>
            </div>

            <form action="<%= request.getContextPath() %>/add-property" method="POST" enctype="multipart/form-data">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="id">Property ID</label>
                        <input type="text" name="id" id="id" placeholder="e.g. PROP-101" required>
                    </div>
                    <div class="form-group">
                        <label for="title">Title</label>
                        <input type="text" name="title" id="title" placeholder="e.g. Luxury 3BHK Apartment" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="location">Location</label>
                        <input type="text" name="location" id="location" placeholder="e.g. Colombo 07" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="type">Property Type</label>
                        <select name="type" id="type" required>
                            <option value="House">House</option>
                            <option value="Apartment">Apartment</option>
                            <option value="Villa">Villa</option>
                            <option value="Bungalow">Bungalow</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="price">Price (RS)</label>
                        <input type="number" name="price" id="price" placeholder="0.00" step="0.01" required>
                    </div>

                    <div class="form-group">
                        <label for="radius">Area (sqft)</label>
                        <input type="number" name="radius" id="radius" placeholder="1500" step="0.01" required>
                    </div>

                    <div class="form-group full-width">
                        <label for="description">Property Description</label>
                        <textarea name="description" id="description" placeholder="Describe the key features, amenities, and surroundings..." required></textarea>
                    </div>

                    <div class="form-group full-width">
                        <label for="sellerPhone">Contact Phone Number</label>
                        <input type="tel" name="sellerPhone" id="sellerPhone" placeholder="0771234567" required pattern="[0-9]{10}">
                    </div>

                    <div class="form-group full-width">
                        <label>Asset Media</label>
                        <div class="file-upload" onclick="document.getElementById('image').click()">
                            <i class="fas fa-cloud-upload-alt"></i>
                            <p style="font-weight: 700; color: #1e293b; font-size: 0.9rem;">Click to Upload Main Visual Binder</p>
                            <p style="font-size: 0.75rem; color: #64748b; font-weight: 600;">JPG, PNG or WEBP (Standardized Compression)</p>
                            <input type="file" name="image" id="image" accept="image/*" style="display: none;">
                        </div>
                    </div>
                </div>

                <div class="submit-section" style="justify-content: flex-end;">
                    <a href="<%= request.getContextPath() %>/pages/seller/sellerdashboard.jsp" class="btn btn-outline" style="min-width: 140px; border-radius: 10px;">Abort Node</a>
                    <button type="submit" class="btn btn-primary" style="min-width: 200px; border-radius: 10px;">Authorize Deployment</button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>

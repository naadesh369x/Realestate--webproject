<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.io.*" %>
<%@ page import="com.example.demo.models.Property" %>
<%@ page import="com.example.demo.service.PropertyManager" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Curated Favorites | Estately</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .favorites-view {
            padding: 4rem 10%;
            max-width: 1400px;
            margin: 0 auto;
        }

        .fav-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
            gap: 2.5rem;
            margin-top: 3rem;
        }

        .fav-card {
            background: white;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: var(--shadow);
            border: 1px solid #f1f5f9;
            transition: all 0.3s;
        }

        .fav-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
        }

        .image-box {
            height: 240px;
            background-size: cover;
            background-position: center;
            position: relative;
        }

        .remove-overlay {
            position: absolute;
            top: 1rem;
            right: 1rem;
        }

        .remove-btn {
            background: rgba(239, 68, 68, 0.9);
            color: white;
            border: none;
            width: 38px;
            height: 38px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s;
            backdrop-filter: blur(4px);
        }

        .remove-btn:hover {
            background: #ef4444;
            transform: scale(1.1);
        }

        .fav-content {
            padding: 1.5rem;
        }

        .empty-favorites {
            text-align: center;
            padding: 8rem 2rem;
            background: white;
            border-radius: 32px;
        }
    </style>
</head>
<body>

<jsp:include page="../common/header.jsp" />

<%
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        response.sendRedirect(request.getContextPath() + "/pages/common/login.jsp");
        return;
    }

    List<String> favIds = new ArrayList<>();
    File file = new File("favorites.txt");
    if (file.exists()) {
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 2 && parts[0].equalsIgnoreCase(userEmail)) {
                    favIds.add(parts[1].trim());
                }
            }
        } catch (Exception e) {}
    }

    List<Property> allProps = PropertyManager.getProperties();
    List<Property> favProps = new ArrayList<>();
    for (Property p : allProps) {
        if (favIds.contains(p.getId())) {
            favProps.add(p);
        }
    }
%>

<div class="favorites-view">
    <div style="display: flex; justify-content: space-between; align-items: end; margin-bottom: 2rem;">
        <div>
            <h1 style="font-size: 2.25rem; font-weight: 800; color: #1e293b;">Your Curated Sanctuary</h1>
            <p style="color: #64748b; margin-top: 0.5rem;">Explore your handpicked collection of premium property listings.</p>
        </div>
        <a href="<%= request.getContextPath() %>/user-dashboard" class="btn btn-outline" style="padding: 0.7rem 1.5rem;">
            <i class="fas fa-arrow-left" style="margin-right: 0.5rem;"></i> Back to Dashboard
        </a>
    </div>

    <% if (favProps.isEmpty()) { %>
        <div class="empty-favorites">
            <div style="width: 100px; height: 100px; background: #fef2f2; color: #ef4444; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 3rem; margin: 0 auto 2rem;">
                <i class="fas fa-heart-crack"></i>
            </div>
            <h2 style="font-size: 1.5rem; font-weight: 800; color: #1e293b;">Sanctuary is Empty</h2>
            <p style="color: #64748b; margin-top: 0.5rem; max-width: 450px; margin-left: auto; margin-right: auto;">You haven't favorited any property assets yet. Discover architectural marvels in our gallery.</p>
            <a href="user-dashboard" class="btn btn-primary" style="margin-top: 2rem; padding: 1rem 2.5rem;">Explore Listings</a>
        </div>
    <% } else { %>
        <div class="fav-grid">
            <% for (Property property : favProps) { %>
            <div class="fav-card">
                <div class="image-box" style="background-image: url('<%= request.getContextPath() %>/images/<%= (property.getImageFileName() != null) ? property.getImageFileName() : "hero-bg.png" %>');">
                    <div class="remove-overlay">
                        <form action="<%= request.getContextPath() %>/remove-favorite-property" method="post" onsubmit="return confirm('Release from favorites?');">
                            <input type="hidden" name="propertyId" value="<%= property.getId() %>">
                            <button type="submit" class="remove-btn" title="Remove from Favorites">
                                <i class="fas fa-heart"></i>
                            </button>
                        </form>
                    </div>
                    <span class="property-tag" style="position: absolute; bottom: 1rem; left: 1rem;"><%= property.getType() %></span>
                </div>
                <div class="fav-content">
                    <div style="font-size: 1.5rem; font-weight: 800; color: #3b82f6; margin-bottom: 0.25rem;">
                        RS. <%= String.format("%,.0f", property.getPrice()) %>
                    </div>
                    <h3 style="font-size: 1.25rem; font-weight: 700; color: #1e293b; margin-bottom: 0.5rem;"><%= property.getTitle() %></h3>
                    <p style="font-size: 0.9rem; color: #64748b; margin-bottom: 1.25rem;"><i class="fas fa-map-marker-alt" style="margin-right: 0.5rem; color: #3b82f6;"></i> <%= property.getLocation() %></p>
                    
                    <div style="display: flex; gap: 1.5rem; padding-top: 1.25rem; border-top: 1px solid #f1f5f9;">
                        <span style="font-size: 0.85rem; color: #475569; font-weight: 600;"><i class="fas fa-ruler-combined" style="margin-right: 0.4rem; color: #3b82f6;"></i> <%= property.getRadius() %> ft</span>
                        <span style="font-size: 0.85rem; color: #475569; font-weight: 600;"><i class="fas fa-tag" style="margin-right: 0.4rem; color: #3b82f6;"></i> <%= property.getType() %></span>
                    </div>

                    <div style="margin-top: 1.5rem;">
                        <a href="user-property-details.jsp?id=<%= property.getId() %>" class="btn btn-primary" style="width: 100%; display: block; text-align: center; padding: 0.75rem;">View Assets</a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    <% } %>
</div>

<jsp:include page="../common/footer.jsp" />

</body>
</html>

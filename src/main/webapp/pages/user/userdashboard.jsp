<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.demo.models.Property" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.demo.service.PropertyManager" %>
<%@ page import="com.example.demo.QuickSortProperty" %>

<%
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        response.sendRedirect(request.getContextPath() + "/pages/common/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exquisite Property Portfolio | Estately</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<jsp:include page="../common/header.jsp" />

<!-- Hero Section with Advanced Filters -->
<section class="dashboard-hero">
    <div class="advanced-search-container">
        <!-- Search Category Tabs -->
        <div class="search-tabs">
            <div class="search-tab active">Sales</div>

        </div>

        <!-- Main Search Row -->
        <div class="search-main-row">
            <div class="search-input-box">
                <i class="fas fa-search" style="color: #64748b; margin-right: 1rem;"></i>
                <input type="text" id="searchInput" placeholder="Type a city name or district..." onkeyup="filterShowcase()">
            </div>
            <button class="search-btn" onclick="filterShowcase()">Search</button>
        </div>

        <!-- Filter Options Row -->
        <div class="search-filters-row">
            <select class="filter-select" id="priceFilter" onchange="filterShowcase()">
                <option value="">Max Price</option>
                <option value="500000">Rs. 500k</option>
                <option value="1000000">Rs. 1M</option>
                <option value="5000000">Rs. 5M</option>
                <option value="10000000">Rs. 10M</option>
            </select>
            <select class="filter-select" id="typeFilter" onchange="filterShowcase()">
                <option value="">Property Type</option>
                <option value="House">House</option>
                <option value="Apartment">Apartment</option>
                <option value="Villa">Villa</option>
                <option value="Bungalow">Bungalow</option>
            </select>

            <select class="filter-select">
                <option value="">Radius (km)</option>
                <option value="5">5km</option>
                <option value="10">10km</option>
                <option value="20">20km</option>
            </select>
        </div>
    </div>
</section>

<!-- Showcase Section -->
<main style="padding: 5rem 8%; max-width: 1800px; margin: 0 auto;">
    <div style="text-align: center; margin-bottom: 4rem;">
        <h2 style="font-size: 2.25rem; font-weight: 300; color: #333;">Showcase Properties</h2>
        <div style="width: 60px; height: 1px; background: #e2e8f0; margin: 1.5rem auto;"></div>
    </div>

    <!-- Properties Grid -->
    <div class="detailed-grid" id="showcaseGrid">
        <%
            List<Property> properties = PropertyManager.getProperties();
            String sort = request.getParameter("sort");
            if (sort != null && !sort.isEmpty()) {
                boolean ascending = "asc".equals(sort);
                QuickSortProperty.quickSort(properties, 0, properties.size() - 1, ascending);
            }

            if (properties != null && !properties.isEmpty()) {
                for (Property property : properties) {
                    boolean isBooked = property.getBookedBy() != null && !property.getBookedBy().isEmpty();
                    boolean isUrgent = property.getPrice() > 10000000; // Simulated urgent flag
        %>
        <div class="detailed-card showcase-item"
             data-title="<%= property.getTitle().toLowerCase() %>"
             data-location="<%= property.getLocation().toLowerCase() %>"
             data-type="<%= property.getType() %>"
             data-price="<%= property.getPrice() %>">
            
            <div class="card-media" style="background-image: url('<%= request.getContextPath() %>/images/<%= (property.getImageFileName() != null && !property.getImageFileName().isEmpty()) ? property.getImageFileName() : "hero-bg.png" %>');">
                <div class="media-top">
                    <% if(isUrgent) { %>
                        <div class="urgent-label">Urgent</div>
                    <% } %>
                </div>
                <div class="media-bottom">
                    <div class="overlay-tag">

                    </div>
                    <div class="overlay-tag" style="background: rgba(0,0,0,0.8); color: white;">
                        <%= property.getLocation() %>
                    </div>
                </div>
            </div>

            <div class="card-details-body">
                <div class="specs-row">
                    <!-- Hide specs if they are zero or placeholder -->
                    <% if (property.getRadius() > 0) { %>
                        <span style="display: flex; align-items: center; gap: 0.4rem;">
                            <i class="fas fa-vector-square"></i> 
                            <%= String.format("%.0f", property.getRadius()) %> sqft
                        </span>
                    <% } %>
                    <div class="tag-badge"><%= property.getType() %></div>
                    <div style="flex: 1; text-align: right;">
                        <i class="far fa-star fav-btn-icon"></i>
                    </div>
                </div>

                <div class="listing-price">
                    Rs. <%= property.getPrice() >= 1000000 ? String.format("%.1fM", property.getPrice() / 1000000.0) : String.format("%,.0f", property.getPrice()) %>
                    <% if(isUrgent) { %>
                        <span>Negotiable</span>
                    <% } else { %>
                        <span>Total</span>
                    <% } %>
                </div>

                <h3 class="listing-title">
                    <%= (property.getTitle().length() > 5 && !property.getTitle().equals("dads")) ? property.getTitle() : "Luxury Residential Sanctuary" %>
                </h3>
                <p class="listing-loc">
                    <i class="fas fa-map-marker-alt" style="font-size: 0.7rem;"></i> 
                    <%= (property.getLocation().length() > 3 && !property.getLocation().equals("sadasd")) ? property.getLocation() : "Premium Location" %>
                </p>
                <div style="width: 100%; height: 1px; background: #f1f5f9; margin: 1rem 0;"></div>

                <div class="amenity-pill">

                </div>

                <div style="margin-top: 1.5rem;">
                    <a href="<%= request.getContextPath() %>/pages/user/user-property-details.jsp?id=<%= property.getId() %>" class="btn btn-primary" style="width: 100%; border-radius: 6px; padding: 0.8rem; font-size: 0.8rem;">View More Details</a>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <div style="grid-column: 1 / -1; text-align: center; padding: 10rem 2rem;">
            <i class="fas fa-database" style="font-size: 3rem; color: #f1f5f9; margin-bottom: 2rem;"></i>
            <h3>No properties matches your criteria</h3>
        </div>
        <% } %>
    </div>
</main>

<script>
    function filterShowcase() {
        let searchInput = document.getElementById("searchInput").value.toLowerCase();
        let typeFilter = document.getElementById("typeFilter").value;
        let priceFilter = document.getElementById("priceFilter").value;
        let items = document.querySelectorAll(".showcase-item");

        items.forEach(function(item) {
            let title = item.getAttribute("data-title");
            let loc = item.getAttribute("data-location");
            let type = item.getAttribute("data-type");
            let price = parseFloat(item.getAttribute("data-price"));

            let show = true;
            if (searchInput && !title.includes(searchInput) && !loc.includes(searchInput)) show = false;
            if (typeFilter && type !== typeFilter) show = false;
            if (priceFilter && price > parseFloat(priceFilter)) show = false;

            item.style.display = show ? "block" : "none";
        });
    }
</script>

</body>
</html>

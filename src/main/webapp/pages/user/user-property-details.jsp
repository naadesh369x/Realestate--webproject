<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.demo.models.Property" %>
<%@ page import="com.example.demo.service.PropertyManager" %>
<%@ page import="com.example.demo.service.MediaService" %>
<%@ page import="com.example.demo.models.Media" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.demo.models.Comment" %>
<%@ page import="com.example.demo.service.CommentManager" %>

<%
    String propertyId = request.getParameter("id");
    PropertyManager propertyManager = new PropertyManager();
    Property property = PropertyManager.findPropertyById(propertyId);

    // Fallback Mock for Demo if ID=103 is requested specifically but missing from DB
    if (property == null && "103".equals(propertyId)) {
        property = new Property("103", "Skyward Glass Pavilion", "Matara, Southern Coast", 160000000, "Villa", "An architectural masterpiece offering unparalleled views of the Indian Ocean. Features floor-to-ceiling glass walls, a private infinity pool, and a custom Italian kitchen.", 4200, "hero-bg.png", "+94 77 123 4567");
    }

    if (property == null) {
        response.sendRedirect(request.getContextPath() + "/pages/user/userdashboard.jsp");
        return;
    }

    MediaService mediaService = new MediaService();
    List<Media> mediaList = new ArrayList<>();
    try {
        mediaList = mediaService.getMediaByPropertyId(Integer.parseInt(propertyId));
    } catch(Exception e) {}
    
    List<Comment> comments = new ArrayList<>();
    try {
        comments = CommentManager.getCommentsByPropertyId(propertyId);
    } catch(Exception e) {}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= property.getTitle() %> | Estately Portfolio</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .property-hero {
            height: 70vh;
            position: relative;
            background: linear-gradient(rgba(0,0,0,0.1), rgba(0,0,0,0.4)), url('<%= request.getContextPath() %>/images/<%= (property.getImageFileName() != null) ? property.getImageFileName() : "hero-bg.png" %>') center/cover;
            display: flex;
            align-items: flex-end;
            padding: 4rem 10%;
        }

        .hero-info {
            color: white;
            z-index: 2;
        }

        .hero-info h1 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            text-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }

        .hero-loc-tag {
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(8px);
            padding: 0.5rem 1.5rem;
            border-radius: 100px;
            font-weight: 700;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .details-grid-layout {
            display: grid;
            grid-template-columns: 1fr 380px;
            gap: 4rem;
            padding: 4rem 10%;
            max-width: 1800px;
            margin: 0 auto;
        }

        .info-card {
            background: white;
            padding: 3rem;
            border-radius: 24px;
            margin-bottom: 2.5rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.02);
            border: 1px solid #f1f5f9;
        }

        .modern-specs-bar {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
            margin: 3rem 0;
            padding: 2rem 0;
            border-top: 1px solid #f1f5f9;
            border-bottom: 1px solid #f1f5f9;
        }

        .modern-spec-item {
            text-align: center;
        }

        .modern-spec-item i {
            font-size: 1.5rem;
            color: var(--primary);
            margin-bottom: 1rem;
            display: block;
        }

        .modern-spec-item span:first-of-type {
            font-size: 0.7rem;
            color: var(--text-muted);
            text-transform: uppercase;
            font-weight: 800;
            display: block;
            margin-bottom: 0.25rem;
        }

        .modern-spec-item span:last-of-type {
            font-size: 1.1rem;
            font-weight: 800;
            color: var(--text-main);
        }

        .floating-booking {
            position: sticky;
            top: 100px;
            background: white;
            padding: 2.5rem;
            border-radius: 28px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            border: 1px solid #f1f5f9;
        }

        .price-banner {
            background: #eff6ff;
            padding: 1.5rem;
            border-radius: 18px;
            margin-bottom: 2rem;
        }

        .media-scroll {
            display: flex;
            gap: 1.5rem;
            overflow-x: auto;
            padding-bottom: 1rem;
            scrollbar-width: none;
        }

        .media-box {
            flex: 0 0 320px;
            height: 200px;
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid #f1f5f9;
        }

        .media-box img, .media-box video {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .amenity-grid-detailed {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-top: 2rem;
        }

        .amenity-row {
            display: flex;
            align-items: center;
            gap: 1rem;
            color: var(--text-main);
            font-weight: 700;
            font-size: 0.9rem;
        }

        .dot-green {
            width: 8px;
            height: 8px;
            background: #10b981;
            border-radius: 50%;
        }

    </style>
    <script>
        function updateStars(rating) {
            const stars = document.querySelectorAll('#interaction-hub .fa-star');
            stars.forEach((star, index) => {
                if (index < rating) {
                    star.classList.remove('far');
                    star.classList.add('fas');
                } else {
                    star.classList.remove('fas');
                    star.classList.add('far');
                }
            });
        }
    </script>
</head>
<body>

<jsp:include page="../common/header.jsp" />

<div class="property-hero">
    <div class="hero-info">
        <div class="hero-loc-tag">
            <i class="fas fa-location-dot"></i> <%= property.getLocation() %>
        </div>
        <h1><%= property.getTitle() %></h1>
        <div style="font-size: 1.25rem; font-weight: 700; letter-spacing: 1px;">
            <span style="color: #10b981;">●</span> Available for Immediate Transfer
        </div>
    </div>
</div>

<div class="details-grid-layout">
    <div class="main-column">
        <div class="info-card">
            <h3 style="font-size: 1.75rem; margin-bottom: 1.5rem;">Asset Description</h3>
            <p style="color: var(--text-muted); line-height: 1.8; font-size: 1.1rem; font-weight: 500;">
                <%= property.getDescription() %>
            </p>

            <div class="modern-specs-bar">
                <div class="modern-spec-item">
                    <i class="fas fa-vector-square"></i>
                    <span>Dimensions</span>
                    <span><%= String.format("%.0f", property.getRadius()) %> SQFT</span>
                </div>
                <div class="modern-spec-item">
                    <i class="fas fa-layer-group"></i>
                    <span>Category</span>
                    <span><%= property.getType() %></span>
                </div>
                <div class="modern-spec-item">
                    <i class="fas fa-shield-halved"></i>
                    <span>Status</span>
                    <span>VERIFIED</span>
                </div>
            </div>

            <h4 style="margin-bottom: 1.5rem;">Elite Amenities</h4>
            <div class="amenity-grid-detailed">
                <div class="amenity-row"><div class="dot-green"></div> Intelligent Climate System</div>
                <div class="amenity-row"><div class="dot-green"></div> Private Infinity Pool</div>
                <div class="amenity-row"><div class="dot-green"></div> Custom Italian Kitchen</div>
                <div class="amenity-row"><div class="dot-green"></div> 24/7 Concierge Ready</div>
            </div>
        </div>

        <div class="info-card">
            <h3 style="font-size: 1.5rem; margin-bottom: 2rem;">Gallery Perspective</h3>
            <div class="media-scroll">
                <% if (mediaList != null && !mediaList.isEmpty()) {
                    for (Media media : mediaList) { %>
                    <div class="media-box">
                        <% if (media.getUrl().matches(".*\\.(mp4|webm)$")) { %>
                            <video muted onmouseover="this.play()" onmouseout="this.pause()"><source src="<%= media.getUrl() %>"></video>
                        <% } else { %>
                            <img src="<%= media.getUrl() %>" alt="Perspective">
                        <% } %>
                    </div>
                <% } } else { %>
                    <p style="color: var(--text-muted); font-style: italic;">Panoramic media loading...</p>
                <% } %>
            </div>
        </div>

        <div class="info-card" id="interaction-hub">
            <h3 style="font-size: 1.5rem; margin-bottom: 2rem;">Acquisition Interaction Hub</h3>
            
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 3rem;">
                <!-- Integrated Comment Form -->
                <div>
                    <h4 style="font-size: 1rem; color: #1e293b; margin-bottom: 1.5rem; text-transform: uppercase; letter-spacing: 1px;">Leave Resident Insight</h4>
                    <form action="<%= request.getContextPath() %>/SubmitCommentServlet" method="post">
                         <input type="hidden" name="propertyId" value="<%= propertyId %>">
                         <input type="hidden" name="userEmail" value="<%= session.getAttribute("email") %>">
                         
                         <div style="margin-bottom: 1.5rem;">
                             <label style="font-size: 0.75rem; font-weight: 800; color: #64748b; text-transform: uppercase;">Rating Metric</label>
                             <div style="display: flex; gap: 0.5rem; margin-top: 0.5rem; color: #fbbf24; font-size: 1.25rem;">
                                 <input type="hidden" name="rating" id="ratingInput" value="5">
                                 <i class="fas fa-star" onclick="document.getElementById('ratingInput').value=1; updateStars(1)"></i>
                                 <i class="fas fa-star" onclick="document.getElementById('ratingInput').value=2; updateStars(2)"></i>
                                 <i class="fas fa-star" onclick="document.getElementById('ratingInput').value=3; updateStars(3)"></i>
                                 <i class="fas fa-star" onclick="document.getElementById('ratingInput').value=4; updateStars(4)"></i>
                                 <i class="fas fa-star" onclick="document.getElementById('ratingInput').value=5; updateStars(5)"></i>
                             </div>
                         </div>
                         
                         <textarea name="commentText" placeholder="Describe your perspective..." required style="width: 100%; height: 100px; padding: 1rem; border-radius: 12px; border: 1px solid #f1f5f9; background: #f8fafc; font-family: inherit; resize: none; outline: none; transition: border 0.3s;"></textarea>
                         <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem; border-radius: 10px; padding: 0.8rem; font-size: 0.85rem;">Publish Insight</button>
                    </form>
                </div>

                <!-- Integrated Inquiry Form -->
                <div style="border-left: 1px solid #f1f5f9; padding-left: 3rem;">
                    <h4 style="font-size: 1rem; color: #1e293b; margin-bottom: 1.5rem; text-transform: uppercase; letter-spacing: 1px;">Direct Asset Inquiry</h4>
                    <form action="<%= request.getContextPath() %>/inquiry" method="post">
                        <input type="hidden" name="propertyId" value="<%= propertyId %>">
                        <input type="hidden" name="userEmail" value="<%= session.getAttribute("email") %>">
                        <input type="hidden" name="userName" value="<%= session.getAttribute("firstName") %>">
                        
                        <textarea name="message" placeholder="State your clarify intent or asset questions..." required style="width: 100%; height: 125px; padding: 1rem; border-radius: 12px; border: 1px solid #f1f5f9; background: #f8fafc; font-family: inherit; resize: none; outline: none; transition: border 0.3s;"></textarea>
                        <button type="submit" class="btn btn-outline" style="width: 100%; margin-top: 1rem; border-radius: 10px; padding: 0.8rem; font-size: 0.85rem;">Dispatch Inquiry</button>
                    </form>
                </div>
            </div>
        </div>

        <div class="info-card">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2.5rem;">
                <h3>Resident Sentiment</h3>
                <a href="#interaction-hub" class="btn btn-outline" style="padding: 0.6rem 1.5rem; font-size: 0.85rem;">Share Experience</a>
            </div>
            <% if (comments != null && !comments.isEmpty()) {
                for (Comment c : comments) { %>
                <div style="padding: 1.5rem 0; border-bottom: 1px solid #f1f5f9;">
                    <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                        <strong style="font-size: 1rem;"><%= c.getUserEmail() %></strong>
                        <div style="color: #fbbf24; font-size: 0.8rem;">
                            <% for(int i=1; i<=5; i++) { %><i class="<%= i <= c.getRating() ? "fas" : "far" %> fa-star"></i><% } %>
                        </div>
                    </div>
                    <p style="color: var(--text-muted); font-weight: 500;"><%= c.getText() %></p>
                </div>
            <% } } else { %>
                <div style="text-align: center; padding: 3rem;">
                    <p style="color: var(--text-muted); font-weight: 700;">No testimonials found yet.</p>
                </div>
            <% } %>
        </div>
    </div>

    <div class="sidebar-column">
        <div class="floating-booking">
            <%
                String bookingStatus = request.getParameter("bookingStatus");
                boolean isAlreadyBooked = false;
                String loggedInEmail = (String) session.getAttribute("email");
                if (loggedInEmail != null) {
                    com.example.demo.service.BookingManager bm = new com.example.demo.service.BookingManager();
                    isAlreadyBooked = bm.isPropertyBookedByUser(propertyId, loggedInEmail);
                }

                if ("SUCCESS".equals(bookingStatus)) {
            %>
            <div style="background: #f0fdf4; color: #166534; padding: 1.5rem; border-radius: 18px; margin-bottom: 2rem; border: 1px solid #bbf7d0; display: flex; flex-direction: column; gap: 0.5rem; text-align: center;">
                <i class="fas fa-check-circle" style="font-size: 2rem;"></i>
                <div style="font-weight: 800; font-size: 1.1rem;">Asset Reserved</div>
                <div style="font-size: 0.8rem; font-weight: 600;">Your acquisition request has been formalized in the portfolio.</div>
            </div>
            <% } else if (isAlreadyBooked) { %>
            <div style="background: #eff6ff; color: #1e40af; padding: 1.5rem; border-radius: 18px; margin-bottom: 2rem; border: 1px solid #bfdbfe; display: flex; flex-direction: column; gap: 0.5rem; text-align: center;">
                <i class="fas fa-shield-check" style="font-size: 2rem;"></i>
                <div style="font-weight: 800; font-size: 1.1rem;">In Portfolio</div>
                <div style="font-size: 0.8rem; font-weight: 600;">This asset node is already synchronized with your account.</div>
            </div>
            <% } %>

            <div class="price-banner">
                <span style="font-size: 0.8rem; font-weight: 800; color: var(--primary); text-transform: uppercase;">Ownership Investment</span>
                <div style="font-size: 2rem; font-weight: 800; color: var(--secondary); margin-top: 0.5rem;">
                    RS. <%= String.format("%,.0f", property.getPrice()) %>
                </div>
                <p style="font-size: 0.75rem; color: var(--text-muted); margin-top: 0.25rem;">Includes full administrative verification</p>
            </div>
            
            <% if (isAlreadyBooked) { %>
                <button disabled class="btn" style="width: 100%; border-radius: 12px; padding: 1.25rem; font-size: 1.1rem; background: #e2e8f0; color: #94a3b8; cursor: not-allowed; font-weight: 800;">ALREADY RESERVED</button>
                <a href="<%= request.getContextPath() %>/pages/user/view-bookings.jsp" class="btn btn-outline" style="width: 100%; border-radius: 12px; padding: 1rem; margin-top: 1rem; font-size: 0.9rem;">View My Portfolio</a>
            <% } else { %>
                <a href="<%= request.getContextPath() %>/pages/user/book-property.jsp?propertyId=<%= propertyId %>" class="btn btn-primary" style="width: 100%; border-radius: 12px; padding: 1.25rem; font-size: 1.1rem;">Submit Acquisition</a>
                <a href="<%= request.getContextPath() %>/pages/user/inquiry.jsp?propertyId=<%= propertyId %>" class="btn btn-outline" style="width: 100%; border-radius: 12px; padding: 1.25rem; margin-top: 0.75rem;">Digital Inquiry</a>
            <% } %>

            <div style="margin-top: 3rem; padding-top: 2.5rem; border-top: 1px solid #f1f5f9;">
                <p style="font-size: 0.85rem; font-weight: 800; color: var(--text-muted); margin-bottom: 1.5rem; text-transform: uppercase;">Portfolio Management</p>
                <div style="display: flex; align-items: center; gap: 1rem;">
                    <div style="width: 48px; height: 48px; background: #f8fafc; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: var(--primary);">
                        <i class="fas fa-user-tie"></i>
                    </div>
                    <div>
                        <p style="font-weight: 800; color: var(--text-main);">Portfolio Specialist</p>
                        <p style="font-size: 0.85rem; color: var(--primary); font-weight: 700;"><%= property.getSellerPhone() != null ? property.getSellerPhone() : "+94 11 000 0000" %></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />

</body>
</html>

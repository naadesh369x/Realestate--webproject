<%@ page import="java.util.*, java.io.*" %>
<%@ page import="com.example.demo.models.Property" %>
<%@ page import="com.example.demo.service.PropertyManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Active Negotiations | Estately Seller</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="dashboard-container-ref">

    <%
        String sellerEmail = (String) session.getAttribute("email");
        if (sellerEmail == null) {
            response.sendRedirect(request.getContextPath() + "/pages/common/login.jsp");
            return;
        }
    %>

    <jsp:include page="seller-sidebar.jsp" />

    <div class="main-ref-content">
        <header class="ref-header">
            <div>
                <h1 style="font-size: 1.75rem; font-weight: 800; color: #1e293b;">Active Negotiations</h1>
                <p style="font-size: 0.85rem; color: #64748b; font-weight: 600;">Secure Outbound Communication Mode</p>
            </div>
            <div style="display: flex; align-items: center; gap: 1rem;">
                <div style="text-align: right;">
                    <p style="font-size: 0.8rem; font-weight: 800; color: #1e293b;"><%= sellerEmail %></p>
                    <p style="font-size: 0.7rem; color: #3b82f6; font-weight: 700;">Verified Seller</p>
                </div>
                <div style="width: 40px; height: 40px; background: #e69a4c; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.9rem;">S</div>
            </div>
        </header>

        <div class="ref-section">
            <div style="margin-bottom: 3rem;">
                <h2 class="ref-section-title" style="margin-bottom: 0.5rem;">Dialogue Registry</h2>
                <p style="color: #64748b; font-size: 0.85rem; font-weight: 600;">Secure, end-to-end communication history with potential property explorers.</p>
            </div>

            <div class="chat-container" style="display: flex; flex-direction: column; gap: 2rem;">
                <%
                    String filePath = "replies.txt"; 
                    File file = new File(filePath);
                    boolean hasMessages = false;
                    PropertyManager propertyManager = new PropertyManager();

                    if (file.exists()) {
                        BufferedReader reader = new BufferedReader(new FileReader(file));
                        String line;
                        String propertyId = "", userName = "", userEmail = "", message = "", reply = "";
                        while ((line = reader.readLine()) != null) {
                            if (line.startsWith("Property ID:")) propertyId = line.substring(12).trim();
                            else if (line.startsWith("User Name:")) userName = line.substring(10).trim();
                            else if (line.startsWith("Email:")) userEmail = line.substring(6).trim();
                            else if (line.startsWith("Message:")) message = line.substring(8).trim();
                            else if (line.startsWith("Reply:")) reply = line.substring(7).trim();
                            else if (line.startsWith("----")) {
                                // Check if this property belongs to the current seller
                                Property property = propertyManager.findPropertyById(propertyId);
                                if (property != null && (property.getSellerEmail().equalsIgnoreCase(sellerEmail) || "admin".equalsIgnoreCase((String)session.getAttribute("role")))) {
                                    hasMessages = true;
                %>
                <div class="chat-thread" style="background: white; padding: 2.5rem; border-radius: 24px; border: 1px solid #f1f5f9; box-shadow: 0 4px 6px rgba(0,0,0,0.02); position: relative;">
                    <div style="position: absolute; top: 1.5rem; right: 2.5rem; background: #eff6ff; color: #3b82f6; padding: 0.4rem 0.8rem; border-radius: 8px; font-size: 0.7rem; font-weight: 800; border: 1px solid #dbeafe;">
                        ASSET ID: #AST-<%= propertyId %>
                    </div>

                    <div style="display: flex; gap: 1.5rem; margin-bottom: 2rem;">
                        <div style="width: 44px; height: 44px; background: #f8fafc; color: #64748b; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.1rem; border: 1px solid #e2e8f0; flex-shrink: 0;"><i class="fas fa-user-circle"></i></div>
                        <div>
                            <span style="color: #64748b; font-size: 0.65rem; font-weight: 800; text-transform: uppercase; letter-spacing: 0.05em; display: block; margin-bottom: 0.4rem;">INCOMING INQUIRY | <%= userName %></span>
                            <p style="color: #475569; line-height: 1.6; font-size: 0.95rem; font-weight: 600; font-style: italic;">"<%= message %>"</p>
                        </div>
                    </div>

                    <div style="display: flex; gap: 1.5rem; padding-top: 2rem; border-top: 1px dashed #e2e8f0;">
                        <div style="width: 44px; height: 44px; background: #3b82f6; color: white; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.1rem; flex-shrink: 0;"><i class="fas fa-reply-all"></i></div>
                        <div>
                            <span style="color: #3b82f6; font-size: 0.65rem; font-weight: 800; text-transform: uppercase; letter-spacing: 0.05em; display: block; margin-bottom: 0.4rem;">YOUR AUTHORIZED RESPONSE</span>
                            <p style="color: #1e293b; line-height: 1.6; font-size: 1rem; font-weight: 700;"><%= reply %></p>
                        </div>
                    </div>
                    
                    <div style="margin-top: 2rem; display: flex; gap: 1rem; align-items: center;">
                        <div style="font-size: 0.75rem; color: #94a3b8; font-weight: 600;">Correspondent Status:</div>
                        <span class="ref-badge-new" style="background: #f0fdf4; color: #166534;">COMMUNICATION ARCHIVED</span>
                    </div>
                </div>
                <%
                                }
                                propertyId = userName = userEmail = message = reply = "";
                            }
                        }
                        reader.close();
                    }

                    if (!hasMessages) {
                %>
                <div style="text-align: center; padding: 10rem 2rem; background: #f8fafc; border-radius: 32px; border: 2px dashed #e2e8f0;">
                    <div style="width: 80px; height: 80px; background: white; color: #cbd5e1; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 2.5rem; margin: 0 auto 1.5rem; box-shadow: 0 4px 6px rgba(0,0,0,0.02);">
                        <i class="fas fa-comments-slash"></i>
                    </div>
                    <h3 style="font-size: 1.25rem; font-weight: 800; color: #1e293b;">No Outbound Dialogues Discovered</h3>
                    <p style="color: #64748b; margin-top: 0.5rem; font-weight: 600;">When you authorize responses to buyer inquiries, they will be indexed here.</p>
                    <a href="<%= request.getContextPath() %>/pages/seller/viewinquiries.jsp" class="btn btn-primary" style="margin-top: 2rem; padding: 0.75rem 2.5rem; border-radius: 10px; font-size: 0.85rem;">Review Pending Inquiries</a>
                </div>
                <% } %>
            </div>
        </div>
    </div>

</body>
</html>

<%@ page import="java.util.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inbox | Estately Communications</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .message-view {
            padding: 4rem 10%;
            max-width: 1400px;
            margin: 0 auto;
        }

        .chat-container {
            display: flex;
            flex-direction: column;
            gap: 2rem;
            margin-top: 3rem;
        }

        .chat-thread {
            background: white;
            padding: 2.5rem;
            border-radius: 28px;
            box-shadow: var(--shadow);
            border: 1px solid #f1f5f9;
            position: relative;
        }

        .message-node {
            display: flex;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .message-node:last-child {
            margin-bottom: 0;
            padding-top: 2rem;
            border-top: 1px dashed #e2e8f0;
        }

        .icon-bubble {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            flex-shrink: 0;
        }

        .user-icon { background: #eff6ff; color: #3b82f6; }
        .seller-icon { background: #f0fdf4; color: #10b981; }

        .text-content {
            flex-grow: 1;
        }

        .label-text {
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: 0.5rem;
            display: block;
        }

        .body-text {
            color: #334155;
            line-height: 1.6;
            font-size: 1rem;
        }

        .empty-inbox {
            text-align: center;
            padding: 6rem;
            background: white;
            border-radius: 30px;
        }
    </style>
</head>
<body class="dashboard-container-ref">

    <%
        String currentUserEmail = (String) session.getAttribute("email");
        if (currentUserEmail == null) {
            response.sendRedirect(request.getContextPath() + "/pages/common/login.jsp");
            return;
        }
    %>

    <jsp:include page="user-sidebar.jsp" />

    <div class="main-ref-content">
        <header class="ref-header">
            <div>
                <h1 style="font-size: 1.75rem; font-weight: 800; color: #1e293b;">Asset Consultations</h1>
                <p style="font-size: 0.85rem; color: #64748b; font-weight: 600;">Secure Messaging Tracking Mode</p>
            </div>
            <div style="display: flex; align-items: center; gap: 1rem;">
                <div style="text-align: right;">
                    <p style="font-size: 0.8rem; font-weight: 800; color: #1e293b;"><%= currentUserEmail %></p>
                    <p style="font-size: 0.7rem; color: #3b82f6; font-weight: 700;">Verified Explorer</p>
                </div>
                <div style="width: 40px; height: 40px; background: #3b82f6; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.9rem;">U</div>
            </div>
        </header>

        <div class="ref-section">
            <div style="margin-bottom: 3rem;">
                <h2 class="ref-section-title" style="margin-bottom: 0.5rem;">Dialogue Archive</h2>
                <p style="color: #64748b; font-size: 0.85rem; font-weight: 600;">Secure, end-to-end communication history with professional property owners.</p>
            </div>

            <div class="chat-container" style="display: flex; flex-direction: column; gap: 1.5rem;">
                <%
                    String filePath = "replies.txt"; 
                    File file = new File(filePath);
                    boolean hasMessages = false;
                    if (file.exists()) {
                        BufferedReader reader = new BufferedReader(new FileReader(file));
                        String line;
                        String email = "", message = "", reply = "";
                        while ((line = reader.readLine()) != null) {
                            if (line.startsWith("Email:")) email = line.substring(6).trim();
                            else if (line.startsWith("Message:")) message = line.substring(8).trim();
                            else if (line.startsWith("Reply:")) reply = line.substring(6).trim();
                            else if (line.startsWith("----")) {
                                if (email.equalsIgnoreCase(currentUserEmail)) {
                                    hasMessages = true;
                %>
                <div class="chat-thread" style="background: #f8fafc; padding: 2rem; border-radius: 20px; border: 1px solid #e2e8f0; position: relative;">
                    <div class="message-node" style="display: flex; gap: 1rem; margin-bottom: 1.5rem;">
                        <div class="icon-bubble user-icon" style="width: 36px; height: 36px; background: white; color: #3b82f6; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 0.9rem; border: 1px solid #e2e8f0;"><i class="fas fa-paper-plane"></i></div>
                        <div class="text-content">
                            <span class="label-text" style="color: #3b82f6; font-size: 0.65rem; font-weight: 800; text-transform: uppercase; margin-bottom: 0.4rem; display: block;">YOUR INITIAL INQUIRY</span>
                            <p class="body-text" style="color: #475569; line-height: 1.6; font-size: 0.9rem; font-weight: 600;"><%= message %></p>
                        </div>
                    </div>
                    <div class="message-node" style="display: flex; gap: 1rem; padding-top: 1.5rem; border-top: 1px dashed #cbd5e1;">
                        <div class="icon-bubble seller-icon" style="width: 36px; height: 36px; background: #3b82f6; color: white; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 0.9rem;"><i class="fas fa-comment-dots"></i></div>
                        <div class="text-content">
                            <span class="label-text" style="color: #1e293b; font-size: 0.65rem; font-weight: 800; text-transform: uppercase; margin-bottom: 0.4rem; display: block;">OFFICIAL SELLER RESPONSE</span>
                            <p class="body-text" style="color: #1e293b; line-height: 1.6; font-size: 0.95rem; font-weight: 700;"><%= reply %></p>
                        </div>
                    </div>
                </div>
                <%
                                }
                                email = message = reply = "";
                            }
                        }
                        reader.close();
                    }

                    if (!hasMessages) {
                %>
                <div class="empty-inbox" style="text-align: center; padding: 10rem 2rem; background: #f8fafc; border-radius: 20px; border: 2px dashed #e2e8f0;">
                    <div style="width: 80px; height: 80px; background: white; color: #cbd5e1; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 2.5rem; margin: 0 auto 1.5rem; box-shadow: 0 4px 6px rgba(0,0,0,0.02);">
                        <i class="fas fa-comments-slash"></i>
                    </div>
                    <h3 style="font-size: 1.25rem; font-weight: 800; color: #1e293b;">Silence in the Portfolio</h3>
                    <p style="color: #64748b; margin-top: 0.5rem; font-weight: 600;">When sellers acknowledge your deployment inquiries, their advice will be archived here.</p>
                </div>
                <% } %>
            </div>
        </div>
    </div>

</body>
</html>

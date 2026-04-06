<%@ page import="java.util.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inquiry Management | Estately</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .inquiry-view {
            padding: 4rem 5%;
            max-width: 1400px;
            margin: 0 auto;
        }

        .data-card {
            background: white;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: var(--shadow);
            border: 1px solid #f1f5f9;
        }

        .inquiry-table {
            width: 100%;
            border-collapse: collapse;
        }

        .inquiry-table th {
            text-align: left;
            background: #f8fafc;
            padding: 1.25rem 1.5rem;
            color: #64748b;
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
        }

        .inquiry-table td {
            padding: 1.5rem;
            border-top: 1px solid #f1f5f9;
            vertical-align: top;
        }

        .message-bubble {
            background: #f1f5f9;
            padding: 1rem;
            border-radius: 12px;
            font-size: 0.9rem;
            color: #334155;
            max-width: 400px;
            line-height: 1.5;
        }

        .reply-area {
            width: 100%;
            min-height: 80px;
            padding: 0.75rem;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            font-family: inherit;
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
            outline: none;
            transition: all 0.3s;
        }

        .reply-area:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .status-pill {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 700;
            background: #fef3c7;
            color: #92400e;
        }

        @media (max-width: 1024px) {
            .inquiry-table th, .inquiry-table td { padding: 1rem; }
        }
    </style>
</head>
<body class="dashboard-container-ref">

    <jsp:include page="seller-sidebar.jsp" />

    <div class="main-ref-content">
        <header class="ref-header">
            <div>
                <h1 style="font-size: 1.75rem; font-weight: 800; color: #1e293b;">Negotiations</h1>
                <p style="font-size: 0.85rem; color: #64748b; font-weight: 600;">Inquiry Intelligence Tracking Mode</p>
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
                <h2 class="ref-section-title" style="margin-bottom: 0.5rem;">Global Consultation Registry</h2>
                <p style="color: #64748b; font-size: 0.85rem; font-weight: 600;">Respond to potential buyers and manage asset consultations.</p>
            </div>

            <%
                String msg = request.getParameter("message");
                if (msg != null) {
            %>
            <div style="background: #f0fdf4; color: #166534; padding: 1rem; border-radius: 12px; margin-bottom: 2rem; display: flex; align-items: center; gap: 0.75rem; font-size: 0.85rem; font-weight: 700;">
                <i class="fas fa-check-circle"></i> <%= msg %>
            </div>
            <% } %>

            <div style="overflow-x: auto;">
                <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="text-align: left; border-bottom: 2px solid #f8fafc;">
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Asset ID</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Correspondent</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Message Content</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase;">Status</th>
                            <th style="padding: 1rem; color: #64748b; font-size: 0.75rem; text-transform: uppercase; text-align: right;">Authorization</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String filePath = "inquiries.txt"; 
                            File file = new File(filePath);
                            boolean found = false;
                            if (file.exists()) {
                                BufferedReader reader = new BufferedReader(new FileReader(file));
                                String line;
                                String propertyId = "", userName = "", email = "", messageText = "";
                                while ((line = reader.readLine()) != null) {
                                    if (line.startsWith("Property ID:")) propertyId = line.substring(12).trim();
                                    else if (line.startsWith("User Name:")) userName = line.substring(10).trim();
                                    else if (line.startsWith("Email:")) email = line.substring(6).trim();
                                    else if (line.startsWith("Message:")) messageText = line.substring(8).trim();
                                    else if (line.startsWith("----")) {
                                        found = true;
                        %>
                        <tr class="ref-list-item" style="display: table-row;">
                            <td style="padding: 1.5rem 1rem; font-weight: 800; color: #3b82f6;">#AST-<%= propertyId %></td>
                            <td style="padding: 1.5rem 1rem;">
                                <div style="font-weight: 800; color: #1e293b; font-size: 0.9rem;"><%= userName %></div>
                                <div style="font-size: 0.75rem; color: #64748b; font-weight: 600;"><%= email %></div>
                            </td>
                            <td style="padding: 1.5rem 1rem;">
                                <div class="message-bubble" style="background: #f8fafc; padding: 1rem; border-radius: 12px; font-size: 0.85rem; color: #475569; border: 1px solid #f1f5f9; line-height: 1.6; font-weight: 600;">
                                    <%= messageText %>
                                </div>
                            </td>
                            <td style="padding: 1.5rem 1rem;">
                                <span class="ref-badge-new" style="background: #fef3c7; color: #92400e;">PENDING</span>
                            </td>
                            <td style="padding: 1.5rem 1rem; text-align: right; min-width: 320px;">
                                <form action="<%= request.getContextPath() %>/ReplyInquiryServlet" method="post" style="display: block;">
                                    <input type="hidden" name="propertyId" value="<%= propertyId %>">
                                    <input type="hidden" name="userName" value="<%= userName %>">
                                    <input type="hidden" name="email" value="<%= email %>">
                                    <textarea name="reply" class="reply-area" style="width: 100%; min-height: 80px; padding: 0.75rem; border-radius: 10px; border: 1px solid #e2e8f0; font-family: inherit; font-size: 0.8rem; margin-bottom: 0.5rem; outline: none; background: #f8fafc; font-weight: 600;" placeholder="Draft your professional response..." required></textarea>
                                    <button type="submit" class="btn btn-primary" style="padding: 0.5rem 1.25rem; font-size: 0.75rem; width: 100%; border-radius: 8px;">
                                        <i class="fas fa-reply" style="margin-right: 0.5rem;"></i> AUTHORIZE RESPONSE
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <%
                                    }
                                }
                                reader.close();
                            }
                            if (!found) {
                        %>
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 8rem 2rem; color: #94a3b8;">
                                <div style="width: 80px; height: 80px; background: #f8fafc; color: #cbd5e1; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 2.5rem; margin: 0 auto 1.5rem; box-shadow: 0 4px 6px rgba(0,0,0,0.02); border: 2px dashed #e2e8f0;">
                                    <i class="fas fa-inbox"></i>
                                </div>
                                <h3 style="font-size: 1.25rem; font-weight: 800; color: #1e293b;">No active inquiries found.</h3>
                                <p style="color: #64748b; margin-top: 0.5rem; font-weight: 600;">When buyers initiate consultations, they will be indexed here.</p>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>

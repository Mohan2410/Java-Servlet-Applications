<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.NCart.Bean.CustomerBean" %>
<%@ page import="com.NCart.Bean.FormatUtil" %>
<%
    CustomerBean cbean = (CustomerBean) session.getAttribute("cbean");
    String errorMsg = (String) request.getAttribute("msg");
    if (errorMsg == null || errorMsg.trim().isEmpty()) {
        errorMsg = "We were unable to process your purchase request. Please verify the product details and try again.";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purchase Status - ECART</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <!-- Top Navigation -->
    <header class="ecart-navbar">
        <div class="nav-container">
            <a href="CustomerHome.jsp" class="brand-logo">
                <svg viewBox="0 0 24 24">
                    <path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/>
                </svg>
                ECART
            </a>
            <div class="nav-user">
                <% if (cbean != null) { %>
                    <span class="user-badge">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
                        </svg>
                        <%= FormatUtil.escape(cbean.getCfname()) %>
                    </span>
                    <a href="view" class="nav-link">Catalog</a>
                    <a href="logout" class="btn btn-outline btn-sm">Logout</a>
                <% } else { %>
                    <a href="CustomerLogin.jsp" class="btn btn-primary btn-sm">Sign In</a>
                <% } %>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-wrapper content-center">
        <div class="error-card">
            <!-- Header -->
            <div class="error-header">
                <svg viewBox="0 0 24 24" fill="currentColor">
                    <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"/>
                </svg>
                <h2>Purchase Not Completed</h2>
                <p>We encountered an issue while processing your product order.</p>
            </div>

            <!-- Body -->
            <div class="error-body">
                <div class="alert alert-danger" style="text-align: left; margin-bottom: 1.5rem;">
                    <div><%= FormatUtil.escape(errorMsg) %></div>
                </div>

                <div style="background-color: var(--bg-page); border-radius: var(--radius-md); padding: 1rem; text-align: left; font-size: 0.9rem; color: var(--text-muted); margin-bottom: 2rem;">
                    <div style="font-weight: 600; color: var(--text-main); margin-bottom: 0.35rem;">Possible reasons &amp; suggestions:</div>
                    <ul style="padding-left: 1.25rem; display: flex; flex-direction: column; gap: 0.25rem;">
                        <li>The requested quantity may exceed available stock.</li>
                        <li>Another customer may have purchased the remaining stock just before you.</li>
                        <li>Quantity was invalid or not entered as a whole positive number.</li>
                        <li>Your session may have timed out after a period of inactivity.</li>
                    </ul>
                </div>

                <div style="display: flex; gap: 0.75rem; flex-wrap: wrap;">
                    <a href="view" class="btn btn-primary" style="flex: 2; min-width: 140px;">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/>
                        </svg>
                        Return to Products Catalog
                    </a>
                    <a href="CustomerHome.jsp" class="btn btn-outline" style="flex: 1; min-width: 100px;">Dashboard</a>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="ecart-footer">
        <p>&copy; 2026 ECART Application. Order Assistance &amp; Support.</p>
    </footer>
</body>
</html>

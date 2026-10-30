<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.NCart.Bean.FormatUtil" %>
<%
    String msg = (String) request.getAttribute("msg");
    if (msg == null || msg.trim().isEmpty()) {
        msg = "You have been logged out successfully.";
    }
    try {
        if (session != null) {
            session.invalidate();
        }
    } catch (Exception ignored) {}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logged Out - ECART</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <!-- Top Navigation -->
    <header class="ecart-navbar">
        <div class="nav-container">
            <a href="index.html" class="brand-logo">
                <svg viewBox="0 0 24 24">
                    <path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/>
                </svg>
                ECART
            </a>
            <nav>
                <ul class="nav-links">
                    <li><a href="index.html" class="nav-link">Home</a></li>
                    <li><a href="CustomerLogin.jsp" class="nav-link">Customer Sign In</a></li>
                    <li><a href="AdminLogin.jsp" class="nav-link">Admin Sign In</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-wrapper content-center">
        <div class="card form-card" style="text-align: center;">
            <div style="width: 64px; height: 64px; border-radius: var(--radius-full); background-color: var(--success-bg); color: var(--success); display: inline-flex; align-items: center; justify-content: center; margin-bottom: 1.25rem;">
                <svg width="32" height="32" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>
                </svg>
            </div>
            <h1 class="card-title" style="justify-content: center; margin-bottom: 0.5rem;">Signed Out</h1>
            <p style="color: var(--text-muted); font-size: 1rem; margin-bottom: 2rem;">
                <%= FormatUtil.escape(msg) %>
            </p>

            <div style="display: flex; flex-direction: column; gap: 0.75rem;">
                <a href="CustomerLogin.jsp" class="btn btn-primary btn-block">Sign In Again</a>
                <a href="index.html" class="btn btn-outline btn-block">Return to Store Home</a>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="ecart-footer">
        <p>&copy; 2026 ECART Application. Secure Sign-Out.</p>
    </footer>
</body>
</html>

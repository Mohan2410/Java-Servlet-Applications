<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.NCart.Bean.AdminBean" %>
<%@ page import="com.NCart.Bean.FormatUtil" %>
<%
    AdminBean abean = (AdminBean) session.getAttribute("abean");
    if (abean == null) {
        request.setAttribute("errorMessage", "Admin session expired. Please sign in.");
        request.getRequestDispatcher("AdminLogin.jsp").forward(request, response);
        return;
    }
    String msg = (String) request.getAttribute("msg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Deletion - ECART Admin</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <!-- Top Navigation -->
    <header class="ecart-navbar">
        <div class="nav-container">
            <a href="AdminHome.jsp" class="brand-logo">
                <svg viewBox="0 0 24 24">
                    <path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/>
                </svg>
                ECART Admin
            </a>
            <div class="nav-user">
                <span class="user-badge" style="background-color: var(--secondary-light); color: var(--secondary);">
                    <%= FormatUtil.escape(abean.getaFNAME()) %>
                </span>
                <a href="AdminHome.jsp" class="nav-link">Dashboard</a>
                <a href="logout" class="btn btn-outline btn-sm">Logout</a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-wrapper content-center">
        <div class="card form-card" style="text-align: center;">
            <div style="width: 56px; height: 56px; border-radius: var(--radius-full); background-color: var(--warning-bg); color: var(--warning); display: inline-flex; align-items: center; justify-content: center; margin-bottom: 1rem;">
                <svg width="28" height="28" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"/>
                </svg>
            </div>
            <h1 class="card-title" style="justify-content: center; margin-bottom: 0.5rem;">Delete Product Status</h1>
            <p style="color: var(--text-muted); font-size: 1.05rem; margin-bottom: 1.75rem;">
                <%= FormatUtil.escape(msg) %>
            </p>

            <div style="display: flex; flex-direction: column; gap: 0.75rem;">
                <a href="view1" class="btn btn-primary btn-block">Back to Product Catalog</a>
                <a href="AdminHome.jsp" class="btn btn-outline btn-block">Admin Dashboard</a>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="ecart-footer">
        <p>&copy; 2026 ECART Application. Admin Console.</p>
    </footer>
</body>
</html>

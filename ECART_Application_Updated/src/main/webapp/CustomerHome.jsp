<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.NCart.Bean.CustomerBean" %>
<%@ page import="com.NCart.Bean.FormatUtil" %>
<%
    CustomerBean cbean = (CustomerBean) session.getAttribute("cbean");
    if (cbean == null) {
        request.setAttribute("errorMessage", "Session expired. Please log in to access your customer dashboard.");
        request.getRequestDispatcher("CustomerLogin.jsp").forward(request, response);
        return;
    }
    String msg = (String) request.getAttribute("msg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard - ECART</title>
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
                <span class="user-badge">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
                    </svg>
                    Hello, <%= FormatUtil.escape(cbean.getCfname()) %>
                </span>
                <a href="view" class="nav-link">Shop Products</a>
                <a href="logout" class="btn btn-outline btn-sm">Logout</a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-wrapper">
        <!-- Welcome / Status Alert -->
        <% if (msg != null && !msg.trim().isEmpty()) { %>
            <div class="alert alert-success" role="alert">
                <svg viewBox="0 0 24 24" fill="currentColor">
                    <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>
                </svg>
                <div><%= FormatUtil.escape(msg) %></div>
            </div>
        <% } %>

        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 1.5rem; margin-top: 1rem;">
            <!-- Profile Overview Card -->
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Customer Profile</h2>
                    <p class="card-subtitle">Your registered account details</p>
                </div>
                <div class="receipt-list">
                    <div class="receipt-row">
                        <span class="label">Full Name</span>
                        <span class="value"><%= FormatUtil.escape(cbean.getCfname() + " " + cbean.getClname()) %></span>
                    </div>
                    <div class="receipt-row">
                        <span class="label">Username</span>
                        <span class="value"><%= FormatUtil.escape(cbean.getCuname()) %></span>
                    </div>
                    <div class="receipt-row">
                        <span class="label">Email Address</span>
                        <span class="value"><%= FormatUtil.escape(cbean.getCmailid()) %></span>
                    </div>
                    <div class="receipt-row">
                        <span class="label">Mobile Number</span>
                        <span class="value"><%= FormatUtil.escape(cbean.getCmobile()) %></span>
                    </div>
                    <div class="receipt-row">
                        <span class="label">Delivery Address</span>
                        <span class="value"><%= FormatUtil.escape(cbean.getCaddr()) %></span>
                    </div>
                </div>
            </div>

            <!-- Quick Actions Card -->
            <div class="card" style="display: flex; flex-direction: column; justify-content: space-between;">
                <div>
                    <div class="card-header">
                        <h2 class="card-title">Quick Actions</h2>
                        <p class="card-subtitle">Manage your shopping and orders</p>
                    </div>
                    <p style="color: var(--text-muted); margin-bottom: 1.5rem;">
                        Explore our latest electronic devices including smartphones, laptops, audio accessories, and more with real-time stock levels.
                    </p>
                </div>

                <div style="display: flex; flex-direction: column; gap: 0.85rem;">
                    <a href="view" class="btn btn-primary btn-block">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/>
                        </svg>
                        Browse &amp; Purchase Products
                    </a>
                    <a href="logout" class="btn btn-outline btn-block">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M17 7l-1.41 1.41L18.17 11H8v2h10.17l-2.58 2.58L17 17l5-5zM4 5h8V3H4c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h8v-2H4V5z"/>
                        </svg>
                        Sign Out
                    </a>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="ecart-footer">
        <p>&copy; 2026 ECART Application. Customer Shopping Experience.</p>
    </footer>
</body>
</html>

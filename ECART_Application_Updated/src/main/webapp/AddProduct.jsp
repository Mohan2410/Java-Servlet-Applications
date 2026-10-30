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
    <title>Add Product - ECART Admin</title>
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
                <a href="view1" class="nav-link">View Products</a>
                <a href="logout" class="btn btn-outline btn-sm">Logout</a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-wrapper content-center">
        <div class="card form-card">
            <div class="card-header">
                <h1 class="card-title">Add New Product</h1>
                <p class="card-subtitle">Administrator: <strong><%= FormatUtil.escape(abean.getaFNAME() + " " + abean.getaLNAME()) %></strong></p>
            </div>

            <!-- Status Alert -->
            <% if (msg != null && !msg.trim().isEmpty()) { %>
                <% boolean isSuccess = msg.toLowerCase().contains("success") || msg.toLowerCase().contains("inserted"); %>
                <div class="alert <%= isSuccess ? "alert-success" : "alert-danger" %>" role="alert">
                    <div><%= FormatUtil.escape(msg) %></div>
                </div>
            <% } %>

            <form action="pls" method="post">
                <div class="form-group">
                    <label for="pCode" class="form-label">Product Code <span class="required">*</span></label>
                    <input type="text" id="pCode" name="pCode" class="form-control" placeholder="e.g. P101, MOB01" required>
                </div>

                <div class="form-group">
                    <label for="pName" class="form-label">Product Name <span class="required">*</span></label>
                    <input type="text" id="pName" name="pName" class="form-control" placeholder="e.g. Wireless Noise-Cancelling Headphones" required>
                </div>

                <div class="form-group">
                    <label for="pComp" class="form-label">Brand / Manufacturer <span class="required">*</span></label>
                    <input type="text" id="pComp" name="pComp" class="form-control" placeholder="e.g. Sony, Apple, Samsung" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="pPrice" class="form-label">Unit Price (Rs.) <span class="required">*</span></label>
                        <input type="number" step="0.01" min="1" id="pPrice" name="pPrice" class="form-control" placeholder="e.g. 2499.00" required>
                    </div>

                    <div class="form-group">
                        <label for="pQty" class="form-label">Initial Stock Quantity <span class="required">*</span></label>
                        <input type="number" min="1" id="pQty" name="pQty" class="form-control" placeholder="e.g. 50" required>
                    </div>
                </div>

                <div style="display: flex; gap: 0.75rem; margin-top: 1.5rem; flex-wrap: wrap;">
                    <button type="submit" class="btn btn-secondary" style="flex: 2; min-width: 140px;">Add Product</button>
                    <a href="view1" class="btn btn-outline" style="flex: 1; min-width: 100px;">View All</a>
                </div>
            </form>
        </div>
    </main>

    <!-- Footer -->
    <footer class="ecart-footer">
        <p>&copy; 2026 ECART Application. Inventory Management.</p>
    </footer>
</body>
</html>

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
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - ECART</title>
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
                    Admin: <%= FormatUtil.escape(abean.getaFNAME()) %>
                </span>
                <a href="view1" class="nav-link">Manage Products</a>
                <a href="logout" class="btn btn-outline btn-sm">Logout</a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-wrapper">
        <div class="card-header" style="margin-bottom: 2rem;">
            <h1 style="font-size: 1.85rem; font-weight: 800; color: var(--text-main);">Administrator Dashboard</h1>
            <p style="color: var(--text-muted); font-size: 1rem; margin-top: 0.25rem;">
                Welcome <strong>Mr. <%= FormatUtil.escape(abean.getaFNAME() + " " + abean.getaLNAME()) %></strong>. Manage electronic store inventory and stock levels.
            </p>
        </div>

        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.5rem;">
            <!-- Add Product Card -->
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Add New Product</h2>
                    <p class="card-subtitle">Insert a new electronic item into the catalog</p>
                </div>
                <p style="color: var(--text-muted); font-size: 0.95rem; margin-bottom: 1.5rem;">
                    Register new electronics with unique product code, title, manufacturer company, price, and initial stock units.
                </p>
                <a href="AddProduct.jsp" class="btn btn-secondary btn-block">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z"/>
                    </svg>
                    Add Product
                </a>
            </div>

            <!-- View Products Card -->
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Manage Product Catalog</h2>
                    <p class="card-subtitle">View, edit price/stock, or remove products</p>
                </div>
                <p style="color: var(--text-muted); font-size: 0.95rem; margin-bottom: 1.5rem;">
                    Inspect the current database table of electronics, change unit prices, adjust available stock quantities, or delete obsolete items.
                </p>
                <a href="view1" class="btn btn-primary btn-block">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M4 6h16v2H4zm0 5h16v2H4zm0 5h16v2H4z"/>
                    </svg>
                    View All Products
                </a>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="ecart-footer">
        <p>&copy; 2026 ECART Application. Admin Console.</p>
    </footer>
</body>
</html>

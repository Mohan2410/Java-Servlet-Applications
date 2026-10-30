<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.NCart.Bean.AdminBean" %>
<%@ page import="com.NCart.Bean.ProductBean" %>
<%@ page import="com.NCart.Bean.FormatUtil" %>
<%
    AdminBean abean = (AdminBean) session.getAttribute("abean");
    if (abean == null) {
        request.setAttribute("errorMessage", "Admin session expired. Please sign in.");
        request.getRequestDispatcher("AdminLogin.jsp").forward(request, response);
        return;
    }

    ProductBean pb = (ProductBean) request.getAttribute("productBean");
    if (pb == null) {
        request.setAttribute("msg", "Product details not found.");
        request.getRequestDispatcher("ViewProduct.jsp").forward(request, response);
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product - ECART Admin</title>
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
                <a href="view1" class="nav-link">Product List</a>
                <a href="logout" class="btn btn-outline btn-sm">Logout</a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-wrapper content-center">
        <div class="card form-card">
            <div class="card-header">
                <h1 class="card-title">Edit Product Details</h1>
                <p class="card-subtitle">Product Code: <strong><%= FormatUtil.escape(pb.getpCode()) %></strong></p>
            </div>

            <!-- Read-only Summary -->
            <div class="receipt-list" style="margin-bottom: 1.5rem;">
                <div class="receipt-row">
                    <span class="label">Product Name</span>
                    <span class="value"><%= FormatUtil.escape(pb.getpName()) %></span>
                </div>
                <div class="receipt-row">
                    <span class="label">Brand</span>
                    <span class="value"><%= FormatUtil.escape(pb.getpComp()) %></span>
                </div>
            </div>

            <form action="update" method="post">
                <input type="hidden" name="pcode" value="<%= FormatUtil.escape(pb.getpCode()) %>">

                <div class="form-group">
                    <label for="pPrice" class="form-label">Price (Rs.) <span class="required">*</span></label>
                    <input type="number" step="0.01" min="1" id="pPrice" name="pPrice" class="form-control"
                           value="<%= FormatUtil.escape(pb.getpPrice()) %>" required>
                </div>

                <div class="form-group">
                    <label for="pQty" class="form-label">Available Stock Quantity <span class="required">*</span></label>
                    <input type="number" min="0" id="pQty" name="pQty" class="form-control"
                           value="<%= FormatUtil.escape(pb.getpQty()) %>" required>
                </div>

                <div style="display: flex; gap: 0.75rem; margin-top: 1.75rem; flex-wrap: wrap;">
                    <button type="submit" class="btn btn-secondary" style="flex: 2; min-width: 140px;">Save Changes</button>
                    <a href="view1" class="btn btn-outline" style="flex: 1; min-width: 100px;">Cancel</a>
                </div>
            </form>
        </div>
    </main>

    <!-- Footer -->
    <footer class="ecart-footer">
        <p>&copy; 2026 ECART Application. Edit Product Inventory.</p>
    </footer>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.NCart.Bean.CustomerBean" %>
<%@ page import="com.NCart.Bean.ProductBean" %>
<%@ page import="com.NCart.Bean.FormatUtil" %>
<%
    CustomerBean cbean = (CustomerBean) session.getAttribute("cbean");
    if (cbean == null) {
        request.setAttribute("errorMessage", "Session expired. Please log in to view products.");
        request.getRequestDispatcher("CustomerLogin.jsp").forward(request, response);
        return;
    }

    @SuppressWarnings("unchecked")
    ArrayList<ProductBean> al = (ArrayList<ProductBean>) session.getAttribute("productList");
    if (al == null) {
        al = new ArrayList<ProductBean>();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products Catalog - ECART</title>
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
                    <%= FormatUtil.escape(cbean.getCfname()) %>
                </span>
                <a href="CustomerHome.jsp" class="nav-link">Dashboard</a>
                <a href="logout" class="btn btn-outline btn-sm">Logout</a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-wrapper">
        <div class="catalog-header">
            <div>
                <h1 style="font-size: 1.85rem; font-weight: 800; color: var(--text-main);">Electronic Products Catalog</h1>
                <p style="color: var(--text-muted); font-size: 0.95rem; margin-top: 0.25rem;">
                    Hello <strong><%= FormatUtil.escape(cbean.getCfname() + " " + cbean.getClname()) %></strong>, select an item below to purchase.
                </p>
            </div>
            <a href="CustomerHome.jsp" class="btn btn-outline btn-sm">Back to Dashboard</a>
        </div>

        <!-- Search and Filter Toolbar -->
        <div class="catalog-toolbar">
            <div class="search-box">
                <svg class="search-icon" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/>
                </svg>
                <input type="text" id="productSearchInput" class="form-control" placeholder="Search by product name, brand, or code...">
            </div>

            <div style="display: flex; gap: 0.75rem; flex-wrap: wrap;">
                <select id="productStockFilter" class="filter-select" aria-label="Filter products by availability">
                    <option value="all">All Items</option>
                    <option value="instock">In Stock Only</option>
                    <option value="outofstock">Out of Stock Only</option>
                </select>

                <select id="productSortSelect" class="filter-select" aria-label="Sort products">
                    <option value="default">Default Order</option>
                    <option value="price-asc">Price: Low to High</option>
                    <option value="price-desc">Price: High to Low</option>
                    <option value="name-asc">Product Name: A to Z</option>
                </select>
            </div>
        </div>

        <!-- No Products Matched Message -->
        <div id="noProductsMatch" class="card" style="display: none; text-align: center; padding: 3rem 1.5rem; margin-bottom: 2rem;">
            <p style="font-size: 1.15rem; color: var(--text-muted); font-weight: 600;">No products match your search criteria.</p>
            <p style="font-size: 0.9rem; color: var(--text-light); margin-top: 0.5rem;">Try modifying your search query or reset the filters.</p>
        </div>

        <% if (al.isEmpty()) { %>
            <div class="card" style="text-align: center; padding: 3rem 1.5rem;">
                <p style="font-size: 1.15rem; color: var(--text-muted); font-weight: 600;">There are currently no products available in the store catalog.</p>
                <p style="font-size: 0.9rem; color: var(--text-light); margin-top: 0.5rem;">Please check back later or contact customer support.</p>
            </div>
        <% } else { %>
            <!-- Product Cards Grid -->
            <div id="productGridContainer" class="product-grid">
                <%
                    for (ProductBean pb : al) {
                        int qty = 0;
                        try {
                            qty = Integer.parseInt(pb.getpQty().trim());
                        } catch (Exception ignored) {}

                        double price = 0.0;
                        try {
                            price = Double.parseDouble(pb.getpPrice().trim());
                        } catch (Exception ignored) {}
                %>
                    <div class="product-card product-item-card"
                         data-name="<%= FormatUtil.escape(pb.getpName()) %>"
                         data-code="<%= FormatUtil.escape(pb.getpCode()) %>"
                         data-company="<%= FormatUtil.escape(pb.getpComp()) %>"
                         data-price="<%= price %>"
                         data-qty="<%= qty %>">
                        <span class="product-code-tag"><%= FormatUtil.escape(pb.getpCode()) %></span>
                        <h3 class="product-title"><%= FormatUtil.escape(pb.getpName()) %></h3>
                        <p class="product-company">Brand: <strong><%= FormatUtil.escape(pb.getpComp()) %></strong></p>

                        <div class="product-pricing">
                            <span class="product-price"><%= FormatUtil.formatCurrency(pb.getpPrice()) %></span>
                            <span class="product-stock">
                                <% if (qty > 5) { %>
                                    <span class="badge badge-in-stock">In Stock (<%= qty %>)</span>
                                <% } else if (qty > 0) { %>
                                    <span class="badge badge-low-stock">Low Stock (Only <%= qty %> left)</span>
                                <% } else { %>
                                    <span class="badge badge-out-of-stock">Out of Stock</span>
                                <% } %>
                            </span>
                        </div>

                        <div class="product-actions">
                            <% if (qty > 0) { %>
                                <a href="buy?pcode=<%= FormatUtil.escape(pb.getpCode()) %>" class="btn btn-primary btn-block">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
                                        <path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/>
                                    </svg>
                                    Buy Now
                                </a>
                            <% } else { %>
                                <button type="button" class="btn btn-outline btn-block" disabled style="opacity: 0.6; cursor: not-allowed;">
                                    Out of Stock
                                </button>
                            <% } %>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </main>

    <!-- Footer -->
    <footer class="ecart-footer">
        <p>&copy; 2026 ECART Application. Secure Electronic Store.</p>
    </footer>

    <!-- Search & Filter Interactivity -->
    <script src="js/validation.js"></script>
</body>
</html>

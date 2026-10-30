<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
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

    @SuppressWarnings("unchecked")
    ArrayList<ProductBean> al = (ArrayList<ProductBean>) session.getAttribute("productList");
    if (al == null) {
        al = new ArrayList<ProductBean>();
    }
    String msg = (String) request.getAttribute("msg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products - ECART Admin</title>
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
                <a href="AdminHome.jsp" class="nav-link">Dashboard</a>
                <a href="AddProduct.jsp" class="nav-link">Add Product</a>
                <a href="logout" class="btn btn-outline btn-sm">Logout</a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-wrapper">
        <div class="catalog-header">
            <div>
                <h1 style="font-size: 1.85rem; font-weight: 800; color: var(--text-main);">Store Inventory Catalog</h1>
                <p style="color: var(--text-muted); font-size: 0.95rem; margin-top: 0.25rem;">
                    Admin: <strong><%= FormatUtil.escape(abean.getaFNAME() + " " + abean.getaLNAME()) %></strong> | Total Items: <strong><%= al.size() %></strong>
                </p>
            </div>
            <div style="display: flex; gap: 0.75rem;">
                <a href="AddProduct.jsp" class="btn btn-secondary btn-sm">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z"/>
                    </svg>
                    Add Product
                </a>
                <a href="AdminHome.jsp" class="btn btn-outline btn-sm">Dashboard</a>
            </div>
        </div>

        <% if (msg != null && !msg.trim().isEmpty()) { %>
            <div class="alert alert-info">
                <div><%= FormatUtil.escape(msg) %></div>
            </div>
        <% } %>

        <% if (al.isEmpty()) { %>
            <div class="card" style="text-align: center; padding: 3rem 1.5rem;">
                <p style="font-size: 1.15rem; color: var(--text-muted); font-weight: 600;">No products found in the database.</p>
                <a href="AddProduct.jsp" class="btn btn-secondary" style="margin-top: 1rem;">Add First Product</a>
            </div>
        <% } else { %>
            <div class="table-responsive">
                <table class="ecart-table">
                    <thead>
                        <tr>
                            <th>Product Code</th>
                            <th>Product Name</th>
                            <th>Company / Brand</th>
                            <th>Unit Price</th>
                            <th>Stock Quantity</th>
                            <th>Status</th>
                            <th style="text-align: right;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (ProductBean pb : al) {
                                int qty = 0;
                                try {
                                    qty = Integer.parseInt(pb.getpQty().trim());
                                } catch (Exception ignored) {}
                        %>
                            <tr>
                                <td><span class="product-code-tag"><%= FormatUtil.escape(pb.getpCode()) %></span></td>
                                <td style="font-weight: 600;"><%= FormatUtil.escape(pb.getpName()) %></td>
                                <td><%= FormatUtil.escape(pb.getpComp()) %></td>
                                <td style="font-weight: 700; color: var(--primary);"><%= FormatUtil.formatCurrency(pb.getpPrice()) %></td>
                                <td style="font-weight: 600;"><%= qty %> units</td>
                                <td>
                                    <% if (qty > 5) { %>
                                        <span class="badge badge-in-stock">In Stock</span>
                                    <% } else if (qty > 0) { %>
                                        <span class="badge badge-low-stock">Low Stock (<%= qty %>)</span>
                                    <% } else { %>
                                        <span class="badge badge-out-of-stock">Out of Stock</span>
                                    <% } %>
                                </td>
                                <td style="text-align: right; white-space: nowrap;">
                                    <a href="edit?pcode=<%= FormatUtil.escape(pb.getpCode()) %>" class="btn btn-outline btn-sm" style="margin-right: 0.35rem;">
                                        Edit
                                    </a>
                                    <a href="delete?pcode=<%= FormatUtil.escape(pb.getpCode()) %>"
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Are you sure you want to delete product <%= FormatUtil.escape(pb.getpCode()) %> - <%= FormatUtil.escape(pb.getpName()) %>?');">
                                        Delete
                                    </a>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
    </main>

    <!-- Footer -->
    <footer class="ecart-footer">
        <p>&copy; 2026 ECART Application. Admin Product Management.</p>
    </footer>
</body>
</html>

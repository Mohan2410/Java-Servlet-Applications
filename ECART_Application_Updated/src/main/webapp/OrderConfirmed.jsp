<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.NCart.Bean.CustomerBean" %>
<%@ page import="com.NCart.Bean.ProductBean" %>
<%@ page import="com.NCart.Bean.FormatUtil" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    CustomerBean cbean = (CustomerBean) session.getAttribute("cbean");
    ProductBean pb = (ProductBean) request.getAttribute("productBean");
    Integer quantity = (Integer) request.getAttribute("quantity");
    Double totalAmount = (Double) request.getAttribute("totalAmount");

    String orderDate = new SimpleDateFormat("dd MMM yyyy, hh:mm a").format(new Date());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed - ECART</title>
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
                    <a href="view" class="nav-link">Products</a>
                    <a href="logout" class="btn btn-outline btn-sm">Logout</a>
                <% } %>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-wrapper content-center">
        <% if (cbean != null && pb != null && quantity != null && totalAmount != null) { %>
            <div class="receipt-card">
                <!-- Header with Success Indicator -->
                <div class="receipt-header">
                    <svg viewBox="0 0 24 24" fill="currentColor">
                        <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>
                    </svg>
                    <h2>Order Confirmed!</h2>
                    <p>Thank you for shopping with ECART. Your order has been placed successfully.</p>
                </div>

                <div class="receipt-body">
                    <!-- Customer Greeting & Address -->
                    <div class="receipt-customer">
                        <div>Hello <strong>Mr. <%= FormatUtil.escape(cbean.getCfname() + " " + cbean.getClname()) %></strong>,</div>
                        <div style="font-size: 0.875rem; color: var(--text-muted); margin-top: 0.25rem;">
                            Delivery Address: <%= FormatUtil.escape(cbean.getCaddr()) %> | Placed on: <%= orderDate %>
                        </div>
                    </div>

                    <!-- Itemized Order Details -->
                    <div class="receipt-list">
                        <div class="receipt-row">
                            <span class="label">Product Code</span>
                            <span class="value"><%= FormatUtil.escape(pb.getpCode()) %></span>
                        </div>
                        <div class="receipt-row">
                            <span class="label">Product Name</span>
                            <span class="value"><%= FormatUtil.escape(pb.getpName()) %></span>
                        </div>
                        <div class="receipt-row">
                            <span class="label">Company / Brand</span>
                            <span class="value"><%= FormatUtil.escape(pb.getpComp()) %></span>
                        </div>
                        <div class="receipt-row">
                            <span class="label">Unit Price</span>
                            <span class="value"><%= FormatUtil.formatCurrency(pb.getpPrice()) %></span>
                        </div>
                        <div class="receipt-row">
                            <span class="label">Quantity Purchased</span>
                            <span class="value"><%= quantity %> unit(s)</span>
                        </div>
                        <div class="receipt-total">
                            <span>Total Charged:</span>
                            <span><%= FormatUtil.formatCurrency(totalAmount) %></span>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="receipt-actions">
                        <a href="view" class="btn btn-primary" style="flex: 1;">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
                                <path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/>
                            </svg>
                            View Products
                        </a>
                        <a href="logout" class="btn btn-outline" style="flex: 1;">Logout</a>
                    </div>
                </div>
            </div>
        <% } else { %>
            <div class="card error-card">
                <div class="error-header">
                    <h2>Order Information Unavailable</h2>
                </div>
                <div class="error-body">
                    <p>We could not find active order details for this request. If you recently completed a purchase, check your email or browse the catalog again.</p>
                    <div style="display: flex; gap: 1rem; justify-content: center;">
                        <a href="view" class="btn btn-primary">View Products</a>
                        <a href="logout" class="btn btn-outline">Logout</a>
                    </div>
                </div>
            </div>
        <% } %>
    </main>

    <!-- Footer -->
    <footer class="ecart-footer">
        <p>&copy; 2026 ECART Application. Order Confirmation &amp; Receipt.</p>
    </footer>
</body>
</html>

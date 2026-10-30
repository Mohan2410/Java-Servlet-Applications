<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.NCart.Bean.CustomerBean" %>
<%@ page import="com.NCart.Bean.ProductBean" %>
<%@ page import="com.NCart.Bean.FormatUtil" %>
<%
    CustomerBean cbean = (CustomerBean) session.getAttribute("cbean");
    if (cbean == null) {
        request.setAttribute("errorMessage", "Session expired. Please sign in to purchase items.");
        request.getRequestDispatcher("CustomerLogin.jsp").forward(request, response);
        return;
    }

    ProductBean pb = (ProductBean) request.getAttribute("productBean");
    if (pb == null) {
        request.setAttribute("msg", "Product details could not be retrieved. Please select a product from the catalog.");
        request.getRequestDispatcher("PurchaseResult.jsp").forward(request, response);
        return;
    }

    int availableQty = 0;
    try {
        availableQty = Integer.parseInt(pb.getpQty().trim());
    } catch (Exception ignored) {}

    double unitPrice = 0.0;
    try {
        unitPrice = Double.parseDouble(pb.getpPrice().trim());
    } catch (Exception ignored) {}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purchase Product - ECART</title>
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
                <a href="view" class="nav-link">Catalog</a>
                <a href="logout" class="btn btn-outline btn-sm">Logout</a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-wrapper content-center">
        <div class="card form-card">
            <div class="card-header">
                <h1 class="card-title">Confirm Your Purchase</h1>
                <p class="card-subtitle">
                    Ordering as <strong><%= FormatUtil.escape(cbean.getCfname() + " " + cbean.getClname()) %></strong>
                </p>
            </div>

            <!-- Product Details Summary -->
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
                    <span class="label">Manufacturer</span>
                    <span class="value"><%= FormatUtil.escape(pb.getpComp()) %></span>
                </div>
                <div class="receipt-row">
                    <span class="label">Unit Price</span>
                    <span class="value"><%= FormatUtil.formatCurrency(pb.getpPrice()) %></span>
                </div>
                <div class="receipt-row">
                    <span class="label">Available Stock</span>
                    <span class="value">
                        <% if (availableQty > 0) { %>
                            <span class="badge badge-in-stock"><%= availableQty %> units available</span>
                        <% } else { %>
                            <span class="badge badge-out-of-stock">Out of Stock</span>
                        <% } %>
                    </span>
                </div>
            </div>

            <% if (availableQty > 0) { %>
                <form id="buyProductForm" action="confirmPurchase" method="post"
                      data-unit-price="<%= unitPrice %>"
                      data-max-qty="<%= availableQty %>"
                      novalidate>
                    <input type="hidden" name="pcode" value="<%= FormatUtil.escape(pb.getpCode()) %>">

                    <div class="form-group" style="margin-top: 1.5rem;">
                        <label for="pqty" class="form-label">
                            Enter Quantity to Buy <span class="required">*</span>
                        </label>
                        <input type="number" id="pqty" name="pqty" class="form-control"
                               min="1" max="<%= availableQty %>" value="1"
                               required autocomplete="off">
                        <div id="error-pqty" class="field-error"></div>
                        <div class="field-hint">Enter between 1 and <%= availableQty %> units.</div>
                    </div>

                    <!-- Live Total Amount Calculation -->
                    <div style="background-color: var(--primary-light); border-radius: var(--radius-md); padding: 1rem; margin: 1.5rem 0; display: flex; justify-content: space-between; align-items: center;">
                        <span style="font-weight: 600; color: var(--primary-dark);">Estimated Total Amount:</span>
                        <span id="totalPriceDisplay" style="font-size: 1.35rem; font-weight: 800; color: var(--primary);">
                            <%= FormatUtil.formatCurrency(unitPrice) %>
                        </span>
                    </div>

                    <div style="display: flex; gap: 0.75rem; flex-wrap: wrap;">
                        <button type="submit" class="btn btn-primary" style="flex: 2; min-width: 140px;">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                                <path d="M9 16.2L4.8 12l-1.4 1.4L9 19 21 7l-1.4-1.4L9 16.2z"/>
                            </svg>
                            Confirm &amp; Purchase
                        </button>
                        <a href="view" class="btn btn-outline" style="flex: 1; min-width: 100px;">Cancel</a>
                    </div>
                </form>
            <% } else { %>
                <div class="alert alert-danger" style="margin-top: 1.5rem;">
                    This item is currently out of stock and cannot be purchased at this time.
                </div>
                <div style="margin-top: 1.5rem;">
                    <a href="view" class="btn btn-primary btn-block">Back to Product Catalog</a>
                </div>
            <% } %>
        </div>
    </main>

    <!-- Footer -->
    <footer class="ecart-footer">
        <p>&copy; 2026 ECART Application. Secure Checkout.</p>
    </footer>

    <!-- Form Validation Script -->
    <script src="js/validation.js"></script>
</body>
</html>

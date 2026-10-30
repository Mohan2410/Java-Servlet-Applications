<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.NCart.Bean.FormatUtil" %>
<%
    String errorMsg = (String) request.getAttribute("errorMessage");
    String enteredUsername = (String) request.getAttribute("enteredUsername");
    if (enteredUsername == null) enteredUsername = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login - ECART</title>
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
                    <li><a href="CustomerRegister.jsp" class="nav-link">Register</a></li>
                    <li><a href="AdminLogin.jsp" class="nav-link">Admin</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <!-- Main Login Form -->
    <main class="main-wrapper content-center">
        <div class="card form-card">
            <div class="card-header" style="text-align: center;">
                <h1 class="card-title" style="justify-content: center;">Customer Sign In</h1>
                <p class="card-subtitle">Sign in to access your ECART shopping account</p>
            </div>

            <!-- Error Notification -->
            <% if (errorMsg != null && !errorMsg.trim().isEmpty()) { %>
                <div class="alert alert-danger" role="alert">
                    <svg viewBox="0 0 24 24" fill="currentColor">
                        <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"/>
                    </svg>
                    <div><%= FormatUtil.escape(errorMsg) %></div>
                </div>
            <% } %>

            <form id="customerLoginForm" action="cls" method="post" novalidate>
                <!-- Username -->
                <div class="form-group">
                    <label for="cname" class="form-label">Username <span class="required">*</span></label>
                    <input type="text" id="cname" name="cname" class="form-control"
                           placeholder="Enter your username"
                           value="<%= FormatUtil.escape(enteredUsername) %>"
                           required autocomplete="username">
                    <div id="error-cname" class="field-error"></div>
                </div>

                <!-- Password with Show/Hide -->
                <div class="form-group">
                    <label for="cpwd" class="form-label">Password <span class="required">*</span></label>
                    <div class="input-wrapper">
                        <input type="password" id="cpwd" name="cpwd" class="form-control"
                               placeholder="Enter your password"
                               required autocomplete="current-password">
                        <button type="button" class="password-toggle-btn" data-target="cpwd" aria-label="Toggle password visibility">
                            <span class="icon-eye">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z"/>
                                </svg>
                            </span>
                            <span class="icon-eye-slash" style="display: none;">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M12 7c2.76 0 5 2.24 5 5 0 .65-.13 1.26-.36 1.83l2.92 2.92c1.51-1.26 2.7-2.89 3.44-4.75-1.73-4.39-6-7.5-11-7.5-1.4 0-2.74.25-3.98.7l2.16 2.16C10.74 7.13 11.35 7 12 7zM2 4.27l2.28 2.28.46.46C3.08 8.3 1.78 10.02 1 12c1.73 4.39 6 7.5 11 7.5 1.55 0 3.03-.3 4.38-.84l.42.42L19.73 22 21 20.73 3.27 3 2 4.27zM7.53 9.8l1.55 1.55c-.05.21-.08.43-.08.65 0 1.66 1.34 3 3 3 .22 0 .44-.03.65-.08l1.55 1.55c-.67.33-1.41.53-2.2.53-2.76 0-5-2.24-5-5 0-.79.2-1.53.53-2.2zm4.31-.78l3.15 3.15.02-.16c0-1.66-1.34-3-3-3l-.17.01z"/>
                                </svg>
                            </span>
                        </button>
                    </div>
                    <div id="error-cpwd" class="field-error"></div>
                </div>

                <div style="margin-top: 1.5rem;">
                    <button type="submit" class="btn btn-primary btn-block">Sign In</button>
                </div>

                <div style="text-align: center; margin-top: 1.5rem; font-size: 0.925rem;">
                    Don't have an account yet? <a href="CustomerRegister.jsp" style="font-weight: 600;">Register as New Customer</a>
                </div>
            </form>
        </div>
    </main>

    <!-- Footer -->
    <footer class="ecart-footer">
        <p>&copy; 2026 ECART Application. Secure Customer Login.</p>
    </footer>

    <!-- Form Validation Script -->
    <script src="js/validation.js"></script>
</body>
</html>

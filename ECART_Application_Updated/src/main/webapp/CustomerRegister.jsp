<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.NCart.Bean.CustomerBean" %>
<%@ page import="com.NCart.Bean.FormatUtil" %>
<%
    String errorMsg = (String) request.getAttribute("errorMessage");
    CustomerBean formBean = (CustomerBean) request.getAttribute("formBean");
    if (formBean == null) {
        formBean = new CustomerBean();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration - ECART</title>
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
                    <li><a href="CustomerLogin.jsp" class="nav-link">Sign In</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <!-- Main Registration Form -->
    <main class="main-wrapper">
        <div class="card form-card form-card-wide">
            <div class="card-header">
                <h1 class="card-title">Create Customer Account</h1>
                <p class="card-subtitle">Fill in the form below to register and start shopping for electronic products.</p>
            </div>

            <!-- Server-Side Error Alert -->
            <% if (errorMsg != null && !errorMsg.trim().isEmpty()) { %>
                <div class="alert alert-danger" role="alert">
                    <svg viewBox="0 0 24 24" fill="currentColor">
                        <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"/>
                    </svg>
                    <div><%= FormatUtil.escape(errorMsg) %></div>
                </div>
            <% } %>

            <form id="customerRegisterForm" action="crs" method="post" novalidate>
                <!-- Username -->
                <div class="form-group">
                    <label for="cuname" class="form-label">Username <span class="required">*</span></label>
                    <input type="text" id="cuname" name="cuname" class="form-control"
                           placeholder="e.g. mohan24"
                           value="<%= FormatUtil.escape(formBean.getCuname()) %>"
                           required autocomplete="username">
                    <div id="error-cuname" class="field-error"></div>
                    <div class="field-hint">Choose a unique username (3-30 characters).</div>
                </div>

                <!-- Names Row -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="cfname" class="form-label">First Name <span class="required">*</span></label>
                        <input type="text" id="cfname" name="cfname" class="form-control"
                               placeholder="e.g. Mohan"
                               value="<%= FormatUtil.escape(formBean.getCfname()) %>"
                               required autocomplete="given-name">
                        <div id="error-cfname" class="field-error"></div>
                    </div>
                    <div class="form-group">
                        <label for="clname" class="form-label">Last Name <span class="required">*</span></label>
                        <input type="text" id="clname" name="clname" class="form-control"
                               placeholder="e.g. Kumar"
                               value="<%= FormatUtil.escape(formBean.getClname()) %>"
                               required autocomplete="family-name">
                        <div id="error-clname" class="field-error"></div>
                    </div>
                </div>

                <!-- Email & Mobile Row -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="cmailid" class="form-label">Email Address <span class="required">*</span></label>
                        <input type="email" id="cmailid" name="cmailid" class="form-control"
                               placeholder="e.g. user@example.com"
                               value="<%= FormatUtil.escape(formBean.getCmailid()) %>"
                               required autocomplete="email">
                        <div id="error-cmailid" class="field-error"></div>
                    </div>
                    <div class="form-group">
                        <label for="cmobile" class="form-label">Mobile Number <span class="required">*</span></label>
                        <input type="tel" id="cmobile" name="cmobile" class="form-control"
                               placeholder="10-digit number (e.g. 9876543210)"
                               maxlength="10"
                               value="<%= FormatUtil.escape(formBean.getCmobile()) %>"
                               required autocomplete="tel">
                        <div id="error-cmobile" class="field-error"></div>
                        <div class="field-hint">Must contain exactly 10 digits.</div>
                    </div>
                </div>

                <!-- Address -->
                <div class="form-group">
                    <label for="caddr" class="form-label">Delivery Address <span class="required">*</span></label>
                    <input type="text" id="caddr" name="caddr" class="form-control"
                           placeholder="Full street address, city, and state"
                           value="<%= FormatUtil.escape(formBean.getCaddr()) %>"
                           required autocomplete="street-address">
                    <div id="error-caddr" class="field-error"></div>
                </div>

                <!-- Password Row -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="cpwd" class="form-label">Password <span class="required">*</span></label>
                        <div class="input-wrapper">
                            <input type="password" id="cpwd" name="cpwd" class="form-control"
                                   placeholder="Create a strong password"
                                   required autocomplete="new-password">
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

                    <div class="form-group">
                        <label for="cpwd_confirm" class="form-label">Confirm Password <span class="required">*</span></label>
                        <div class="input-wrapper">
                            <input type="password" id="cpwd_confirm" name="cpwd_confirm" class="form-control"
                                   placeholder="Re-enter your password"
                                   required autocomplete="new-password">
                            <button type="button" class="password-toggle-btn" data-target="cpwd_confirm" aria-label="Toggle confirm password visibility">
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
                        <div id="error-cpwd_confirm" class="field-error"></div>
                    </div>
                </div>

                <!-- Password Policy Checklist -->
                <div class="password-requirements" aria-live="polite">
                    <div class="requirement-title">Password must satisfy:</div>
                    <ul class="requirement-list">
                        <li id="req-length" class="requirement-item unmet">At least 8 characters long</li>
                        <li id="req-upper" class="requirement-item unmet">At least one uppercase letter (A-Z)</li>
                        <li id="req-lower" class="requirement-item unmet">At least one lowercase letter (a-z)</li>
                        <li id="req-digit" class="requirement-item unmet">At least one number (0-9)</li>
                        <li id="req-special" class="requirement-item unmet">At least one special character (@, #, $, %, &amp;, !)</li>
                    </ul>
                </div>

                <!-- Submit Button -->
                <div style="margin-top: 1.75rem;">
                    <button type="submit" class="btn btn-primary btn-block">Complete Registration</button>
                </div>

                <div style="text-align: center; margin-top: 1.25rem; font-size: 0.925rem;">
                    Already have an account? <a href="CustomerLogin.jsp" style="font-weight: 600;">Sign in here</a>
                </div>
            </form>
        </div>
    </main>

    <!-- Footer -->
    <footer class="ecart-footer">
        <p>&copy; 2026 ECART Application. Secure Registration Portal.</p>
    </footer>

    <!-- Form Validation Script -->
    <script src="js/validation.js"></script>
</body>
</html>

/**
 * ECART_Application Form Validations and UI Interactivity
 * Vanilla JavaScript (No external dependencies)
 */

document.addEventListener("DOMContentLoaded", function () {
  initPasswordToggles();
  initCustomerRegistrationValidation();
  initCustomerLoginValidation();
  initPurchaseValidation();
  initProductSearchAndFilter();
});

/* ==========================================================================
   1. Show / Hide Password Toggle
   ========================================================================== */
function initPasswordToggles() {
  const toggleButtons = document.querySelectorAll(".password-toggle-btn");
  toggleButtons.forEach(function (button) {
    button.addEventListener("click", function () {
      const targetInputId = button.getAttribute("data-target");
      const input = document.getElementById(targetInputId);
      if (!input) return;

      const isPassword = input.getAttribute("type") === "password";
      input.setAttribute("type", isPassword ? "text" : "password");

      // Update button text / icon
      const showIcon = button.querySelector(".icon-eye");
      const hideIcon = button.querySelector(".icon-eye-slash");
      if (showIcon && hideIcon) {
        showIcon.style.display = isPassword ? "none" : "inline";
        hideIcon.style.display = isPassword ? "inline" : "none";
      }
      button.setAttribute(
        "aria-label",
        isPassword ? "Hide password" : "Show password"
      );
    });
  });
}

/* ==========================================================================
   2. Customer Registration Form Validation
   ========================================================================== */
function initCustomerRegistrationValidation() {
  const form = document.getElementById("customerRegisterForm");
  if (!form) return;

  const unameInput = document.getElementById("cuname");
  const pwdInput = document.getElementById("cpwd");
  const pwdConfirmInput = document.getElementById("cpwd_confirm");
  const fnameInput = document.getElementById("cfname");
  const lnameInput = document.getElementById("clname");
  const addrInput = document.getElementById("caddr");
  const emailInput = document.getElementById("cmailid");
  const mobileInput = document.getElementById("cmobile");

  // Regex definitions
  const nameRegex = /^[a-zA-Z\s'\-]{2,50}$/;
  const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
  const mobileRegex = /^[6-9]\d{9}$/; // Indian 10-digit mobile number
  const digitsOnlyRegex = /^\d{10}$/;

  // Password rules
  const reqLength = document.getElementById("req-length");
  const reqUpper = document.getElementById("req-upper");
  const reqLower = document.getElementById("req-lower");
  const reqDigit = document.getElementById("req-digit");
  const reqSpecial = document.getElementById("req-special");

  function validatePasswordPolicy(pwd) {
    const hasLength = pwd.length >= 8;
    const hasUpper = /[A-Z]/.test(pwd);
    const hasLower = /[a-z]/.test(pwd);
    const hasDigit = /[0-9]/.test(pwd);
    const hasSpecial = /[@#$%&!]/.test(pwd);

    if (reqLength) setChecklistState(reqLength, hasLength);
    if (reqUpper) setChecklistState(reqUpper, hasUpper);
    if (reqLower) setChecklistState(reqLower, hasLower);
    if (reqDigit) setChecklistState(reqDigit, hasDigit);
    if (reqSpecial) setChecklistState(reqSpecial, hasSpecial);

    return hasLength && hasUpper && hasLower && hasDigit && hasSpecial;
  }

  function setChecklistState(element, isMet) {
    if (isMet) {
      element.classList.remove("unmet");
      element.classList.add("met");
    } else {
      element.classList.remove("met");
      element.classList.add("unmet");
    }
  }

  // Live password checking
  if (pwdInput) {
    pwdInput.addEventListener("input", function () {
      validatePasswordPolicy(pwdInput.value);
      if (pwdConfirmInput && pwdConfirmInput.value.length > 0) {
        validatePasswordMatch();
      }
    });
  }

  // Live confirm password checking
  function validatePasswordMatch() {
    if (!pwdConfirmInput || !pwdInput) return true;
    const match = pwdInput.value === pwdConfirmInput.value;
    const errorEl = document.getElementById("error-cpwd_confirm");
    if (!match) {
      showError(pwdConfirmInput, errorEl, "Passwords do not match.");
      return false;
    } else {
      clearError(pwdConfirmInput, errorEl);
      return true;
    }
  }

  if (pwdConfirmInput) {
    pwdConfirmInput.addEventListener("input", validatePasswordMatch);
  }

  // Field validation helpers
  function showError(input, errorElement, message) {
    if (input) {
      input.classList.add("is-invalid");
      input.classList.remove("is-valid");
      input.setAttribute("aria-invalid", "true");
    }
    if (errorElement) {
      errorElement.textContent = message;
      errorElement.classList.add("visible");
    }
  }

  function clearError(input, errorElement) {
    if (input) {
      input.classList.remove("is-invalid");
      input.classList.add("is-valid");
      input.removeAttribute("aria-invalid");
    }
    if (errorElement) {
      errorElement.textContent = "";
      errorElement.classList.remove("visible");
    }
  }

  // Real-time input cleanup & validation
  if (fnameInput) {
    fnameInput.addEventListener("input", function () {
      const val = fnameInput.value.trim();
      const err = document.getElementById("error-cfname");
      if (!val) {
        showError(fnameInput, err, "First name is required.");
      } else if (!nameRegex.test(val)) {
        showError(
          fnameInput,
          err,
          "First name should contain 2-50 letters, spaces, hyphens, or apostrophes."
        );
      } else {
        clearError(fnameInput, err);
      }
    });
  }

  if (lnameInput) {
    lnameInput.addEventListener("input", function () {
      const val = lnameInput.value.trim();
      const err = document.getElementById("error-clname");
      if (!val) {
        showError(lnameInput, err, "Last name is required.");
      } else if (!nameRegex.test(val)) {
        showError(
          lnameInput,
          err,
          "Last name should contain 2-50 letters, spaces, hyphens, or apostrophes."
        );
      } else {
        clearError(lnameInput, err);
      }
    });
  }

  if (emailInput) {
    emailInput.addEventListener("input", function () {
      const val = emailInput.value.trim();
      const err = document.getElementById("error-cmailid");
      if (!val) {
        showError(emailInput, err, "Email address is required.");
      } else if (/\s/.test(emailInput.value)) {
        showError(emailInput, err, "Email address must not contain spaces.");
      } else if (!emailRegex.test(val)) {
        showError(
          emailInput,
          err,
          "Please enter a valid email address (e.g., user@example.com)."
        );
      } else {
        clearError(emailInput, err);
      }
    });
  }

  if (mobileInput) {
    mobileInput.addEventListener("input", function () {
      // Keep only numbers entered
      mobileInput.value = mobileInput.value.replace(/\D/g, "");
      const val = mobileInput.value;
      const err = document.getElementById("error-cmobile");
      if (!val) {
        showError(mobileInput, err, "Mobile number is required.");
      } else if (val.length !== 10) {
        showError(
          mobileInput,
          err,
          "Mobile number must contain exactly 10 digits."
        );
      } else if (!mobileRegex.test(val)) {
        showError(
          mobileInput,
          err,
          "Please enter a valid 10-digit mobile number starting with 6-9."
        );
      } else {
        clearError(mobileInput, err);
      }
    });
  }

  if (unameInput) {
    unameInput.addEventListener("input", function () {
      const val = unameInput.value.trim();
      const err = document.getElementById("error-cuname");
      if (!val) {
        showError(unameInput, err, "Username is required.");
      } else if (val.length < 3) {
        showError(unameInput, err, "Username must be at least 3 characters.");
      } else {
        clearError(unameInput, err);
      }
    });
  }

  if (addrInput) {
    addrInput.addEventListener("input", function () {
      const val = addrInput.value.trim();
      const err = document.getElementById("error-caddr");
      if (!val) {
        showError(addrInput, err, "Address is required.");
      } else {
        clearError(addrInput, err);
      }
    });
  }

  // On form submit validation
  form.addEventListener("submit", function (e) {
    let isValid = true;

    // Validate Username
    const uVal = unameInput ? unameInput.value.trim() : "";
    const uErr = document.getElementById("error-cuname");
    if (!uVal) {
      showError(unameInput, uErr, "Username is required.");
      isValid = false;
    } else if (uVal.length < 3) {
      showError(unameInput, uErr, "Username must be at least 3 characters.");
      isValid = false;
    }

    // Validate First Name
    const fnVal = fnameInput ? fnameInput.value.trim() : "";
    const fnErr = document.getElementById("error-cfname");
    if (!fnVal) {
      showError(fnameInput, fnErr, "First name is required.");
      isValid = false;
    } else if (!nameRegex.test(fnVal)) {
      showError(
        fnameInput,
        fnErr,
        "First name should contain 2-50 letters, spaces, hyphens, or apostrophes."
      );
      isValid = false;
    }

    // Validate Last Name
    const lnVal = lnameInput ? lnameInput.value.trim() : "";
    const lnErr = document.getElementById("error-clname");
    if (!lnVal) {
      showError(lnameInput, lnErr, "Last name is required.");
      isValid = false;
    } else if (!nameRegex.test(lnVal)) {
      showError(
        lnameInput,
        lnErr,
        "Last name should contain 2-50 letters, spaces, hyphens, or apostrophes."
      );
      isValid = false;
    }

    // Validate Address
    const addrVal = addrInput ? addrInput.value.trim() : "";
    const addrErr = document.getElementById("error-caddr");
    if (!addrVal) {
      showError(addrInput, addrErr, "Address is required.");
      isValid = false;
    }

    // Validate Email
    const emVal = emailInput ? emailInput.value.trim() : "";
    const emErr = document.getElementById("error-cmailid");
    if (!emVal) {
      showError(emailInput, emErr, "Email address is required.");
      isValid = false;
    } else if (/\s/.test(emailInput.value)) {
      showError(emailInput, emErr, "Email address must not contain spaces.");
      isValid = false;
    } else if (!emailRegex.test(emVal)) {
      showError(
        emailInput,
        emErr,
        "Please enter a valid email address (e.g., user@example.com)."
      );
      isValid = false;
    }

    // Validate Mobile
    const mobVal = mobileInput ? mobileInput.value.trim() : "";
    const mobErr = document.getElementById("error-cmobile");
    if (!mobVal) {
      showError(mobileInput, mobErr, "Mobile number is required.");
      isValid = false;
    } else if (mobVal.length !== 10) {
      showError(
        mobileInput,
        mobErr,
        "Mobile number must contain exactly 10 digits."
      );
      isValid = false;
    } else if (!mobileRegex.test(mobVal)) {
      showError(
        mobileInput,
        mobErr,
        "Please enter a valid 10-digit mobile number starting with 6-9."
      );
      isValid = false;
    }

    // Validate Password
    const pwdVal = pwdInput ? pwdInput.value : "";
    const pwdErr = document.getElementById("error-cpwd");
    if (!pwdVal) {
      showError(pwdInput, pwdErr, "Password is required.");
      isValid = false;
    } else if (!validatePasswordPolicy(pwdVal)) {
      showError(
        pwdInput,
        pwdErr,
        "Password must contain at least 8 characters, including one uppercase letter, one lowercase letter, one digit, and one special character."
      );
      isValid = false;
    }

    // Validate Confirm Password
    if (pwdConfirmInput) {
      if (!validatePasswordMatch()) {
        isValid = false;
      }
    }

    if (!isValid) {
      e.preventDefault();
      // Scroll to first invalid field
      const firstInvalid = form.querySelector(".is-invalid");
      if (firstInvalid) {
        firstInvalid.focus();
      }
    }
  });
}

/* ==========================================================================
   3. Customer Login Form Validation
   ========================================================================== */
function initCustomerLoginValidation() {
  const form = document.getElementById("customerLoginForm");
  if (!form) return;

  const unameInput = document.getElementById("cname");
  const pwdInput = document.getElementById("cpwd");

  form.addEventListener("submit", function (e) {
    let isValid = true;

    const uVal = unameInput ? unameInput.value.trim() : "";
    const uErr = document.getElementById("error-cname");
    if (!uVal) {
      if (unameInput) unameInput.classList.add("is-invalid");
      if (uErr) {
        uErr.textContent = "Please enter your username.";
        uErr.classList.add("visible");
      }
      isValid = false;
    } else {
      if (unameInput) unameInput.classList.remove("is-invalid");
      if (uErr) uErr.classList.remove("visible");
    }

    const pVal = pwdInput ? pwdInput.value : "";
    const pErr = document.getElementById("error-cpwd");
    if (!pVal) {
      if (pwdInput) pwdInput.classList.add("is-invalid");
      if (pErr) {
        pErr.textContent = "Please enter your password.";
        pErr.classList.add("visible");
      }
      isValid = false;
    } else {
      if (pwdInput) pwdInput.classList.remove("is-invalid");
      if (pErr) pErr.classList.remove("visible");
    }

    if (!isValid) {
      e.preventDefault();
      const firstInvalid = form.querySelector(".is-invalid");
      if (firstInvalid) firstInvalid.focus();
    }
  });
}

/* ==========================================================================
   4. Purchase Quantity Validation & Real-Time Total
   ========================================================================== */
function initPurchaseValidation() {
  const form = document.getElementById("buyProductForm");
  if (!form) return;

  const qtyInput = document.getElementById("pqty");
  const maxQtyVal = parseInt(form.getAttribute("data-max-qty") || "0", 10);
  const unitPriceVal = parseFloat(form.getAttribute("data-unit-price") || "0");
  const totalDisplay = document.getElementById("totalPriceDisplay");
  const qtyError = document.getElementById("error-pqty");

  function updateTotal() {
    if (!qtyInput) return;
    const rawVal = qtyInput.value.trim();
    const qty = parseInt(rawVal, 10);

    if (isNaN(qty) || qty < 1) {
      if (qtyError) {
        qtyError.textContent = "Quantity must be a valid number of at least 1.";
        qtyError.classList.add("visible");
      }
      qtyInput.classList.add("is-invalid");
      if (totalDisplay) totalDisplay.textContent = "Rs. 0.00";
      return false;
    } else if (maxQtyVal > 0 && qty > maxQtyVal) {
      if (qtyError) {
        qtyError.textContent =
          "Requested quantity exceeds available stock (" + maxQtyVal + ").";
        qtyError.classList.add("visible");
      }
      qtyInput.classList.add("is-invalid");
      if (totalDisplay) totalDisplay.textContent = "Rs. 0.00";
      return false;
    } else {
      if (qtyError) qtyError.classList.remove("visible");
      qtyInput.classList.remove("is-invalid");
      const total = qty * unitPriceVal;
      if (totalDisplay) {
        totalDisplay.textContent = "Rs. " + total.toFixed(2);
      }
      return true;
    }
  }

  if (qtyInput) {
    qtyInput.addEventListener("input", updateTotal);
    updateTotal();
  }

  form.addEventListener("submit", function (e) {
    if (!updateTotal()) {
      e.preventDefault();
      if (qtyInput) qtyInput.focus();
    }
  });
}

/* ==========================================================================
   5. Client-Side Product Search and Filter
   ========================================================================== */
function initProductSearchAndFilter() {
  const searchInput = document.getElementById("productSearchInput");
  const filterSelect = document.getElementById("productStockFilter");
  const sortSelect = document.getElementById("productSortSelect");
  const productContainer = document.getElementById("productGridContainer");
  const noResultsMsg = document.getElementById("noProductsMatch");

  if (!searchInput && !filterSelect && !sortSelect) return;

  function filterAndSortProducts() {
    const query = searchInput ? searchInput.value.toLowerCase().trim() : "";
    const filter = filterSelect ? filterSelect.value : "all";
    const sort = sortSelect ? sortSelect.value : "default";

    const cards = Array.from(document.querySelectorAll(".product-item-card"));
    if (cards.length === 0) return;

    let visibleCount = 0;

    cards.forEach(function (card) {
      const name = (card.getAttribute("data-name") || "").toLowerCase();
      const code = (card.getAttribute("data-code") || "").toLowerCase();
      const comp = (card.getAttribute("data-company") || "").toLowerCase();
      const qty = parseInt(card.getAttribute("data-qty") || "0", 10);

      // Search matching
      const matchesSearch =
        !query ||
        name.includes(query) ||
        code.includes(query) ||
        comp.includes(query);

      // Stock filter matching
      let matchesFilter = true;
      if (filter === "instock") {
        matchesFilter = qty > 0;
      } else if (filter === "outofstock") {
        matchesFilter = qty <= 0;
      }

      if (matchesSearch && matchesFilter) {
        card.style.display = "";
        visibleCount++;
      } else {
        card.style.display = "none";
      }
    });

    // Sorting
    if (productContainer && sort !== "default") {
      const sorted = cards.slice().sort(function (a, b) {
        const priceA = parseFloat(a.getAttribute("data-price") || "0");
        const priceB = parseFloat(b.getAttribute("data-price") || "0");
        const nameA = a.getAttribute("data-name") || "";
        const nameB = b.getAttribute("data-name") || "";

        if (sort === "price-asc") return priceA - priceB;
        if (sort === "price-desc") return priceB - priceA;
        if (sort === "name-asc") return nameA.localeCompare(nameB);
        return 0;
      });

      sorted.forEach(function (card) {
        productContainer.appendChild(card);
      });
    }

    if (noResultsMsg) {
      noResultsMsg.style.display = visibleCount === 0 ? "block" : "none";
    }
  }

  if (searchInput) searchInput.addEventListener("input", filterAndSortProducts);
  if (filterSelect)
    filterSelect.addEventListener("change", filterAndSortProducts);
  if (sortSelect) sortSelect.addEventListener("change", filterAndSortProducts);
}

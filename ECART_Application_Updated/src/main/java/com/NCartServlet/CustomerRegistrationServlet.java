package com.NCartServlet;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.NCart.Bean.CustomerBean;
import com.NCartDAO.CustomerRegisterDAO;

@WebServlet("/crs")
public class CustomerRegistrationServlet extends HttpServlet {

	// Validation Patterns
	private static final Pattern NAME_PATTERN = Pattern.compile("^[a-zA-Z\\s'\\-]{2,50}$");
	private static final Pattern EMAIL_PATTERN = Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");
	private static final Pattern MOBILE_PATTERN = Pattern.compile("^[6-9]\\d{9}$");
	private static final Pattern DIGITS_10_PATTERN = Pattern.compile("^\\d{10}$");
	private static final Pattern PASSWORD_UPPER = Pattern.compile(".*[A-Z].*");
	private static final Pattern PASSWORD_LOWER = Pattern.compile(".*[a-z].*");
	private static final Pattern PASSWORD_DIGIT = Pattern.compile(".*[0-9].*");
	private static final Pattern PASSWORD_SPECIAL = Pattern.compile(".*[@#$%&!].*");

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String uname = req.getParameter("cuname");
		String pwd = req.getParameter("cpwd");
		String pwdConfirm = req.getParameter("cpwd_confirm");
		String fname = req.getParameter("cfname");
		String lname = req.getParameter("clname");
		String addr = req.getParameter("caddr");
		String mailid = req.getParameter("cmailid");
		String mobile = req.getParameter("cmobile");

		// Trim non-sensitive input
		String trimmedUname = uname != null ? uname.trim() : "";
		String trimmedFname = fname != null ? fname.trim() : "";
		String trimmedLname = lname != null ? lname.trim() : "";
		String trimmedAddr = addr != null ? addr.trim() : "";
		String trimmedMailid = mailid != null ? mailid.trim() : "";
		String trimmedMobile = mobile != null ? mobile.trim() : "";

		CustomerBean cb = new CustomerBean();
		cb.setCuname(trimmedUname);
		cb.setCpwd(pwd != null ? pwd : "");
		cb.setCfname(trimmedFname);
		cb.setClname(trimmedLname);
		cb.setCaddr(trimmedAddr);
		cb.setCmailid(trimmedMailid);
		cb.setCmobile(trimmedMobile);

		req.setAttribute("formBean", cb);

		// 1. Required Fields Validation
		if (trimmedUname.isEmpty()) {
			sendValidationError(req, res, "Username is required and cannot be empty.");
			return;
		}
		if (trimmedUname.length() < 3 || trimmedUname.length() > 30) {
			sendValidationError(req, res, "Username must be between 3 and 30 characters.");
			return;
		}

		// 2. Name Validation (First Name & Last Name)
		if (trimmedFname.isEmpty()) {
			sendValidationError(req, res, "First name is required.");
			return;
		}
		if (!NAME_PATTERN.matcher(trimmedFname).matches()) {
			sendValidationError(req, res, "First name should contain 2-50 characters with letters, spaces, hyphens, or apostrophes only.");
			return;
		}

		if (trimmedLname.isEmpty()) {
			sendValidationError(req, res, "Last name is required.");
			return;
		}
		if (!NAME_PATTERN.matcher(trimmedLname).matches()) {
			sendValidationError(req, res, "Last name should contain 2-50 characters with letters, spaces, hyphens, or apostrophes only.");
			return;
		}

		// 3. Address Validation
		if (trimmedAddr.isEmpty()) {
			sendValidationError(req, res, "Address is required and cannot be empty.");
			return;
		}

		// 4. Email Address Validation
		if (trimmedMailid.isEmpty()) {
			sendValidationError(req, res, "Email address is required.");
			return;
		}
		if (mailid.contains(" ")) {
			sendValidationError(req, res, "Email address must not contain spaces.");
			return;
		}
		if (!EMAIL_PATTERN.matcher(trimmedMailid).matches()) {
			sendValidationError(req, res, "Please enter a valid email address (e.g., username@example.com).");
			return;
		}

		// 5. Mobile Number Validation
		if (trimmedMobile.isEmpty()) {
			sendValidationError(req, res, "Mobile number is required.");
			return;
		}
		if (!DIGITS_10_PATTERN.matcher(trimmedMobile).matches()) {
			sendValidationError(req, res, "Mobile number must contain exactly 10 digits without letters or special characters.");
			return;
		}
		if (!MOBILE_PATTERN.matcher(trimmedMobile).matches()) {
			sendValidationError(req, res, "Mobile number should be a valid 10-digit number starting with 6, 7, 8, or 9.");
			return;
		}

		// 6. Password Complexity Validation
		if (pwd == null || pwd.length() < 8) {
			sendValidationError(req, res, "Password must contain at least 8 characters, including one uppercase letter, one lowercase letter, one digit, and one special character.");
			return;
		}
		if (!PASSWORD_UPPER.matcher(pwd).matches()) {
			sendValidationError(req, res, "Password must contain at least one uppercase letter (A-Z).");
			return;
		}
		if (!PASSWORD_LOWER.matcher(pwd).matches()) {
			sendValidationError(req, res, "Password must contain at least one lowercase letter (a-z).");
			return;
		}
		if (!PASSWORD_DIGIT.matcher(pwd).matches()) {
			sendValidationError(req, res, "Password must contain at least one digit (0-9).");
			return;
		}
		if (!PASSWORD_SPECIAL.matcher(pwd).matches()) {
			sendValidationError(req, res, "Password must contain at least one special character (@, #, $, %, &, !).");
			return;
		}

		// Confirm Password Match Check (if supplied in form)
		if (pwdConfirm != null && !pwd.equals(pwdConfirm)) {
			sendValidationError(req, res, "Passwords do not match. Please re-enter both password fields.");
			return;
		}

		// 7. Insert customer into database
		int rowCount = new CustomerRegisterDAO().checkCustomerRegistration(cb);

		if (rowCount > 0) {
			HttpSession session = req.getSession();
			session.setAttribute("cbean", cb);
			req.setAttribute("msg", "Customer registration successful! Welcome to ECART.");
			req.getRequestDispatcher("CustomerHome.jsp").forward(req, res);
		} else {
			// Registration failed (e.g., duplicate username or DB constraint)
			sendValidationError(req, res, "Registration failed. The username may already be in use or database is currently unavailable.");
		}
	}

	private void sendValidationError(HttpServletRequest req, HttpServletResponse res, String errorMessage)
			throws ServletException, IOException {
		req.setAttribute("errorMessage", errorMessage);
		req.getRequestDispatcher("CustomerRegister.jsp").forward(req, res);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.sendRedirect("CustomerRegister.jsp");
	}
}

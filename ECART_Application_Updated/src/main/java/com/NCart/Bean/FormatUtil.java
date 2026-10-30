package com.NCart.Bean;

public class FormatUtil {

	public static String escape(String input) {
		if (input == null) return "";
		StringBuilder out = new StringBuilder(Math.max(16, input.length()));
		for (int i = 0; i < input.length(); i++) {
			char c = input.charAt(i);
			switch (c) {
				case '<': out.append("&lt;"); break;
				case '>': out.append("&gt;"); break;
				case '&': out.append("&amp;"); break;
				case '"': out.append("&quot;"); break;
				case '\'': out.append("&#x27;"); break;
				case '/': out.append("&#x2F;"); break;
				default: out.append(c);
			}
		}
		return out.toString();
	}

	public static String formatCurrency(double amount) {
		return String.format("Rs. %.2f", amount);
	}

	public static String formatCurrency(String amountStr) {
		try {
			double val = Double.parseDouble(amountStr);
			return formatCurrency(val);
		} catch (Exception e) {
			return "Rs. " + escape(amountStr);
		}
	}
}

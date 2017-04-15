package org.mm.servlet;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginFilter implements Filter {
	private String[] checkUrls = { "Servlet", ".jsp", ".html" };
	private String[] escapeUrls = { "login.jsp", "LoginServlet","lostpassword.jsp"};
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;

		String uri = httpServletRequest.getRequestURI();
		if (check(uri)) {
			if (!this.isEscape(uri)) {
				if (httpServletRequest.getSession().getAttribute("LOGIN_USER") == null) {

					httpServletResponse.sendRedirect(httpServletRequest
							.getContextPath()
							+ "/login.jsp");
					return;
				}
			}
		}

		chain.doFilter(request, response);

	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}
	
	private boolean check(String uri) {
		for (String u : checkUrls) {
			if (uri.endsWith(u)) {
				return true;
			}
		}
		return false;

	}

	private boolean isEscape(String uri) {
		for (String u : escapeUrls) {
			if (uri.endsWith(u)) {
				return true;
			}
		}
		return false;
	}

}

package com.tugas.perpus.filter;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {
  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
    HttpServletRequest req = (HttpServletRequest) request;
    HttpServletResponse res = (HttpServletResponse) response;
    HttpSession session = req.getSession(false);
    String loginURI = req.getContextPath() + "/login";
    String uri = req.getRequestURI();

    boolean loggedIn = (session != null && session.getAttribute("user") != null);
    boolean loginRequest = uri.equals(loginURI) || uri.endsWith("login.jsp") || uri.endsWith("register") || uri.endsWith("register.jsp");
    boolean resourceRequest = uri.contains("/css/") || uri.contains("/js/") || uri.contains("/img/") || uri.contains("/fonts/") || uri.contains("/vendor/");

    if (loggedIn && (loginRequest)) {
      res.sendRedirect(req.getContextPath() + "/"); // redirect ke halaman utama jika sudah login
    } else if (loggedIn && (uri.endsWith("register") || uri.endsWith("register.jsp"))) {
      res.sendRedirect(req.getContextPath() + "/"); // redirect ke halaman utama jika sudah login
    } else if (loggedIn || loginRequest || resourceRequest) {
      chain.doFilter(request, response);
    } else {
      res.sendRedirect(loginURI);
    }
  }

  @Override
  public void init(FilterConfig filterConfig) {}

  @Override
  public void destroy() {}
}

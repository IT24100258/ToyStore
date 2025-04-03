package com.toyStore.filter;

import com.toyStore.model.UserManagement.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        httpResponse.setHeader("Pragma", "no-cache");
        httpResponse.setHeader("Expires", "0");

        String path = httpRequest.getRequestURI();

        if (path.startsWith(httpRequest.getContextPath() + "/images/") ||
                path.startsWith(httpRequest.getContextPath() + "/css/") ||
                path.startsWith(httpRequest.getContextPath() + "/js/")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = httpRequest.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (path.startsWith(httpRequest.getContextPath() + "/views/admin/")) {
            if (user == null || !"admin".equals(user.getRole())) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/views/home.jsp");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}

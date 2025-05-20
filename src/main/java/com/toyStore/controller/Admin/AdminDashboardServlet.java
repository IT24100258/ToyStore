package com.toyStore.controller.Admin;

import com.toyStore.model.UserManagement.User;
import com.toyStore.util.adminManegment.AdminFileUtil;
import com.toyStore.util.UserManagement.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User loggedUser = (User) session.getAttribute("user");

        if (!"admin".equalsIgnoreCase(loggedUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home.jsp");
            return;
        }

        List<User> admins = AdminFileUtil.getAdmins();
        List<User> users = FileUtil.getUsers();

        request.setAttribute("admins", admins);
        request.setAttribute("users", users);

        request.getRequestDispatcher("/views/admin/adminDashboard.jsp").forward(request, response);
    }
}


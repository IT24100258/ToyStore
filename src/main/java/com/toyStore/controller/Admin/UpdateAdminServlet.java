package com.toyStore.controller.Admin;

import com.toyStore.model.UserManagement.User;
import com.toyStore.util.adminManegment.AdminFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/updateAdmin")
public class UpdateAdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");

        if (admin == null || !"admin".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String username = request.getParameter("adminUsername");
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");

        if (newPassword != null && !newPassword.isEmpty() && !newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("/views/admin/AdminManagement/adminUpdate.jsp").forward(request, response);
            return;
        }

        boolean isUpdated = AdminFileUtil.updateAdmin(email, username,
                newPassword.isEmpty() ? null : newPassword, phoneNumber, address);

        if (isUpdated) {
            session.setAttribute("user", new User(admin.getId(), username,
                    newPassword.isEmpty() ? admin.getPassword() : newPassword,
                    email, phoneNumber, address, admin.getRole()));
            request.setAttribute("message", "Profile updated successfully!");
            // Forward to JSP to display success message
            request.getRequestDispatcher("/views/admin/AdminManagement/adminUpdate.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Update failed. Please try again.");
            request.getRequestDispatcher("/views/admin/AdminManagement/adminUpdate.jsp").forward(request, response);
        }
    }
}
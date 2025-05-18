package com.toyStore.controller.userManagement;


import com.toyStore.model.UserManagement.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import static com.toyStore.util.UserManagement.FileUtil.updateUser;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if(user == null){
            response.sendRedirect(request.getContextPath() + "/login");
        }

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");

        if(newPassword != null && !newPassword.isEmpty() && !newPassword.equals(confirmPassword)){
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("updateProfile.jsp").forward(request, response);
            return;
        }

        boolean isUpdated = updateUser(email, username, newPassword, phoneNumber, address);

        if(isUpdated){
            session.setAttribute("user", new User(user.getId(), username,
                    newPassword.isEmpty() ? user.getPassword() : newPassword,
                    email, phoneNumber, address, user.getRole()));

            response.sendRedirect(request.getContextPath() + "/profile?success=true");
        }else {
            request.setAttribute("error", "Update failed. Please try again.");
            request.getRequestDispatcher("updateProfile.jsp").forward(request, response);
        }
    }
}

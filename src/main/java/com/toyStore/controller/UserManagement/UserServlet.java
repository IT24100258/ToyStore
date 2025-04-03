package com.toyStore.controller.UserManagement;

import com.toyStore.model.UserManagement.User;
import com.toyStore.service.UserManagement.UserService;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/register")
public class UserServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/UserManagement/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String phoneNumber = req.getParameter("phoneNumber");
        String address = req.getParameter("address");


        try {
            User newUser = new User(username, password, email, phoneNumber, address);
            userService.registerUser(newUser);
            resp.sendRedirect(req.getContextPath() + "/login");
        } catch (Exception e) {
            req.setAttribute("error", "Registration failed: " + e.getMessage());
            req.getRequestDispatcher("/views/UserManagement/index.jsp").forward(req, resp);
        }
    }
}
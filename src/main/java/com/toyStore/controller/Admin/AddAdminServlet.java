package com.toyStore.controller.Admin;

import com.google.gson.Gson;
import com.toyStore.model.UserManagement.Admin;
import com.toyStore.model.UserManagement.User;
import com.toyStore.service.AdminManagement.AdminService;
import com.toyStore.service.UserManagement.UserService;
import com.toyStore.util.UserManagement.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/registerAdmin")
public class AddAdminServlet extends HttpServlet {
    private final AdminService adminService =  new AdminService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        List<User> allUsers = FileUtil.getUsers();
        List<User> admins = allUsers.stream()
                .filter(user -> "admin".equalsIgnoreCase(user.getRole()))
                .collect(Collectors.toList());

        Gson gson = new Gson();
        String json = gson.toJson(admins);
        resp.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String address = req.getParameter("address");
        String phoneNumber = req.getParameter("number");

        Admin admin = new Admin(username, password, email, phoneNumber, address);

        boolean success = adminService.registerAdmin(admin);

        resp.setContentType("application/json");
        if(success) {
            resp.setStatus(HttpServletResponse.SC_CREATED);
            resp.getWriter().write("{\"message\":\"Admin registered successfully\"}");
            req.getRequestDispatcher("/views/admin/AdminManagement/addNewAdmin.jsp").forward(req, resp);
        } else {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"message\":\"Failed to register admin\"}");
        }
    }
}

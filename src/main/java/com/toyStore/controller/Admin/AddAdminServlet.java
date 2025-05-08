package com.toyStore.controller.Admin;

import com.google.gson.Gson;
import com.toyStore.model.UserManagement.Admin;
import com.toyStore.model.UserManagement.User;
import com.toyStore.service.UserManagement.UserService;
import com.toyStore.util.UserManagement.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "AddAdminServlet",value = "/admin/join")
public class AddAdminServlet extends HttpServlet {
    private final UserService userService = new UserService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        List<User> users = FileUtil.getUsers("admin");
        Gson gson = new Gson();
        String json = gson.toJson(users);
        resp.getWriter().write(json);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        String email = req.getParameter("email");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String address = req.getParameter("address");
        String phonenumber = req.getParameter("number");

        Admin admin = new Admin(username, password, email, phonenumber, address);
        userService.registerAdmin(admin);
    }
}


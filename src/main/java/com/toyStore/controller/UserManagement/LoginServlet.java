package com.toyStore.controller.UserManagement;

import com.toyStore.model.UserManagement.User;
import com.toyStore.util.UserManagement.FileUtil;
import com.toyStore.util.adminManegment.AdminFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        req.getRequestDispatcher("/views/UserManagement/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = FileUtil.getUser(email, password);

        if (user == null) {
            user = AdminFileUtil.getAdmin(email, password);
        }

        if (user == null) {
            req.setAttribute("error", "Invalid email or password");
            req.getRequestDispatcher("/views/UserManagement/login.jsp").forward(req, resp);
        } else {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            req.getSession().setAttribute("username", user.getUserName());


            if ("admin".equals(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/views/admin/AdminManagement/admin.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/");
            }
        }
    }
}

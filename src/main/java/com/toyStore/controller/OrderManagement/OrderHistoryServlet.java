package com.toyStore.controller.OrderManagement;

import com.toyStore.model.OrderManagement.Order;
import com.toyStore.model.Toymanagement.ToyLinkedList;
import com.toyStore.util.OrderManagement.OrderFileUtil;
import com.toyStore.util.ToyManagement.ToyFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/myOrders")
public class OrderHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("username") : null;
        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        ToyLinkedList toyList = ToyFileUtil.loadToys();
        List<Order> userOrders = OrderFileUtil.getOrdersByUsername(username);

        request.setAttribute("orders", userOrders);
        request.setAttribute("toyList", toyList);
        request.getRequestDispatcher("/views/OrderManagement/myOrders.jsp").forward(request, response);
    }
}

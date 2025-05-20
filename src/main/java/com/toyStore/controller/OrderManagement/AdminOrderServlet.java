package com.toyStore.controller.OrderManagement;

import com.toyStore.model.OrderManagement.Order;
import com.toyStore.util.OrderManagement.OrderFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Order> orders = OrderFileUtil.loadOrders();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/views/OrderManagement/adminOrder.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("confirm".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            OrderFileUtil.updateOrderStatus(orderId, "Success");
        }
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}

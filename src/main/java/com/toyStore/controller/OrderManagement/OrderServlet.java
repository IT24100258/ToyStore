package com.toyStore.controller.OrderManagement;

import com.toyStore.model.OrderManagement.Order;
import com.toyStore.model.PaymentManagement.PaymentMethod;
import com.toyStore.util.OrderManagement.OrderFileUtil;
import com.toyStore.util.PaymentManagement.PaymentMethodFileUtil;
import com.toyStore.model.Toymanagement.Toy;
import com.toyStore.model.Toymanagement.ToyLinkedList;
import com.toyStore.util.ToyManagement.ToyFileUtil;
import com.toyStore.model.UserManagement.User;
import com.toyStore.util.UserManagement.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("username") : null;
        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String toyIdStr = request.getParameter("toyId");
        int toyId = Integer.parseInt(toyIdStr);

        ToyLinkedList toyList = ToyFileUtil.loadToys();
        Toy toy = toyList.getToyById(toyId);

        List<PaymentMethod> paymentMethods = PaymentMethodFileUtil.loadPaymentMethods(username);

        request.setAttribute("toy", toy);
        request.setAttribute("paymentMethods", paymentMethods);
        request.getRequestDispatcher("/views/OrderManagement/order.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("username") : null;
        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int toyId = Integer.parseInt(request.getParameter("toyId"));
        String paymentMethodString = request.getParameter("paymentMethod");
        double price = Double.parseDouble(request.getParameter("price"));
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");

        User user = FileUtil.getUserByUsername(username);

        ToyLinkedList toyList = ToyFileUtil.loadToys();
        Toy toy = toyList.getToyById(toyId);

        PaymentMethod paymentMethod = null;
        List<PaymentMethod> paymentMethods = PaymentMethodFileUtil.loadPaymentMethods(username);
        for (PaymentMethod pm : paymentMethods) {
            String pmString = pm.getCardType() + " - " + pm.getCardNumber();
            if (pmString.equals(paymentMethodString)) {
                paymentMethod = pm;
                break;
            }
        }

        int orderId = OrderFileUtil.getNextOrderId();

        Order order = new Order(orderId, user, toy, paymentMethod, price, new Date(), "Pending");
        order.setAddress(address);
        order.setTelephone(telephone);
        order.setPaymentMethodString(paymentMethodString);

        OrderFileUtil.saveOrder(order);

        response.sendRedirect(request.getContextPath() + "/order?toyId=" + toyId + "&success=true");
    }
}

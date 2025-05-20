package com.toyStore.controller.PaymentManagement;

import com.toyStore.model.PaymentManagement.PaymentMethod;
import com.toyStore.util.PaymentManagement.PaymentMethodFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/paymentMethods")
public class PaymentMethodServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("username") : null;
        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        List<PaymentMethod> methods = PaymentMethodFileUtil.loadPaymentMethods(username);
        request.setAttribute("methods", methods);
        request.getRequestDispatcher("/views/PaymentManagement/paymentMethod.jsp").forward(request, response);
    }
}

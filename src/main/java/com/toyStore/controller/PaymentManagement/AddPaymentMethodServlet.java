package com.toyStore.controller.PaymentManagement;

import com.toyStore.model.PaymentManagement.PaymentMethod;
import com.toyStore.model.UserManagement.User;
import com.toyStore.util.PaymentManagement.PaymentMethodFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/addPaymentMethod")
public class AddPaymentMethodServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/PaymentManagement/addPaymentMethod.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        String cardHolder = request.getParameter("cardHolder");
        String cardNumber = request.getParameter("cardNumber");
        String expiryMonth = request.getParameter("expiryMonth");
        String expiryYear = request.getParameter("expiryYear");
        String cardType = request.getParameter("cardType");

        String maskedCardNumber = "**** **** **** " + cardNumber.substring(cardNumber.length() - 4);

        PaymentMethod method = new PaymentMethod(
                user.getUserName(), cardHolder, maskedCardNumber, expiryMonth, expiryYear, cardType
        );

        user.addPaymentMethod(method);

        PaymentMethodFileUtil.savePaymentMethod(method);

        response.sendRedirect(request.getContextPath() + "/paymentMethods");
    }
}

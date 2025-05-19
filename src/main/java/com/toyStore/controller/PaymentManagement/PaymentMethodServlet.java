package com.toyStore.controller.PaymentManagement;

import com.toyStore.model.PaymentManagement.PaymentMethod;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/paymentMethods")
public class PaymentMethodServlet extends HttpServlet {

    private static final String FILE_PATH = "payment_methods.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Load payment methods from file
        List<PaymentMethod> methods = loadPaymentMethods(username, request);

        // Set attributes and forward to JSP
        request.setAttribute("methods", methods);
        request.getRequestDispatcher("/views/PaymentManagement/paymentMethod.jsp").forward(request, response);
    }

    private List<PaymentMethod> loadPaymentMethods(String username, HttpServletRequest request) {
        List<PaymentMethod> methods = new ArrayList<>();
        File file = new File(request.getServletContext().getRealPath("/") + FILE_PATH);

        if (!file.exists()) {
            return methods;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 6 && parts[0].equals(username)) {
                    methods.add(new PaymentMethod(
                            parts[1], // cardHolder
                            parts[2], // cardNumber
                            parts[3], // expiryMonth
                            parts[4], // expiryYear
                            parts[5]  // cardType
                    ));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return methods;
    }
}

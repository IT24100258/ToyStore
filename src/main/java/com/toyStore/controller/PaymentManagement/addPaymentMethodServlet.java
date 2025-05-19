package com.toyStore.controller.PaymentManagement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/add")
public class addPaymentMethodServlet extends HttpServlet {

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

        // Forward to add payment method form
        request.getRequestDispatcher("/views/PaymentManagement/addPaymentMethod.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get form parameters
        String cardHolder = request.getParameter("cardHolder");
        String cardNumber = request.getParameter("cardNumber").replaceAll("\\s+", "");
        String expiryMonth = request.getParameter("expiryMonth");
        String expiryYear = request.getParameter("expiryYear");
        String cardType = request.getParameter("cardType");

        // Validate inputs
        if (cardHolder == null || cardHolder.trim().isEmpty() ||
                cardNumber == null || !cardNumber.matches("\\d{13,19}") ||
                expiryMonth == null || !expiryMonth.matches("(0[1-9]|1[0-2])") ||
                expiryYear == null || !expiryYear.matches("\\d{4}") ||
                cardType == null || cardType.isEmpty()) {

            request.setAttribute("error", "Invalid payment details. Please check your inputs.");
            request.getRequestDispatcher("/views/PaymentManagement/addPaymentMethod.jsp").forward(request, response);
            return;
        }

        // Save to file
        savePaymentMethod(username, cardHolder, cardNumber, expiryMonth, expiryYear, cardType, request);

        // Redirect to payment methods page
        response.sendRedirect(request.getContextPath() + "/paymentMethods");
    }

    private void savePaymentMethod(String username, String cardHolder, String cardNumber,
                                   String expiryMonth, String expiryYear, String cardType, HttpServletRequest request) {
        File file = new File(request.getServletContext().getRealPath("/") + FILE_PATH);

        try (PrintWriter writer = new PrintWriter(new FileWriter(file, true))) {
            // Format: username|cardHolder|cardNumber|expiryMonth|expiryYear|cardType
            writer.println(String.join("|",
                    username,
                    cardHolder,
                    cardNumber,
                    expiryMonth,
                    expiryYear,
                    cardType
            ));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

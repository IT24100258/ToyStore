package com.toyStore.controller.ReviewManagement;

import com.toyStore.model.Toymanagement.Toy;
import com.toyStore.model.Toymanagement.ToyLinkedList;
import com.toyStore.util.ToyManagement.ToyFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Toy ID is missing.");
            return;
        }

        try {
            int toyId = Integer.parseInt(idParam);
            ToyLinkedList toyList = ToyFileUtil.loadToys();
            Toy toy = toyList.getToyById(toyId);

            if (toy == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Toy not found.");
                return;
            }

            request.setAttribute("toy", toy);
            request.setAttribute("reviews", toy.getReviews());
            request.getRequestDispatcher("/views/ReviewManagement/Product.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Toy ID format.");
        }
    }
}

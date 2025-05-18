package com.toyStore.controller.ReviewManagement;
import com.toyStore.model.ReviewManagement.Review;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class SubmitReviewServlet extends HttpServlet {
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String product = request.getParameter("product");
        String text = request.getParameter("review");

        Review review = new Review(username, product, text);

        // Access application context
        ServletContext context = getServletContext();

        // Get or create the reviews list
        List<Review> reviews = (List<Review>) context.getAttribute("reviews");
        if (reviews == null) {
            reviews = new ArrayList<>();
        }

        // Add new review
        reviews.add(0, review); // add to top

        // Save back to context
        context.setAttribute("reviews", reviews);

        response.sendRedirect("review-management.jsp");
    }

    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext context = getServletContext();
        List<Review> reviews = (List<Review>) context.getAttribute("reviews");

        if (reviews == null) {
            reviews = new ArrayList<>();
        }

        request.setAttribute("reviews", reviews);
        RequestDispatcher dispatcher = request.getRequestDispatcher("review-management.jsp");
        dispatcher.forward(request, response);
    }
}

package com.toyStore.controller.ReviewManagement;

import com.toyStore.model.Toymanagement.Toy;
import com.toyStore.model.Toymanagement.ToyLinkedList;
import com.toyStore.model.UserManagement.User;
import com.toyStore.model.ReviewManagement.Review;
import com.toyStore.util.ToyManagement.ToyFileUtil;
import com.toyStore.util.ReviewManagement.ReviewFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/addReview")
public class AddReviewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String toyIdStr = request.getParameter("toyId");
        int toyId = 0;
        Toy toy = null;
        try {
            toyId = Integer.parseInt(toyIdStr);
            ToyLinkedList toyList = ToyFileUtil.loadToys();
            toy = toyList.getToyById(toyId);
        } catch (Exception e) {
            // ignore, toy will remain null
        }

        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("username") : "Guest";

        request.setAttribute("toyId", toyId);
        request.setAttribute("toyName", (toy != null) ? toy.getName() : "Unknown Toy");
        request.setAttribute("username", username);

        request.getRequestDispatcher("/views/ReviewManagement/addReview.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String toyIdStr = request.getParameter("toyId");
        String ratingStr = request.getParameter("rating");
        String content = request.getParameter("content");

        int toyId = 0;
        int rating = 0;
        String error = null;

        try {
            toyId = Integer.parseInt(toyIdStr);
        } catch (Exception e) {
            error = "Invalid toy selected.";
        }

        try {
            rating = Integer.parseInt(ratingStr);
            if (rating < 1 || rating > 5) throw new NumberFormatException();
        } catch (Exception e) {
            error = "Please select a valid rating.";
        }

        if (content == null || content.trim().isEmpty()) {
            error = "Please write your review before submitting.";
        }

        HttpSession session = request.getSession(false);
        User reviewer = (session != null) ? (User) session.getAttribute("user") : null;
        String username = (session != null) ? (String) session.getAttribute("username") : "Guest";

        ToyLinkedList toyList = ToyFileUtil.loadToys();
        Toy toy = toyList.getToyById(toyId);

        if (error != null || toy == null || reviewer == null) {
            // Prepare for redisplay
            request.setAttribute("error", error != null ? error : "Invalid input.");
            request.setAttribute("toyId", toyId);
            request.setAttribute("toyName", toy != null ? toy.getName() : "Unknown Toy");
            request.setAttribute("username", username);
            request.setAttribute("content", content);
            request.setAttribute("rating", ratingStr);
            request.getRequestDispatcher("/views/ReviewManagement/addReview.jsp").forward(request, response);
            return;
        }

        // Save review
        Review review = new Review(toy, reviewer, content, rating);
        ReviewFileUtil.saveReview(review);

        response.sendRedirect(request.getContextPath() + "/product?id=" + toyId);
    }
}

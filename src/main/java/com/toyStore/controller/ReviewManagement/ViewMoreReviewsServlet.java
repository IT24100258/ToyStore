package com.toyStore.controller.ReviewManagement;

import com.toyStore.model.Toymanagement.Toy;
import com.toyStore.model.Toymanagement.ToyLinkedList;
import com.toyStore.model.ReviewManagement.Review;
import com.toyStore.util.ToyManagement.ToyFileUtil;
import com.toyStore.util.ReviewManagement.ReviewFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/viewMoreReviews")
public class ViewMoreReviewsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String toyIdStr = request.getParameter("toyId");
        int toyId = 0;
        Toy toy = null;
        List<Review> reviews = null;

        try {
            toyId = Integer.parseInt(toyIdStr);

            ToyLinkedList toyList = ToyFileUtil.loadToys();
            toy = toyList.getToyById(toyId);

            reviews = ReviewFileUtil.loadReviewsForToy(toy);

        } catch (Exception e) {
        }

        request.setAttribute("toy", toy);
        request.setAttribute("reviews", reviews);
        request.getRequestDispatcher("/views/ReviewManagement/viewMoreReview.jsp").forward(request, response);
    }
}

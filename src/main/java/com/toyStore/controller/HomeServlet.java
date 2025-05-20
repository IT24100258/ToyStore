package com.toyStore.controller;

import com.toyStore.model.Toymanagement.ToyLinkedList;
import com.toyStore.util.ToyManagement.ToyFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ToyLinkedList toyList = ToyFileUtil.loadToys();
        request.setAttribute("toys", toyList.toList());
        request.getRequestDispatcher("/views/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String order = request.getParameter("order");
        ToyLinkedList toyList = ToyFileUtil.loadToys();

        if ("sortByAgeGroup".equals(action)) {
            toyList.selectionSortByAgeGroup();
            if ("desc".equalsIgnoreCase(order)) {
                toyList.reverse();
            }
            request.setAttribute("message", "Toys sorted by age group " + ("desc".equalsIgnoreCase(order) ? "↓" : "↑"));
        }

        request.setAttribute("toys", toyList.toList());
        request.getRequestDispatcher("/views/home.jsp").forward(request, response);
    }
}

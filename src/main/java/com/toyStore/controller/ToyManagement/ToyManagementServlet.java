package com.toyStore.controller.ToyManagement;

import com.toyStore.model.Toymanagement.Toy;
import com.toyStore.model.Toymanagement.ToyLinkedList;
import com.toyStore.util.ToyManagement.ToyFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;

@WebServlet("/views/admin/toyManagement")
@MultipartConfig
public class ToyManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ToyLinkedList toyList = getToyList();
        request.setAttribute("toys", toyList.toList());

        String view = request.getParameter("view");
        if ("home".equalsIgnoreCase(view)) {
            request.getRequestDispatcher("/views/home.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/views/admin/ToyManagement/inventory.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        ToyLinkedList toyList = getToyList();

        if ("add".equals(action) || action == null) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                int ageGroup = Integer.parseInt(request.getParameter("ageGroup"));
                double price = Double.parseDouble(request.getParameter("price"));

                Part imagePart = request.getPart("image");
                String imagePath = "";
                if (imagePart != null && imagePart.getSize() > 0) {
                    String fileName = System.currentTimeMillis() + "_" + Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                    String uploadDir = getServletContext().getRealPath("/images/Products");
                    File uploadFolder = new File(uploadDir);
                    if (!uploadFolder.exists()) uploadFolder.mkdirs();
                    File imageFile = new File(uploadFolder, fileName);
                    try (InputStream input = imagePart.getInputStream()) {
                        Files.copy(input, imageFile.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                    }
                    imagePath = "images/Products/" + fileName;
                }

                toyList.insertToy(id, name, description, ageGroup, price, imagePath);
                ToyFileUtil.saveToys(toyList);
                request.setAttribute("message", "Toy added successfully.");
            } catch (Exception e) {
                request.setAttribute("message", "Error adding toy: " + e.getMessage());
            }
        } else if ("remove".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                ToyFileUtil.removeToyById(toyList,id);
                request.setAttribute("message", "Toy removed successfully.");
            } catch (Exception e) {
                request.setAttribute("message", "Error removing toy: " + e.getMessage());
            }
        }else if ("sortByAgeGroup".equals(action)) {
            toyList.selectionSortByAgeGroup();
            ToyFileUtil.saveToys(toyList);
            request.setAttribute("message", "Toys sorted by age group.");
        }

        ToyLinkedList updatedList = getToyList();
        request.setAttribute("toys", updatedList.toList());
        request.getRequestDispatcher("/views/admin/ToyManagement/inventory.jsp").forward(request, response);
    }

    private ToyLinkedList getToyList() {
        return ToyFileUtil.loadToys();
    }
}

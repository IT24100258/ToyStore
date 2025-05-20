package com.toyStore.util.ReviewManagement;

import com.toyStore.model.ReviewManagement.Review;
import com.toyStore.model.Toymanagement.Toy;
import com.toyStore.model.UserManagement.User;
import com.toyStore.util.UserManagement.FileUtil;

import java.io.*;
import java.util.*;

public class ReviewFileUtil {
    private static final String REVIEW_FILE_PATH = "data/reviews.txt";

    // Save a review to file
    public static void saveReview(Review review) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(REVIEW_FILE_PATH, true))) {
            writer.write(
                    review.getToyId() + "," +
                            review.getReviewer().getId() + "," +
                            review.getReviewer().getUserName() + "," +
                            review.getContent().replace(",", ";") + "," +
                            review.getRating()
            );
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Load reviews for a specific toy
    public static List<Review> loadReviewsForToy(Toy toy) {
        List<Review> reviews = new ArrayList<>();
        File file = new File(REVIEW_FILE_PATH);
        if (!file.exists()) return reviews;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",", 5);
                if (data.length == 5) {
                    int toyId = Integer.parseInt(data[0]);
                    if (toyId == toy.getId()) {
                        int reviewerId = Integer.parseInt(data[1]);
                        String reviewerName = data[2];
                        String content = data[3].replace(";", ",");
                        int rating = Integer.parseInt(data[4]);
                        // Use the local getUserById method
                        User reviewer = getUserById(reviewerId, reviewerName);
                        if (reviewer != null) {
                            reviews.add(new Review(toy, reviewer, content, rating));
                        }
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    // Use this method for user lookup
    private static User getUserById(int userId, String userName) {
        for (User user : FileUtil.getUsers()) {
            if (user.getId() == userId && user.getUserName().equals(userName)) {
                return user;
            }
        }
        return null;
    }
}

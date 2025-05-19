package com.toyStore.model.Toymanagement;

import com.toyStore.model.ReviewManagement.Review;
import com.toyStore.model.UserManagement.User;
import com.toyStore.util.ReviewManagement.ReviewFileUtil;

import java.util.ArrayList;
import java.util.List;

public class Toy {
    private int id;
    private String name;
    private String description;
    private int ageGroup;
    private double price;
    private String imagePath;
    private List<Review> reviews;
    public Toy next;

    public Toy(int id, String name, String description, int ageGroup, double price, String imagePath) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.ageGroup = ageGroup;
        this.price = price;
        this.imagePath = imagePath;
        this.reviews = new ArrayList<>();
        this.next = null;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String category) {
        this.description = category;
    }

    public int getAgeGroup() {
        return ageGroup;
    }

    public void setAgeGroup(int ageGroup) {
        this.ageGroup = ageGroup;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public Review createReview(User reviewer, String content, int rating) {
        return new Review(this, reviewer, content, rating);
    }

    public List<Review> getReviews() {
        return ReviewFileUtil.loadReviewsForToy(this);
    }

    public void displayToy() {
        System.out.println("ID: " + id + ", Name: " + name + ", Age: " + ageGroup + "+, Price: $" + price);
    }
}

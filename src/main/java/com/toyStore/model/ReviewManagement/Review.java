package com.toyStore.model.ReviewManagement;

import com.toyStore.model.Toymanagement.Toy;
import com.toyStore.model.UserManagement.User;

public class Review {
    private Toy toy;
    private User reviewer;
    private String content;
    private int rating; // Add rating if you want star ratings

    public Review(Toy toy, User reviewer, String content, int rating) {
        this.toy = toy;
        this.reviewer = reviewer;
        this.content = content;
        this.rating = rating;
    }

    public Toy getToy() { return toy; }
    public int getToyId() { return toy.getId(); }
    public User getReviewer() { return reviewer; }
    public String getContent() { return content; }
    public int getRating() { return rating; }
}

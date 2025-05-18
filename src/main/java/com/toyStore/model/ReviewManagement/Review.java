package com.toyStore.model.ReviewManagement;

public class Review {
    private String username;
    private String product;
    private String text;

    public Review(String username, String product, String text) {
        this.username = username;
        this.product = product;
        this.text = text;
    }

    public String getUsername() {
        return username;
    }

    public String getProduct() {
        return product;
    }

    public String getText() {
        return text;
    }
}

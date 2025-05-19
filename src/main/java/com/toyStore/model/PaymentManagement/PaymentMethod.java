package com.toyStore.model.PaymentManagement;

public class PaymentMethod {
    private String cardHolder;
    private String cardNumber;
    private String expiryMonth;
    private String expiryYear;
    private String cardType;

    public PaymentMethod(String cardHolder, String cardNumber, String expiryMonth,
                         String expiryYear, String cardType) {
        this.cardHolder = cardHolder;
        this.cardNumber = cardNumber;
        this.expiryMonth = expiryMonth;
        this.expiryYear = expiryYear;
        this.cardType = cardType;
    }

    // Getters
    public String getCardHolder() {
        return cardHolder;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public String getExpiryMonth() {
        return expiryMonth;
    }

    public String getExpiryYear() {
        return expiryYear;
    }

    public String getCardType() {
        return cardType;
    }
}
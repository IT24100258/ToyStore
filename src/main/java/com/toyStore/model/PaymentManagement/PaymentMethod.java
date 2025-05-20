package com.toyStore.model.PaymentManagement;

public class PaymentMethod {
    private String userName;
    private String cardHolder;
    private String cardNumber;
    private String expiryMonth;
    private String expiryYear;
    private String cardType;

    public PaymentMethod(String userName, String cardHolder, String cardNumber, String expiryMonth, String expiryYear, String cardType) {
        this.userName = userName;
        this.cardHolder = cardHolder;
        this.cardNumber = cardNumber;
        this.expiryMonth = expiryMonth;
        this.expiryYear = expiryYear;
        this.cardType = cardType;
    }

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

    public String getUserName() {
        return userName;
    }
}

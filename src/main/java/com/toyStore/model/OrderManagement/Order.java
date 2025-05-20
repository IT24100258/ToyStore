package com.toyStore.model.OrderManagement;

import com.toyStore.model.UserManagement.User;
import com.toyStore.model.PaymentManagement.PaymentMethod;
import com.toyStore.model.Toymanagement.Toy;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Order implements Serializable {
    private int orderId;
    private User user;
    private Toy toy;
    private PaymentMethod paymentMethod;
    private double totalAmount;
    private Date orderDate;
    private String status;
    private String address;
    private String telephone;


    private String paymentMethodString;


    public Order(int orderId, User user, Toy toy, PaymentMethod paymentMethod,
                 double totalAmount, Date orderDate, String status) {
        this.orderId = orderId;
        this.user = user;
        this.toy = toy;
        this.paymentMethod = paymentMethod;
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
        this.status = status;
        this.address = user.getAddress();
        this.telephone = user.getPhoneNumber();
        if (paymentMethod != null) {
            this.paymentMethodString = paymentMethod.getCardType() + " - " + paymentMethod.getCardNumber();
        }
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getUser() {
        return user;
    }

    public Toy getToy() {
        return toy;
    }

    public void setToy(Toy toy) {
        this.toy = toy;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
        if (paymentMethod != null) {
            this.paymentMethodString = paymentMethod.getCardType() + " - " + paymentMethod.getCardNumber();
        }
    }

    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }

    public int getOrderId() { return orderId; }

    public String getPaymentMethodString() {
        return paymentMethodString;
    }

    public void setPaymentMethodString(String paymentMethodString) {
        this.paymentMethodString = paymentMethodString;
    }

    public double getTotalAmount() { return totalAmount; }

    public Date getOrderDate() { return orderDate; }

    public String getStatus() { return status; }

    public void setStatus(String status) { this.status = status; }

    public String getAddress() { return address; }

    public void setAddress(String address) { this.address = address; }

    public String getTelephone() { return telephone; }

    public void setTelephone(String telephone) { this.telephone = telephone; }


}

package com.toyStore.model.UserManagement;

import com.toyStore.model.OrderManagement.Order;
import com.toyStore.model.PaymentManagement.PaymentMethod;

import java.util.ArrayList;
import java.util.List;

public class User {
    private int id;
    protected String userName;
    protected String password;
    protected String email;
    protected String phoneNumber;
    protected String address;
    private String role;

    private List<PaymentMethod> paymentMethods = new ArrayList<>();
    private List<Order> orders = new ArrayList<>();


    public User(String userName, String password, String email, String phoneNumber, String address) {
        this.userName = userName;
        this.password = password;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.role = "customer";
    }

    public User(int id, String userName, String password, String email, String phoneNumber, String address, String role) {
        this.id = id;
        this.userName = userName;
        this.password = password;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public List<PaymentMethod> getPaymentMethods() {
        return paymentMethods;
    }

    public void addPaymentMethod(PaymentMethod method) {
        if (method != null) {
            this.paymentMethods.add(method);
        }
    }

    public List<Order> getOrders() {
        return orders;
    }

    public void addOrder(Order order) {
        if (order != null) {
            this.orders.add(order);
        }
    }
}

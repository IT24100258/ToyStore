package com.toyStore.model.UserManagement;

public class Admin extends User{
    public Admin(String userName, String password, String email, String phoneNumber, String address){
        super(userName, password, email, phoneNumber, address);
        this.setRole("admin");
    }

    public Admin(int id, String userName, String password, String email, String phoneNumber, String address, String role) {
        super(id, userName, password, email, phoneNumber, address, role);
    }
}

package com.toyStore.service.AdminManagement;

import com.toyStore.model.UserManagement.User;
import com.toyStore.util.adminManegment.AdminFileUtil;

public class AdminService {
    public boolean registerAdmin(User admin) {
        try {
            AdminFileUtil.saveAdmin(admin);
            return true;
        } catch (Exception e) {
            System.err.println("Failed to register admin: " + e.getMessage());
            return false;
        }
    }
}

package com.toyStore.service.UserManagement;

import com.toyStore.model.UserManagement.Admin;
import com.toyStore.model.UserManagement.User;
import com.toyStore.util.UserManagement.FileUtil;

import java.io.IOException;

public class UserService {
    public void registerUser(User user) throws IOException {
        FileUtil.saveUser(user);
    }

//    public void registerAdmin(Admin admin) throws IOException {
//        FileUtil.saveUser(admin);
//    }
}

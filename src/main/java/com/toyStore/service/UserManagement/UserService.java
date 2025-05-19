package com.toyStore.service.UserManagement;

import com.toyStore.model.UserManagement.User;
import com.toyStore.util.UserManagement.FileUtil;

import java.io.IOException;

public class UserService {
    public void registerUser(User user) throws IOException {
        FileUtil.saveUser(user);
    }
}

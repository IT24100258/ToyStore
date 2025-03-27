package com.toyStore.service;

import com.toyStore.model.User;
import com.toyStore.util.FileUtil;

import java.io.IOException;

public class UserService {
    public void registerUser(User user) throws IOException {
        FileUtil.saveUser(user);
    }
}

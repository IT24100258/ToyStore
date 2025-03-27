package com.toyStore.util;

import com.toyStore.model.User;

import java.io.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class FileUtil {
    private static final String USER_FILE_PATH = "data/users.txt";
    private static final String ADMIN_FILE_PATH = "data/admins.txt";
    private static final String SECRET_KEY = ConfigUtil.getProperty();

    private static File getUserFile(String role) {
        String filePath = "customer".equals(role) ? USER_FILE_PATH : ADMIN_FILE_PATH;
        File file = new File(filePath);

        System.out.println("User file absolute path: " + file.getAbsolutePath());

        if (!file.exists()) {
            file.getParentFile().mkdirs();
            try {
                file.createNewFile();
            } catch (IOException e) {
                System.err.println("Error creating user file: " + e.getMessage());
            }
        }
        return file;
    }

    private static int getNextUserId(String role) {
        File file = getUserFile(role);
        int lastId = 0;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length > 0) {
                    try {
                        lastId = Math.max(lastId, Integer.parseInt(data[0]));
                    } catch (NumberFormatException ignored) {
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading user file: " + e.getMessage());
        }

        return lastId + 1;
    }

    public static synchronized void saveUser(User user) throws IOException {
        File file = getUserFile(user.getRole());
        int userId = getNextUserId(user.getRole());
        String encryptedPassword = encrypt(user.getPassword());

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
            writer.write(userId + "," + user.getUserName() + "," + encryptedPassword + "," + user.getEmail() + "," +
                    user.getPhoneNumber() + "," + user.getAddress() + "," + user.getRole());
            writer.newLine();
            System.out.println("User saved to " + file.getAbsolutePath());
        } catch (IOException e) {
            System.err.println("Error saving user: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static List<User> getUsers(String role) {
        List<User> users = new ArrayList<>();
        File file = getUserFile(role);

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 7) {
                    String decryptedPassword = decrypt(data[2]);
                    users.add(new User(
                            Integer.parseInt(data[0]),
                            data[1],
                            decryptedPassword,
                            data[3],
                            data[4],
                            data[5],
                            data[6]
                    ));
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading user file: " + e.getMessage());
        }

        return users;
    }

    public static User getUser(String email, String password) {
        for (User user : getUsers("customer")) {
            if (user.getEmail().equals(email) && user.getPassword().equals(password)) {
                return user;
            }
        }

        for (User user : getUsers("admin")) {
            if (user.getEmail().equals(email) && user.getPassword().equals(password)) {
                return user;
            }
        }

        return null;
    }

    private static String encrypt(String data) {
        if (data == null) return null;

        if (SECRET_KEY == null || SECRET_KEY.isEmpty()) {
            throw new IllegalStateException("Secret key is null or empty");
        }

        byte[] dataBytes = data.getBytes();
        byte[] keyBytes = SECRET_KEY.getBytes();
        byte[] encrypted = new byte[dataBytes.length];

        for (int i = 0; i < dataBytes.length; i++) {
            encrypted[i] = (byte) (dataBytes[i] ^ keyBytes[i % keyBytes.length]);
        }

        return Base64.getEncoder().encodeToString(encrypted);
    }

    private static String decrypt(String encryptedData) {
        if (encryptedData == null) return null;

        try {
            byte[] encryptedBytes = Base64.getDecoder().decode(encryptedData);
            byte[] keyBytes = SECRET_KEY.getBytes();
            byte[] decrypted = new byte[encryptedBytes.length];

            for (int i = 0; i < encryptedBytes.length; i++) {
                decrypted[i] = (byte) (encryptedBytes[i] ^ keyBytes[i % keyBytes.length]);
            }

            return new String(decrypted);
        } catch (IllegalArgumentException e) {
            System.err.println("Error decoding Base64 string: " + e.getMessage());
            return null;
        }
    }
}
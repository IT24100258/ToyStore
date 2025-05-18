package com.toyStore.util.adminManegment;

import com.toyStore.model.UserManagement.User;
import com.toyStore.util.UserManagement.ConfigUtil;

import java.io.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class AdminFileUtil {
    private static final String ADMIN_FILE_PATH = "data/admins.txt";
    private static final String SECRET_KEY = ConfigUtil.getProperty();

    private static File getAdminFile() {
        File file = new File(ADMIN_FILE_PATH);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            try {
                file.createNewFile();
            } catch (IOException e) {
                System.err.println("Error creating admin file: " + e.getMessage());
            }
        }
        return file;
    }

    private static int getNextAdminId() {
        File file = getAdminFile();
        int lastId = 0;
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length > 0) {
                    try {
                        lastId = Math.max(lastId, Integer.parseInt(data[0]));
                    } catch (NumberFormatException ignored) {}
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading admin file: " + e.getMessage());
        }
        return lastId + 1;
    }

    public static synchronized void saveAdmin(User admin) throws IOException {
        File file = getAdminFile();
        int adminId = getNextAdminId();
        String encryptedPassword = encrypt(admin.getPassword());
        String safeAddress = admin.getAddress() != null ? admin.getAddress().replace(",", ";") : "";
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
            writer.write(adminId + "," + admin.getUserName() + "," + encryptedPassword + "," +
                    admin.getEmail() + "," + admin.getPhoneNumber() + "," + safeAddress + "," + admin.getRole());
            writer.newLine();
        }
    }

    public static List<User> getAdmins() {
        List<User> admins = new ArrayList<>();
        File file = getAdminFile();
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 7) {
                    String decryptedPassword = decrypt(data[2]);
                    String restoredAddress = data[5] != null ? data[5].replace(";", ",") : "";
                    admins.add(new User(
                            Integer.parseInt(data[0]),
                            data[1],
                            decryptedPassword,
                            data[3],
                            data[4],
                            restoredAddress,
                            data[6]
                    ));
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading admin file: " + e.getMessage());
        }
        return admins;
    }

    public static User getAdmin(String email, String password) {
        for (User admin : getAdmins()) {
            if (admin.getEmail().equals(email) && admin.getPassword().equals(password)) {
                return admin;
            }
        }
        return null;
    }


    public static boolean updateAdmin(String email, String newUsername, String newPassword, String newPhoneNumber, String newAddress) {
        List<String> updatedLines = new ArrayList<>();
        boolean isUpdated = false;
        File file = getAdminFile();
        try (BufferedReader r = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = r.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 7 && data[3].equals(email)) {
                    data[1] = newUsername;
                    if (newPassword != null && !newPassword.isEmpty()) {
                        data[2] = encrypt(newPassword);
                    }
                    data[4] = newPhoneNumber;
                    data[5] = (newAddress != null) ? newAddress.replace(",", ";") : "";
                    isUpdated = true;
                }
                updatedLines.add(String.join(",", data));
            }
        } catch (IOException e) {
            System.err.println("Error reading admin file: " + e.getMessage());
            return false;
        }
        if (isUpdated) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
                for (String updatedLine : updatedLines) {
                    writer.write(updatedLine);
                    writer.newLine();
                }
                return true;
            } catch (IOException e) {
                System.err.println("Error writing to admin file: " + e.getMessage());
                return false;
            }
        }
        return false;
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

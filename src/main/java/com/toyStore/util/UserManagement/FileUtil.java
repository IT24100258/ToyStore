package com.toyStore.util.UserManagement;

import com.toyStore.model.UserManagement.User;

import java.io.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class FileUtil {
    private static final String USER_FILE_PATH = "data/users.txt";
    private static final String SECRET_KEY = ConfigUtil.getProperty();

    private static File getUserFile() {
        File file = new File(USER_FILE_PATH);

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

    private static int getNextUserId() {
        File file = getUserFile();
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
        File file = getUserFile();
        int userId = getNextUserId();
        String encryptedPassword = encrypt(user.getPassword());
        String safeAddress = user.getAddress() != null ? user.getAddress().replace(",", ";") : "";
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
            writer.write(userId + "," + user.getUserName() + "," + encryptedPassword + "," + user.getEmail() + "," +
                    user.getPhoneNumber() + "," + safeAddress + "," + user.getRole());
            writer.newLine();
            System.out.println("User saved to " + file.getAbsolutePath());
        } catch (IOException e) {
            System.err.println("Error saving user: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static List<User> getUsers() {
        List<User> users = new ArrayList<>();
        File file = getUserFile();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 7) {
                    String decryptedPassword = decrypt(data[2]);
                    String restoredAddress = data[5] != null ? data[5].replace(";", ",") : "";
                    users.add(new User(
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
            System.err.println("Error reading user file: " + e.getMessage());
        }

        return users;
    }

    public static User getUser(String email, String password) {
        for (User user : getUsers()) {
            if (user.getEmail().equals(email) && user.getPassword().equals(password)) {
                return user;
            }
        }
        return null;
    }

    public static boolean removeUser(String email){
        File customerFile = getUserFile();
        return removeUserFromFile(customerFile, email);
    }

    private static boolean removeUserFromFile(File file, String email) {
        List<String> updatedLines = new ArrayList<>();
        boolean userFound = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 4 && data[3].equals(email)) {
                    userFound = true;
                    continue;
                }
                updatedLines.add(line);
            }
        } catch (IOException e) {
            System.err.println("Error reading user file: " + e.getMessage());
            return false;
        }

        if (userFound) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
                for (String updatedLine : updatedLines) {
                    writer.write(updatedLine);
                    writer.newLine();
                }
                System.out.println("Customer with email " + email + " removed successfully.");
                return true;
            } catch (IOException e) {
                System.err.println("Error writing to user file: " + e.getMessage());
                return false;
            }
        } else {
            System.out.println("Customer with email " + email + " not found.");
            return false;
        }
    }

    public static User getUserByUsername(String username) {
        for (User user : getUsers()) {
            if (user.getUserName().equals(username)) {
                return user;
            }
        }
        return null;
    }

    public static boolean updateUser(String email, String newUsername, String newPassword, String newPhoneNumber, String newAddress){
        List<String> updatedLines = new ArrayList<>();
        boolean isUpdated = false;

        File file = getUserFile();
        try(BufferedReader r = new BufferedReader(new FileReader(file))){
            String line;
            while((line = r.readLine()) != null){
                String[] data = line.split(",");
                if (data.length == 7 && data[3].equals(email)){
                    data[1] = newUsername;
                    if(newPassword != null && !newPassword.isEmpty()){
                        data[2] = encrypt(newPassword);
                    }
                    data[4] = newPhoneNumber;
                    data[5] = (newAddress != null) ? newAddress.replace(",", ";") : "";
                    isUpdated = true;
                }
                updatedLines.add(String.join(",", data));
            }
        }catch(IOException e){
            System.err.println("Error reading files: " + e.getMessage());
            return false;
        }

        if(isUpdated){
            try(BufferedWriter writer = new BufferedWriter(new FileWriter(file))){
                for (String updatedLine : updatedLines) {
                    writer.write(updatedLine);
                    writer.newLine();
                }
                return true;
            }catch(IOException e){
                System.err.println("Error writing to user file: " + e.getMessage());
                return false;
            }
        }
        return false;
    }

    public static String encrypt(String data) {
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

    public static String decrypt(String encryptedData) {
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

package com.toyStore.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class ConfigUtil {
    private static Properties prop = new Properties();

    static {
        try(FileInputStream fis = new FileInputStream("C:/Users/Tuf/Desktop/SLIIT/Y1S2/Object Oriented Programming Module/OOP project/Test/demo/src/main/resources/config.properties")) {
            prop.load(fis);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private static String formatKey(String key) {
        if (key == null) {
            throw new RuntimeException("Error encrypting password");
        }

        int length = key.length();

        if (length < 16) {
            return String.format("%-16s", key).replace(' ', '0'); // Pad with zeros
        } else if (length > 16) {
            return key.substring(0, 16); // Trim to 16 characters
        }

        return key;
    }

    public static String getProperty() {
        String rawKey = prop.getProperty("AES_SECRET_KEY");
        return formatKey(rawKey);
    }
}

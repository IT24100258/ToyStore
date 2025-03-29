package com.toyStore.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class ConfigUtil {
    private static Properties prop = new Properties();

    static {
        try (java.io.InputStream inputStream = ConfigUtil.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (inputStream == null) {
                throw new RuntimeException("config.properties file not found");
            }
            prop.load(inputStream);
        } catch (IOException e) {
            throw new RuntimeException("Error loading config.properties", e);
        }

    }

    private static String formatKey(String key) {
        if (key == null) {
            throw new RuntimeException("Error encrypting password");
        }

        int length = key.length();

        if (length < 16) {
            return String.format("%-16s", key).replace(' ', '0');
        } else if (length > 16) {
            return key.substring(0, 16);
        }

        return key;
    }

    public static String getProperty() {
        String rawKey = prop.getProperty("AES_SECRET_KEY");
        return formatKey(rawKey);
    }
}

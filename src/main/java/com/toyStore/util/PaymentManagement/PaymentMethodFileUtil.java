package com.toyStore.util.PaymentManagement;

import com.toyStore.model.PaymentManagement.PaymentMethod;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentMethodFileUtil {
    private static final String FILE_PATH = "data/payment_methods.txt";

    public static List<PaymentMethod> loadPaymentMethods(String username) {
        List<PaymentMethod> list = new ArrayList<>();
        File file = new File(FILE_PATH);
        if (!file.exists()) return list;
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",", -1);
                if (data.length == 6 && data[0].equals(username)) {
                    list.add(new PaymentMethod(
                            data[0], data[1], data[2], data[3], data[4], data[5]
                    ));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void savePaymentMethod(PaymentMethod method) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(String.join(",", method.getUserName(),
                    method.getCardHolder(),
                    method.getCardNumber(),
                    method.getExpiryMonth(),
                    method.getExpiryYear(),
                    method.getCardType()));
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

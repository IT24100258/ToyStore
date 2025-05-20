package com.toyStore.util.OrderManagement;

import com.toyStore.model.OrderManagement.Order;
import com.toyStore.model.Toymanagement.Toy;
import com.toyStore.model.UserManagement.User;
import com.toyStore.model.PaymentManagement.PaymentMethod;
import com.toyStore.util.ToyManagement.ToyFileUtil;
import com.toyStore.util.UserManagement.FileUtil;
import com.toyStore.util.PaymentManagement.PaymentMethodFileUtil;
import com.toyStore.model.Toymanagement.ToyLinkedList;

import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderFileUtil {
    private static final String FILE_PATH = "data/orders.txt";

    public static List<Order> loadOrders() {
        List<Order> orders = new ArrayList<>();
        File file = new File(FILE_PATH);
        if (!file.exists()) return orders;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while((line = reader.readLine()) != null) {
                String[] data = line.split(",", -1);
                if (data.length == 9) {
                    int orderId = Integer.parseInt(data[0]);
                    String username = data[1];
                    int toyId = Integer.parseInt(data[2]);
                    String paymentMethodString = data[3];
                    double totalAmount = Double.parseDouble(data[4]);
                    Date orderDate = new Date(Long.parseLong(data[5]));
                    String status = data[6];
                    String address = data[7].replace(";", ",");
                    String telephone = data[8].replace(";", ",");

                    User user = FileUtil.getUserByUsername(username);
                    ToyLinkedList toyList = ToyFileUtil.loadToys();
                    Toy toy = toyList.getToyById(toyId);

                    PaymentMethod paymentMethod = null;
                    if (user != null) {
                        List<PaymentMethod> paymentMethods = PaymentMethodFileUtil.loadPaymentMethods(user.getUserName());
                        for (PaymentMethod pm : paymentMethods) {
                            String pmString = pm.getCardType() + " - " + pm.getCardNumber();
                            if (pmString.equals(paymentMethodString)) {
                                paymentMethod = pm;
                                break;
                            }
                        }
                    }

                    Order order = new Order(orderId, user, toy, paymentMethod, totalAmount, orderDate, status);
                    order.setAddress(address);
                    order.setTelephone(telephone);
                    order.setPaymentMethodString(paymentMethodString);

                    orders.add(order);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public static void saveOrder(Order order) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            String safeAddress = order.getAddress() != null ? order.getAddress().replace(",", ";") : "";
            String safeTelephone = order.getTelephone() != null ? order.getTelephone().replace(",", ";") : "";
            String paymentMethodString = order.getPaymentMethodString();

            writer.write(order.getOrderId() + "," +
                    order.getUser().getUserName() + "," +
                    order.getToy().getId() + "," +
                    paymentMethodString + "," +
                    order.getTotalAmount() + "," +
                    order.getOrderDate().getTime() + "," +
                    order.getStatus() + "," +
                    safeAddress + "," +
                    safeTelephone);
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static int getNextOrderId() {
        List<Order> orders = loadOrders();
        int maxId = 0;
        for (Order o : orders) {
            if (o.getOrderId() > maxId) maxId = o.getOrderId();
        }
        return maxId + 1;
    }

    public static List<Order> getOrdersByUsername(String username) {
        List<Order> allOrders = loadOrders();
        List<Order> userOrders = new ArrayList<>();
        for (Order order : allOrders) {
            if (order.getUser() != null && order.getUser().getUserName().equals(username)) {
                userOrders.add(order);
            }
        }
        return userOrders;
    }

    public static void updateOrderStatus(int orderId, String newStatus) {
        List<Order> orders = loadOrders();
        for (Order order : orders) {
            if (order.getOrderId() == orderId) {
                order.setStatus(newStatus);
                break;
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Order order : orders) {
                String safeAddress = order.getAddress() != null ? order.getAddress().replace(",", ";") : "";
                String safeTelephone = order.getTelephone() != null ? order.getTelephone().replace(",", ";") : "";
                String paymentMethodString = order.getPaymentMethodString();

                writer.write(order.getOrderId() + "," +
                        order.getUser().getUserName() + "," +
                        order.getToy().getId() + "," +
                        paymentMethodString + "," +
                        order.getTotalAmount() + "," +
                        order.getOrderDate().getTime() + "," +
                        order.getStatus() + "," +
                        safeAddress + "," +
                        safeTelephone);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

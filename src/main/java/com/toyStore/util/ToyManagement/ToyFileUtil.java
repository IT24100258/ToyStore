package com.toyStore.util.ToyManagement;

import com.toyStore.model.Toymanagement.Toy;
import com.toyStore.model.Toymanagement.ToyLinkedList;

import java.io.*;

public class ToyFileUtil {
    private static final String TOY_FILE_PATH = "data/toys.txt";

    public static ToyLinkedList loadToys() {
        ToyLinkedList list = new ToyLinkedList();
        File file = new File(TOY_FILE_PATH);
        if (!file.exists()) return list;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",", -1);
                if (data.length >= 6) {
                    int id = Integer.parseInt(data[0]);
                    String name = data[1];
                    String description = data[2].replace(";", ",");
                    int ageGroup = Integer.parseInt(data[3]);
                    double price = Double.parseDouble(data[4]);
                    String imagePath = data[5];
                    list.insertToy(id, name, description, ageGroup, price, imagePath);
                }
            }
        } catch (IOException e) {
            System.err.println("Error loading toys: " + e.getMessage());
        }
        return list;
    }

    public static void saveToys(ToyLinkedList list) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(TOY_FILE_PATH))) {
            Toy current = list.getFirst();
            while (current != null) {
                String safeDescription = current.getDescription() != null ? current.getDescription().replace(",", ";") : "";
                writer.write(current.getId() + "," +
                        current.getName() + "," +
                        safeDescription + "," +
                        current.getAgeGroup() + "," +
                        current.getPrice() + "," +
                        (current.getImagePath() == null ? "" : current.getImagePath()));
                writer.newLine();
                current = current.next;
            }
        } catch (IOException e) {
            System.err.println("Error saving toys: " + e.getMessage());
        }
    }

    public static void removeToyById(ToyLinkedList list, int id) {
        list.delete(id);
        saveToys(list);
    }
}

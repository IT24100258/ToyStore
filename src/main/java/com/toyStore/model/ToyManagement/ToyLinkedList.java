package com.toyStore.model.Toymanagement;

import java.util.ArrayList;
import java.util.List;

public class ToyLinkedList {
    private static ToyLinkedList instance;
    private Toy first;

    public ToyLinkedList() {
        this.first = null;
    }

    public static ToyLinkedList getInstance() {
        if (instance == null) {
            instance = new ToyLinkedList();
        }
        return instance;
    }

    public boolean isEmpty() {
        return first == null;
    }

    public void insertToy(int id, String name, String description, int ageGroup, double price, String imagePath) {
        Toy newToy = new Toy(id, name, description, ageGroup, price, imagePath);
        newToy.next = first;
        first = newToy;
    }

    public void deleteFirst() {
        if (isEmpty()) {
            System.out.println("List is empty. Nothing to delete.");
            return;
        }

        first = first.next;
    }

    public void delete(int key) {
        if (isEmpty()) {
            System.out.println("List is empty.");
            return;
        }

        if (first.getId() == key) {
            deleteFirst();
            return;
        }

        Toy current = first.next;
        Toy previous = first;

        while (current != null && current.getId() != key) {
            previous = current;
            current = current.next;
        }

        if (current == null) {
            System.out.println("Toy not found.");
            return;
        }

        previous.next = current.next;
    }

    public Toy getFirst() {
        return first;
    }

    public void reverse() {
        Toy prev = null;
        Toy current = first;
        Toy next = null;
        while (current != null) {
            next = current.next;
            current.next = prev;
            prev = current;
            current = next;
        }
        first = prev;
    }

    public Toy getToyById(int id) {
        Toy current = first;
        while (current != null) {
            if (current.getId() == id) return current;
            current = current.next;
        }
        return null;
    }

    public static Toy getToyByID(int id) {
        return getInstance().getToyById(id);
    }

    public List<Toy> toList() {
        List<Toy> toys = new ArrayList<>();
        Toy current = first;
        while (current != null) {
            toys.add(current);
            current = current.next;
        }
        return toys;
    }

    public void selectionSortByAgeGroup() {
        List<Toy> toys = this.toList();
        int n = toys.size();
        for (int i = 0; i < n - 1; i++) {
            int minIdx = i;
            for (int j = i + 1; j < n; j++) {
                if (toys.get(j).getAgeGroup() < toys.get(minIdx).getAgeGroup()) {
                    minIdx = j;
                }
            }
            if (minIdx != i) {
                Toy temp = toys.get(i);
                toys.set(i, toys.get(minIdx));
                toys.set(minIdx, temp);
            }
        }
        this.first = null;
        for (int i = toys.size() - 1; i >= 0; i--) {
            toys.get(i).next = this.first;
            this.first = toys.get(i);
        }
    }

    public void displayList() {
        if (isEmpty()) {
            System.out.println("Toy list is empty.");
            return;
        }

        Toy current = first;
        while (current != null) {
            current.displayToy();
            current = current.next;
        }
    }
}
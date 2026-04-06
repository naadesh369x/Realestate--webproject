package com.example.demo;

import com.example.demo.models.Property;
import java.util.List;

public class QuickSortProperty {

    public static void quickSort(List<Property> properties, int low, int high, boolean ascending) {
        if (low < high) {
            int pi = partition(properties, low, high, ascending);
            quickSort(properties, low, pi - 1, ascending);
            quickSort(properties, pi + 1, high, ascending);
        }
    }

    private static int partition(List<Property> properties, int low, int high, boolean ascending) {
        double pivot = properties.get(high).getPrice();
        int i = low - 1;

        for (int j = low; j < high; j++) {
            boolean condition = ascending
                    ? properties.get(j).getPrice() < pivot
                    : properties.get(j).getPrice() > pivot;

            if (condition) {
                i++;
                swap(properties, i, j);
            }
        }
        swap(properties, i + 1, high);
        return i + 1;
    }

    private static void swap(List<Property> properties, int i, int j) {
        Property temp = properties.get(i);
        properties.set(i, properties.get(j));
        properties.set(j, temp);
    }
}

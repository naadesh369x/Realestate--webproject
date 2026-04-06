package com.example.demo.service;

import com.example.demo.QuickSortProperty;
import com.example.demo.models.Property;
import com.example.demo.utils.FileHandler;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class PropertyManager {
    private static List<Property> properties = null;
    private static final String fileName = "properties.txt";

    public static void readProperties() {
        if (properties != null) return;

        properties = new ArrayList<>();
        String[] data = FileHandler.readFromFile(fileName);

        for (String record : data) {
            String[] fields = record.split(";");
            if (fields.length >= 11) {
                Property property = new Property(
                        fields[0], fields[1], fields[2], fields[3],
                        parseDouble(fields[4]), parseDouble(fields[5]),
                        fields[6], fields[7], fields[8], fields[9], fields[10]
                );
                properties.add(property);
            }
        }
    }

//add property
    public static boolean addProperty(Property property) {
        if (properties == null) readProperties();

        if (property.getId() == null || property.getId().isEmpty()) {
            property.setId(generateNewPropertyId());
        }

        properties.add(property);
        savePropertiesToFile();
        return true;
    }
//get id for property
    private static String generateNewPropertyId() {
        int newId = 0;
        for (Property p : properties) {
            try {
                int id = Integer.parseInt(p.getId());
                if (id > newId) newId = id;
            } catch (NumberFormatException ignored) {

            }
        }
        return String.valueOf(newId + 1);
    }
  //updating property
    public static boolean updateProperty(Property updatedProperty) {
        if (properties == null) readProperties();
                //search property in list
        for (int i = 0; i < properties.size(); i++) {
            if (properties.get(i).getId().equals(updatedProperty.getId())) {
                properties.set(i, updatedProperty);
                savePropertiesToFile();
                return true;
            }
        }
        return false;
    }
//remove property
    public static void removeProperty(String id) {
        if (properties == null) readProperties();

        properties.removeIf(p -> p.getId().equals(id));
        savePropertiesToFile();
    }
   //get all properies in txt
    public static List<Property> getProperties() {
        if (properties == null) readProperties();
        return properties;
    }
    // use quickshort to short properties by price
    public static List<Property> getPropertiesSortedByPrice(boolean ascending) {
        if (properties == null) readProperties();
        List<Property> sorted = new ArrayList<>(properties);
        QuickSortProperty.quickSort(sorted, 0, sorted.size() - 1, ascending);
        return sorted;
    }



    public static List<Property> getPropertiesBySeller(String sellerEmail) {
        if (properties == null) readProperties();

        List<Property> result = new ArrayList<>();
        for (Property p : properties) {
            if (p.getSellerEmail() != null && p.getSellerEmail().equals(sellerEmail)) {
                result.add(p);
            }
        }
        return result;
    }
   //get property by id
    public static Property findPropertyById(String id) {
        if (properties == null) readProperties();

        for (Property p : properties) {
            if (p.getId().equals(id)) {
                return p;
            }
        }
        return null;
    }
   //save property
    public static void savePropertiesToFile() {
        if (properties == null) return;

        StringBuilder allProps = new StringBuilder();
        for (Property property : properties) {
            allProps.append(property.toFileString());
        }
        FileHandler.writeToFile(fileName, false, allProps.toString());
    }

    private static double parseDouble(String value) {
        try {
            return Double.parseDouble(value);
        } catch (Exception e) {
            return 0.0;
        }
    }
}

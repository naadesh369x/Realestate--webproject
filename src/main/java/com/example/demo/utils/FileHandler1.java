package com.example.demo.utils;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;

public class FileHandler1<T> {
    private final String filePath;
    private final Function<String, T> parser;
    private final Function<T, String> serializer;

    public FileHandler1(String filePath, Function<String, T> parser, Function<T, String> serializer) {
        this.filePath = filePath;
        this.parser = parser;
        this.serializer = serializer;
        ensureFileExists();
    }

    // Ensure the file exists when the handler is created
    private void ensureFileExists() {
        try {
            File file = new File(filePath);
            File parent = file.getParentFile();
            if (parent != null && !parent.exists()) {
                parent.mkdirs(); // Create directory if missing
            }
            if (!file.exists()) {
                boolean created = file.createNewFile();
                if (!created) {
                    System.err.println("Warning: Failed to create file: " + filePath);
                }
            }
        } catch (IOException e) {
            System.err.println("Error creating file: " + filePath);
            e.printStackTrace();
        }
    }

    public List<T> load() throws IOException {
        List<T> items = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    items.add(parser.apply(line));
                }
            }
        }
        return items;
    }

    public void save(List<T> items) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (T item : items) {
                writer.write(serializer.apply(item));
                writer.newLine();
            }
            writer.flush();
        } catch (IOException e) {
            System.err.println("Error writing to file: " + filePath);
            e.printStackTrace();
            throw e;
        }
    }
}

package com.example.demo.utils;

import java.io.*;

public class FileHandler {

    private static final String BASE_DIR = "estate_data";

    private static String getPath(String fileName) {
        File dir = new File(BASE_DIR);
        if (!dir.exists()) dir.mkdirs();
        
        File rootFile = new File(fileName);
        File targetFile = new File(dir, fileName);
        
        // Auto-migration for existing legacy data
        if (rootFile.exists() && !targetFile.exists()) {
            rootFile.renameTo(targetFile);
        }
        
        return BASE_DIR + File.separator + fileName;
    }

    public static boolean isFileExist(String fileName) {
        return new File(getPath(fileName)).exists();
    }

    public static boolean createFile(String fileName) {
        try {
            return new File(getPath(fileName)).createNewFile();
        } catch (IOException e) {
            System.out.println("Error creating file: " + fileName);
            return false;
        }
    }

    public static boolean writeToFile(String fileName, boolean append, String data) {
        String path = getPath(fileName);
        if (!new File(path).exists()) {
            if (!createFile(fileName)) return false;
        }
        try (FileWriter writer = new FileWriter(fileName, append)) {
            writer.write(data);
            return true;
        } catch (IOException e) {
            System.out.println("Write error: " + e.getMessage());
            return false;
        }
    }

    public static String[] readFromFile(String fileName) {
        String path = getPath(fileName);
        if (!new File(path).exists()) return new String[0];

        StringBuilder data = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
            String line;
            while ((line = reader.readLine()) != null) {
                data.append(line).append("\n");
            }
        } catch (IOException e) {
            System.out.println("Read error: " + e.getMessage());
        }
        return data.toString().isEmpty() ? new String[0] : data.toString().split("\n");
    }
}

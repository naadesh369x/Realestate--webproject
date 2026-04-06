package com.example.demo.service;

import com.example.demo.models.Media;
import com.example.demo.utils.BST;
import com.example.demo.utils.FileHandler1;

import jakarta.inject.Singleton;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.stream.Collectors;

@Singleton
public class MediaService {

    private BST<Media> bst;
    private FileHandler1<Media> fileHandler;

    private static final String IMAGE_UPLOAD_DIR = "images1"; //  folder to save

    public MediaService() {
        bst = new BST<>();
        fileHandler = new FileHandler1<>(
                "media.txt",
                line -> {
                    String[] parts = line.split(",");
                    return new Media(Integer.parseInt(parts[0]), Integer.parseInt(parts[1]), parts[2], parts[3]);
                },
                media -> String.format("%d,%d,%s,%s", media.getId(), media.getPropertyId(), media.getUrl(), media.getType())
        );
        try {
            List<Media> mediaList = fileHandler.load();
            for (Media media : mediaList) {
                bst.insert(media);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void addMedia(Media media) {
        bst.insert(media);
        saveMediaToFile();
    }

    public void addMedia(Media media, File uploadedFile, String absoluteUploadPath) throws IOException {
        ensureDirectoryExists(absoluteUploadPath);

        String fileName = System.currentTimeMillis() + "_" + uploadedFile.getName();
        File destinationFile = new File(absoluteUploadPath, fileName);
        Files.copy(uploadedFile.toPath(), destinationFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
        media.setUrl(IMAGE_UPLOAD_DIR + "/" + fileName); // relative path for web use
        bst.insert(media);
        saveMediaToFile();
    }
    public void addMedia(Media media, File mediaFile) {

        System.out.println("Media saved: " + media.getUrl() + " for property " + media.getPropertyId());

        // , save metadata to a file like media.txt
    }

    public void addMultipleMedia(int propertyId, String type, List<File> uploadedFiles, String absoluteUploadPath) throws IOException {
        ensureDirectoryExists(absoluteUploadPath);

        for (File uploadedFile : uploadedFiles) {
            String fileName = System.currentTimeMillis() + "_" + uploadedFile.getName();
            File destinationFile = new File(absoluteUploadPath, fileName);
            Files.copy(uploadedFile.toPath(), destinationFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            Media media = new Media(generateId(), propertyId, IMAGE_UPLOAD_DIR + "/" + fileName, type);
            bst.insert(media);
        }
        saveMediaToFile();
    }

    private void ensureDirectoryExists(String absolutePath) {
        File dir = new File(absolutePath);
        if (!dir.exists()) {
            dir.mkdirs();
        }
    }

    private int generateId() {
        return bst.getAll().stream()
                .mapToInt(Media::getId)
                .max()
                .orElse(0) + 1;
    }

    private void saveMediaToFile() {
        try {
            fileHandler.save(bst.getAll());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<Media> getAllMedia() {
        return bst.getAll();
    }

    public List<Media> getMediaByPropertyId(int propertyId) {
        return bst.getAll().stream()
                .filter(media -> media.getPropertyId() == propertyId)
                .collect(Collectors.toList());
    }
}

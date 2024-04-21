package com.app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.model.FileMetadata;
import com.app.repository.FileMetadataRepository;

import java.io.FileOutputStream;
import java.io.OutputStream;
import java.nio.file.Paths;

@Service
public class FileStorageService {

    @Autowired
    private FileMetadataRepository fileMetadataRepository;

    public String saveFile(byte[] content) {
        String directory = "src/main/resources/static/music";
        String fileName = "audio_" + System.currentTimeMillis() + ".wav"; // Example file name
        String path = Paths.get(directory, fileName).toString();
        String savePath = "/music/"+fileName;
        try (OutputStream os = new FileOutputStream(path)) {
            os.write(content); // Directly write bytes to file
            // save path to database
            FileMetadata fileMetadata = new FileMetadata(savePath);
            fileMetadataRepository.save(fileMetadata);
        } catch (Exception e) {
            
        }
    
        return savePath;
    }
    
}

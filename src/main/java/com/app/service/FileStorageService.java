package com.app.service;

import org.springframework.stereotype.Service;

import com.app.model.User;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.IOException;
import java.nio.file.DirectoryNotEmptyException;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.File;



@Service
public class FileStorageService {

    // @Autowired
    // private FileMetadataRepository fileMetadataRepository;

    public String saveFile(byte[] content, String fileType) {        
        // fileType : audio | pdf  
        String directory = "src/main/resources/static/music";
        String fileName = (fileType.equals("audio")) ? "_audio.wav" : "_music.pdf"; // Example file name
     
        String path = Paths.get(directory, fileName).toString();
        String savePath = "/music/" + fileName;
        try (OutputStream os = new FileOutputStream(path)) {
            os.write(content); // Directly write bytes to file
            // save path to database
            // FileMetadata fileMetadata = new FileMetadata(savePath);// set the file path
            // fileMetadataRepository.save(fileMetadata);// save the file path to the db
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return savePath; // return path to file
    }

    public boolean deleteFile(String filePath) {
        Path path = Paths.get(filePath);
        try {
            Files.delete(path); // Deletes the file
            // Optionally, remove the file metadata from the database if needed
            // fileMetadataRepository.deleteByPath(filePath);
            return true; // File deletion was successful
        } catch (NoSuchFileException e) {
            System.err.println("No such file exists: " + filePath);
        } catch (DirectoryNotEmptyException e) {
            System.err.println("Directory is not empty: " + filePath);
        } catch (IOException e) {
            System.err.println("I/O error occurred: " + e.getMessage());
        }
        return false; // File deletion failed
    }
    

}

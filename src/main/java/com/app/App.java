package com.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.awt.*;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

@SpringBootApplication
public class App {

    public static void main(String[] args) throws Exception {
        SpringApplication.run(App.class, args);
        try {
            Runtime rt = Runtime.getRuntime();
            rt.exec("cmd /c start chrome.exe http://localhost:8080/login");
        } catch (IOException e) {
            //e.printStackTrace();
        }
    }

    private static void openHomePage() {
        try {
            URI homepage = new URI("http://localhost:8080/login");
            Desktop.getDesktop().browse(homepage);
        } catch (URISyntaxException | IOException e) {
            e.printStackTrace();
        }
    }

}

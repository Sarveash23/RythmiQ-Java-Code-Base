package com.app.dto;

/**
 *
 * @author vikastiwari
 */
public class SaveChatBody {

    private String title;
    private String filePath;

    public String getFilePath() {
        return filePath;
    }

    public String getTitle() {
        return title;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public void setTitle(String title) {
        this.title = title;
    }

}

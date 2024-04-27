package com.app.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import javax.persistence.*;
import org.springframework.data.annotation.CreatedDate;

/**
 *
 * @author Sarveashwaran
 */
@Entity
@Table(name = "chat")
public class Chat implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @CreatedDate
    private LocalDateTime createdAt;
    private String title;
    private String music_path;
    private String sheet_path;
    @ManyToOne(fetch = FetchType.EAGER)
    private User user;

    public Chat(LocalDateTime date, String title, String music_path, String sheet_path) {
        this.createdAt = date;
        this.title = title;
        this.music_path = music_path;
        this.sheet_path = sheet_path;
    }

    public Chat() {
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMusic_path() {
        return music_path;
    }

    public void setMusic_path(String music_path) {
        this.music_path = music_path;
    }

    public String getSheet_path() {
        return sheet_path;
    }

    public void setSheet_path(String sheet_path) {
        this.sheet_path = sheet_path;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Chat)) {
            return false;
        }
        Chat other = (Chat) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modal.Chat[ id=" + id + " ]";
    }

}

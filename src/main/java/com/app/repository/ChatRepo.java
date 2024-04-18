package com.app.repository;

import com.app.model.Chat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ChatRepo extends JpaRepository<Chat, Long> {
    public List<Chat> findAllByCreatedAtGreaterThanEqualOrderByCreatedAtDesc(LocalDateTime time);
   
}

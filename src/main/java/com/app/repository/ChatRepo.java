package com.app.repository;

import com.app.model.Chat;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ChatRepo extends JpaRepository<Chat, Long> {
    public List<Chat> findAllByCreatedAtGreaterThanEqualOrderByCreatedAtDesc(LocalDateTime time);
    public List<Chat> findAllByUserId(Long userId);
    public Optional<Chat> findById(Long id);
}

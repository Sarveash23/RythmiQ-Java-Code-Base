package com.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.app.model.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends JpaRepository<User, Long> {

    @Query("SELECT a FROM User a WHERE a.username =:username")
    User findByUsername(@Param("username") String username);
}

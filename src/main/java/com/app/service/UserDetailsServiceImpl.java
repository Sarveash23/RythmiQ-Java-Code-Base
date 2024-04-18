package com.app.service;

import com.app.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserDetailsServiceImpl {
	
	@Autowired
    private UserRepository userRepository;
	

}

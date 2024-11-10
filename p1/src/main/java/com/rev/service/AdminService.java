package com.rev.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rev.entity.Admin;
import com.rev.repository.AdminRepository;

@Service
public class AdminService {

    @Autowired
    private AdminRepository adminRepository;

    // Find admin by username
    public Admin findByUsername(String username) {
        return adminRepository.findByUsername(username);
    }
}
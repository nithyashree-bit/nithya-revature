package com.rev.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rev.entity.Seller;
import com.rev.repository.SellerRepository;


@Service
public class SellerService {

    @Autowired
    private SellerRepository sellerRepository;
    @Autowired
    private EmailService emailService;

    // Method to save a new seller
    public Seller saveSeller(Seller seller) {
        return sellerRepository.save(seller);
    }

    // Method to find a seller by username
    public Seller findByUsername(String username) {
        return sellerRepository.findByUsername(username);
    }
    // Update seller information
    public void updateSeller(Seller seller) {
        sellerRepository.save(seller); // Update seller information
    }

    // Delete a seller by ID
    public void deleteSellerById(Long id) {
        sellerRepository.deleteById(id);  // Deletes seller by ID
    }

    // Get all sellers
    public List<Seller> getAllSellers() {
        return sellerRepository.findAll();
    }

//    // Get a seller by ID (optional)
//    public Optional<Seller> getSellerById(Long id) {
//        return sellerRepository.findById(id);
//    }
//    
    public Seller getSellerById(Long sellerId) {
        return sellerRepository.findById(sellerId).orElse(null); // Assuming SellerRepository extends JpaRepository
    }
    public int getCount() {
        return (int) sellerRepository.count(); // Return the total count of sellers
    }
    
    public boolean approveSellerById(Long id) {
        Optional<Seller> sellerOpt = sellerRepository.findById(id);
        if (sellerOpt.isPresent() && !sellerOpt.get().getApproved()) {
            Seller seller = sellerOpt.get();
            seller.setApproved(true); // Set approved status
            sellerRepository.save(seller); // Save the updated seller

            // Send approval email
            emailService.sendApprovalEmail(seller.getEmail(), seller.getUsername()); // Ensure getUsername() exists
            return true; // Indicate successful approval
        }
        return false; // Indicate failure to approve
    }


}

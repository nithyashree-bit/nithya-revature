// WishlistRepository.java
package com.rev.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.rev.entity.Buyer;
import com.rev.entity.Product;
import com.rev.entity.Wishlist;

@Repository
public interface WishlistRepository extends JpaRepository<Wishlist, Long> {
	
    List<Wishlist> findByBuyerId(Long buyerId);
    
//    @Query("SELECT w FROM Wishlist w WHERE w.buyer.id = :buyerId AND w.product.productId = :productId")
    List<Wishlist> findByBuyerAndProduct(Buyer buyer, Product product);
    
    void deleteByProduct(Product product);
}

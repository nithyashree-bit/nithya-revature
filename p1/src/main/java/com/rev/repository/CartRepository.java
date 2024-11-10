package com.rev.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.rev.entity.Cart;
import com.rev.entity.Product;

import jakarta.transaction.Transactional;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {
	Cart findByUserIdAndProduct(Long userId, Product product);

	List<Cart> findProductIdsByUserId(Long userId);

	Integer deleteByUserIdAndProduct(Long userId, Product product);

	List<Cart> findByUserId(Long userId);

	@Modifying
    @Transactional
    @Query("UPDATE Cart c SET c.quantity = :quantity WHERE c.userId = :userId AND c.product = :product")
    int updateCartQuantity(int quantity, Long userId, Product product);

//	Cart findByUserIdAndProductId(Long userId, Product product);

//	@Query("SELECT new com.rev.dto.CartProductDTO(c.productId, c.userId, c.quantity, p.stockQuantity, p.name, p.description, p.price, p.offer, p.image) "
//			+ "FROM Cart c LEFT JOIN Product p ON c.productId = p.productId " + "ORDER BY c.addedAt DESC")
//	List<Cart> findAllCartProducts();
}

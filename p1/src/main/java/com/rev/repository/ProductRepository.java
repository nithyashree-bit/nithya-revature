package com.rev.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.rev.entity.CategoryTypes;
import com.rev.entity.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

	// Method to find products by seller ID
	List<Product> findBySellerId(Long sellerId);

	Product findByProductId(Long productId);

	List<Product> findAllById(Iterable<Long> productIds);
	void deleteById(Long id);

//	Product findByProductId(Product productId);
    List<Product> findByCategory(CategoryTypes  category);

    // Custom query to search by product name, description, or category
    @Query("SELECT p FROM Product p WHERE LOWER(p.name) LIKE LOWER(CONCAT('%', :text, '%')) " +
           "OR LOWER(p.category) LIKE LOWER(CONCAT('%', :text, '%')) " +
           "OR LOWER(p.description) LIKE LOWER(CONCAT('%', :text, '%'))")
    List<Product> searchProductsByText(String text);
	
}

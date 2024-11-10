package com.rev.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rev.entity.CategoryTypes;
import com.rev.entity.Product;
import com.rev.repository.ProductRepository;

@Service
public class ProductService {

	@Autowired
	private ProductRepository productRepository;

	public List<Product> getProductsBySellerId(Long sellerId) {
		return productRepository.findBySellerId(sellerId);
	}

	public void addProduct(Product product) {
		productRepository.save(product);
	}

	public List<Product> getAllProducts() {
		return productRepository.findAll();

	}

	public void updateProduct(Long productId, Product updatedProduct) {
		Product existingProduct = productRepository.findById(productId)
				.orElseThrow(() -> new RuntimeException("Product not found"));
		existingProduct.setName(updatedProduct.getName());
		existingProduct.setDescription(updatedProduct.getDescription());
		existingProduct.setStockQuantity(updatedProduct.getStockQuantity());
		productRepository.save(existingProduct); // Save the updated product
	}

	public void deleteProduct(Long productId) {
		productRepository.deleteById(productId);

	}

	public Product getProductById(Long productId) {
		return productRepository.findByProductId(productId); // Return Optional directly
	}
	 public List<Product> getProductsByCategory(String category) {
	        if (category == null || category.isEmpty()) {
				return null;
	        }
            CategoryTypes categoryEnum = CategoryTypes.valueOf(category);
            return productRepository.findByCategory(categoryEnum);
	    }
	 
	 public List<Product> searchProductsByText(String text) {
	        if (text == null || text.isEmpty()) {
	            return productRepository.findAll();
	        }
	        return productRepository.searchProductsByText(text);
	    }
	 
}

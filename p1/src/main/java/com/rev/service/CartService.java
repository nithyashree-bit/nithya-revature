package com.rev.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rev.entity.Cart;
import com.rev.entity.Product;
import com.rev.repository.CartRepository;
import com.rev.repository.ProductRepository;

import jakarta.transaction.Transactional;

@Service
public class CartService {

	@Autowired
	private CartRepository cartRepository;

	@Autowired
	private ProductRepository productRepository;

	public boolean addToCart(Long userId, Product product, int quantity) {
		Cart existingCartItem = cartRepository.findByUserIdAndProduct(userId, product);

		if (existingCartItem != null) {
			return false;
		}
		Cart cart = new Cart();
		cart.setUserId(userId);
		cart.setProduct(product);
		cart.setQuantity(quantity);
		cart.setAddedAt(LocalDateTime.now());

		cartRepository.save(cart);

		return true;
	}

//	public boolean removeFromCart(Long userId, Product productId) {
//		return cartRepository.deleteByUserIdAndProductId(userId, productId);
//	}

	public boolean getCartProductIds(Long userId, Product product) {
		List<Cart> cartitems = cartRepository.findProductIdsByUserId(userId);
		for (Cart cart : cartitems) {
			System.out.println(cart.toString());
			if (cart.getProduct().getProductId() == product.getProductId()) {
				return true;
			}
		}
		return false;
	}

	public List<Cart> getCartItemsByUserId(Long userId) {
		return cartRepository.findByUserId(userId);
	}

	public void updateCartQuantity(Long userId, Product productId, int quantity) {
		cartRepository.updateCartQuantity(quantity, userId, productId);
	}

	public Product getProductById(Long productId) {
		return productRepository.findByProductId(productId);
	}

	@Transactional
	public boolean removeFromCart(Long userId, Product productId) {
		Integer deletedCount = cartRepository.deleteByUserIdAndProduct(userId, productId);
		return deletedCount > 0;
	}

	public boolean updateQuantity(Long userId, Product product, int quantity) {
		// Fetch the cart item based on the productId
		Cart cartItem = cartRepository.findByUserIdAndProduct(userId, product);

		if (cartItem != null) {
			cartItem.setQuantity(quantity);
			cartRepository.save(cartItem); // Save the updated item
			return true;
		}
		return false; // Product not found in the cart
	}
}

package com.rev.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.rev.entity.Cart;
import com.rev.entity.Product;
import com.rev.service.CartService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class CartController {

	@Autowired
	private CartService cartService;

	@PostMapping("/addItem")
	public String addToCart(@RequestParam Long productId, HttpSession session,
			Model model) {
	    Product product = cartService.getProductById(productId);
		Long userId = (Long) session.getAttribute("userId");
		System.out.println("User ID: " + userId + ", Product ID: " + product.getProductId());
		cartService.addToCart(userId, product, 1);
		return "redirect:/product_details?productId=" + product.getProductId();
	}

	// other places
	@PostMapping("/addToCart")
    public ResponseEntity<Map<String, String>> addToCart(@RequestParam("productId") Product productId, HttpSession session) {
        Map<String, String> response = new HashMap<>();
        
        // Fetch userId from session
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            response.put("status", "error");
            response.put("message", "User not logged in.");
            return ResponseEntity.status(401).body(response); // Unauthorized
        }

        // Call service to add product to cart
        cartService.addToCart(userId, productId, 1);

        response.put("status", "success");
        return ResponseEntity.ok(response);
    }

	@GetMapping("/")
	public String getCartItems(HttpSession session, Model model) {
		if (session == null) {
			return "login";
		}

		Long userId = (Long) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		List<Cart> cartItemsByUserId = cartService.getCartItemsByUserId(userId);
		model.addAttribute("cart", cartItemsByUserId);
		return "cart";
	}

	@DeleteMapping("/removeItem")
    public ResponseEntity<String> removeItem(@RequestBody Map<String, Long> data, HttpSession session) {
		Long productId = data.get("productId");
	    Product product = cartService.getProductById(productId);
        Long userId = (Long) session.getAttribute("userId");
        if (userId != null) {
            cartService.removeFromCart(userId, product);
            return ResponseEntity.ok("Item removed");
        }
        return ResponseEntity.status(401).body("User not logged in");
    }
	
	  @PutMapping("/update")
	    public ResponseEntity<?> updateCartItemQuantity(@RequestBody Map<String, Object> payload, HttpSession session) {
	        Long productId = Long.valueOf(payload.get("productId").toString());
	        Integer quantity = Integer.valueOf(payload.get("quantity").toString());

	        if (quantity < 0) {
	            return ResponseEntity.badRequest().body("Quantity cannot be negative");
	        }

	        Long userId = (Long) session.getAttribute("userId");
	        if (userId == null) {
	            return ResponseEntity.status(401).body("User not logged in");
	        }

	        Product product = cartService.getProductById(productId);
	        if (product == null) {
	            return ResponseEntity.status(404).body("Product not found");
	        }

	        boolean isUpdated = cartService.updateQuantity(userId, product, quantity);
	        if (isUpdated) {
	            return ResponseEntity.ok("Quantity updated successfully");
	        } else {
	            return ResponseEntity.status(404).body("Product not found in the cart");
	        }
	  }
}

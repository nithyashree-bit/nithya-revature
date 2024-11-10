// WishlistController.java
package com.rev.controller;

import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.rev.entity.Buyer;
import com.rev.entity.Product;
import com.rev.entity.Wishlist;
import com.rev.repository.WishlistRepository;
import com.rev.service.BuyerService;
import com.rev.service.ProductService;
import com.rev.service.WishlistService;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Controller
@RequestMapping("/wishlist")
public class WishlistController {

	@Autowired
	private WishlistService wishlistService;

	@Autowired
	private WishlistRepository wishlistRepository;

	@Autowired
	private BuyerService buyerService;
	@Autowired
	private ProductService productService;

	@SuppressWarnings("unchecked")
	@PostMapping("/add")
	public ResponseEntity<String> addToWishlist(@RequestBody Map<String, Object> requestBody, HttpSession session) {
	    // Extract user ID and product ID from the request body
	    Map<String, Object> user = (Map<String, Object>) requestBody.get("user");
	    Map<String, Object> product = (Map<String, Object>) requestBody.get("product");

	    Long userId = ((Number) user.get("id")).longValue(); // Get user ID
	    Long productId = Long.valueOf((String) product.get("productId")); // Get product ID (converting String to Long)

	    // Retrieve the buyer
	    Optional<Buyer> optionalBuyer = buyerService.findById(userId);

	    // Check if buyer is present
	    if (optionalBuyer.isPresent()) {
	        Buyer buyer = optionalBuyer.get(); // Extract the Buyer object
	        Product productEntity = productService.getProductById(productId); // Retrieve the Product entity
	        wishlistService.addToWishlist(buyer, productEntity); // Call the service method
	        return ResponseEntity.ok("Product added to wishlist!");
	    } else {
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found.");
	    }
	}

	@GetMapping
	public String viewWishlist(
	    @SessionAttribute(name = "userId", required = false) Long buyerId, 
	    Model model) {
	    
	    // If the user is not logged in, redirect to the login page
	    if (buyerId == null) {
	        return "redirect:/login";
	    }

	    // Fetch the buyer using the buyerId from the session
	    Optional<Buyer> buyerOpt = buyerService.findById(buyerId);
	    if (buyerOpt.isPresent()) {
	        Buyer buyer = buyerOpt.get();
	        
	        // Retrieve the wishlist for the logged-in buyer
	        List<Wishlist> wishlist = wishlistService.getWishlistByBuyer(buyer);
	        model.addAttribute("wishlist", wishlist);
	        
	        return "wishlist"; // JSP page to display the wishlist
	    }

	    // If the buyer is not found, redirect to an error page
	    return "redirect:/error";
	}
	
	@Transactional
	@DeleteMapping("/remove/{id}")
    public ResponseEntity<String> removeFromWishlist(@PathVariable Long id) {
        try {
        	Product product = productService.getProductById(id);
            wishlistService.removeItem(product);
            return ResponseEntity.ok("Item removed from wishlist successfully.");
        } catch (NoSuchElementException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Item not found.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error removing item from wishlist.");
        }
    }

}

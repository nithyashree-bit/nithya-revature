package com.rev.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rev.entity.Buyer;
import com.rev.entity.Product;
import com.rev.entity.Review;
import com.rev.repository.ProductRepository;
import com.rev.repository.ReviewRepository;
import com.rev.service.BuyerService;
import com.rev.service.CartService;
import com.rev.service.ProductService;
import com.rev.service.ReviewService;
import com.rev.service.WishlistService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ProductController {

	@Autowired
	private ProductService productService;
	@Autowired
	private CartService cartService;

	@Autowired
	private ReviewRepository reviewRepository;
	@Autowired
	private BuyerService buyerService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private WishlistService wishlistService;

	@GetMapping("/dashboard")
	public String showBuyerDashboard(HttpSession session, Model model) {
		List<Product> products = productService.getAllProducts();
		model.addAttribute("products", products);

		System.out.println(products);
		return "dashboard";
	}

	@GetMapping("/product_details")
    public String productDetails(@RequestParam Long productId, Model model,HttpSession session) {
    	boolean cartProductIds = false;
        Product product = productService.getProductById(productId);
        System.out.println(product);
        Long userId = (Long) session.getAttribute("userId");
        Product product1 = new Product();
        product1.setProductId(productId);
        cartProductIds = cartService.getCartProductIds(userId,product1); // This should return a list of product IDs in the cart
        
        Optional<Buyer> optionalBuyer = buyerService.findById(userId);

        if (optionalBuyer.isPresent()) {
	        Buyer buyer = optionalBuyer.get();
	    	model.addAttribute("product", product);
	    	boolean inWishlist = wishlistService.isInWishlist(buyer, product);
	    	System.out.println("workinggg...."+inWishlist);
	        Optional<Review> userReview = reviewService.getUserReview(userId, productId);
	        model.addAttribute("userReview", userReview.orElse(null));  // User's review (if any)
	
	        List<Review> reviews = reviewRepository.findAll();
	        model.addAttribute("reviews",reviews);
	        model.addAttribute("inWishlist",inWishlist);
	    	
	     	model.addAttribute("alreadyAdded",cartProductIds);
	
	        return "product_details";
	    } else {
	        return "login";
	    }
        
    }
	
	@GetMapping("/filterProducts")
    public String getProducts(@RequestParam(required = false) String category, Model model) {
        List<Product> products = productService.getProductsByCategory(category);
        model.addAttribute("products", products);
        model.addAttribute("category", category);
        return "categoryFilter"; // Render products.jsp
    }
	
	@GetMapping("/searchProducts")
	public String searchProducts(@RequestParam(required = false) String text, Model model) {
	    List<Product> products = productService.searchProductsByText(text);
	    model.addAttribute("products", products);
	    return "categoryFilter";
	}


}

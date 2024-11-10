package com.rev.controller;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.rev.entity.Review;
import com.rev.repository.ReviewRepository;
import com.rev.service.ReviewService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/reviews")
public class ReviewController {

	@Autowired
	private ReviewRepository reviewRepository;
	@Autowired
	private ReviewService reviewService;

	// 1. Get all reviews
//    @GetMapping
//    public ResponseEntity<List<Review>> getAllReviews() {
//        List<Review> reviews = reviewRepository.findAll();
//        return ResponseEntity.ok(reviews);
//    }

	@GetMapping("/reviews/product/{productId}")
	public String getReviewsForProduct(@PathVariable int productId, Model model) {
		List<Review> reviews = reviewRepository.findByProductId(productId);
		model.addAttribute("reviews", reviews);
		return "reviews"; // This returns the reviews.jsp page
	}

	// 3. Get a specific review by ID
	@GetMapping("/{id}")
	public ResponseEntity<Review> getReviewById(@PathVariable Long id) {
		Optional<Review> review = reviewRepository.findById(id);
		return review.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
	}

	// 4. Add a new review
	@PostMapping
	public String createReview(Review review, HttpSession session) {
		review.setCreatedAt(java.time.LocalDateTime.now());
		review.setUserName((String) session.getAttribute("userName"));
		reviewRepository.save(review);
		return "redirect:/product_details?productId=" + review.getProductId();
	}
	
	// 5. Update a review
//    @PutMapping(value= "/{id}")
//    public String updateReview(@PathVariable Long id, Review updatedReview) {
//        Optional<Review> existingReview = reviewRepository.findById(id);
//
//        if (existingReview.isPresent()) {
//            Review review = existingReview.get();
//            review.setRating(updatedReview.getRating());
//            review.setReviewText(updatedReview.getReviewText());
//            Review savedReview = reviewRepository.save(review);
//            return "redirect:/product_details?product_id="+updatedReview.getProductId();
//        }
//		return null; 
//    }

	@PostMapping("/update")
	public String updateReview(@ModelAttribute Review updatedReview, RedirectAttributes redirectAttributes) {
	    reviewService.updateReview(updatedReview);
	    redirectAttributes.addAttribute("productId", updatedReview.getProductId());
	    return "redirect:/product_details";
	}

	@PostMapping("/delete")
	public ResponseEntity<?> deleteReview(@RequestBody Map<String, Object> request) {
	    Long reviewId = Long.valueOf(request.get("reviewId").toString());
	    Integer productId = Integer.valueOf(request.get("productId").toString());

	    // Perform the deletion logic using reviewId and productId if needed
	    reviewService.deleteReview(reviewId);

	    return ResponseEntity.ok().build();
	}


}

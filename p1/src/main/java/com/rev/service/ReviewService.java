package com.rev.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rev.entity.Review;
import com.rev.repository.ReviewRepository;

@Service
public class ReviewService {
	
	@Autowired
	private ReviewRepository reviewRepository;
	
//	public boolean hasUserReviewedProduct(Long userId, Long productId) {
//	    return reviewRepository.existsByUserIdAndProductId(userId, productId);
//	}

	public Optional<Review> getUserReview(Long userId, Long productId) {
	    return reviewRepository.findByUserIdAndProductId(userId, productId);
	}
	public void updateReview(Review review) {
	    reviewRepository.save(review);  // Assumes save() performs both insert and update
	}

	public void deleteReview(Long reviewId) {
	    reviewRepository.deleteById(reviewId);
	}



}

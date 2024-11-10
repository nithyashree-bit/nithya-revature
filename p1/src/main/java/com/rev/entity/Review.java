package com.rev.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "review")
@Data
@NoArgsConstructor
public class Review {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long reviewId;
    
    @Column(nullable = false)
    private Long productId;
    
    @Column(nullable = false)
    private Long userId;
    
    @Column(nullable =false)
    private String userName;
    
    @Column(nullable = false)
    private int rating;
    	
    @Column
    private String imageUrl;

    @Column
    private String reviewText;
    
    @Column(name = "added_at")
    private LocalDateTime createdAt;
}

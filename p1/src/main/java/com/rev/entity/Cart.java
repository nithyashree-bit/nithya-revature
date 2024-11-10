package com.rev.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;


@Entity
@Table(name = "cart")
@Data
@NoArgsConstructor
@AllArgsConstructor

public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cart_id")
    private Long cartId;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    // Use a relationship annotation for Product
    @ManyToOne(fetch = FetchType.EAGER)  // Change to EAGER
    @JoinColumn(name = "product_id", nullable = false) // This sets up the foreign key relationship
    private Product product;

    @Column(name = "quantity", nullable = false)
    private int quantity;


    @Column(name = "added_at", nullable = false)
    private LocalDateTime addedAt;

}

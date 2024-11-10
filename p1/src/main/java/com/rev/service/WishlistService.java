// WishlistService.java
package com.rev.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rev.entity.Buyer;
import com.rev.entity.Product;
import com.rev.entity.Wishlist;
import com.rev.repository.WishlistRepository;

@Service
public class WishlistService {

	@Autowired
	private WishlistRepository wishlistRepository;

	public void addToWishlist(Buyer buyer, Product product) {
			Wishlist wishlist = new Wishlist();
			wishlist.setBuyer(buyer);
			wishlist.setProduct(product);
			wishlistRepository.save(wishlist);
		
	}

	public List<Wishlist> getWishlistByBuyer(Buyer buyer) {
		return wishlistRepository.findByBuyerId(buyer.getId());
	}

	public void removeFromWishlist(Buyer buyer) {
		wishlistRepository.deleteById(buyer.getId());
	}
	
	public boolean isInWishlist(Buyer buyer, Product product) {
	    List<Wishlist> wishlistItems = wishlistRepository.findByBuyerAndProduct(buyer, product);
	    return !wishlistItems.isEmpty();
	}
	public void removeItem(Product product) {
        wishlistRepository.deleteByProduct(product);
    }
	
}

package com.rev.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rev.entity.Favourites;
import com.rev.repository.FavouritesRepository;

@Service
public class FavouritesService {
	@Autowired
	private FavouritesRepository favouritesRepository;

	public Favourites addToFavouries(Favourites favourites) {
		Long userId = favourites.getUserId();
		Long productId = favourites.getProductId();
		if (favouritesRepository.existsByUserIdAndProductId(userId, productId)) {
			return favouritesRepository.save(favourites);
		}
		return null;
	}

	public List<Favourites> getUserFavourites(Long userId) {
		return favouritesRepository.findByUserId(userId);
	}
    public void removeFromFavourites(Long userId, Long productId) {
        favouritesRepository.deleteByUserIdAndProductId(userId, productId);
    }

    public boolean existsByUserAndProduct(Long userId, Long productId) {
        
    	favouritesRepository.existsById(productId);
    	return favouritesRepository.existsByUserIdAndProductId(userId, productId);
        
    }
}
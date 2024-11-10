package com.rev.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.rev.entity.Favourites;
import com.rev.service.FavouritesService;

import jakarta.servlet.http.HttpSession;

@RequestMapping("favourites")
@RestController
public class FavouritesController {

	@Autowired
	private FavouritesService favouritesService;

//	@Autowired
//	private Favourites favourites;

	@SuppressWarnings("unused")
	@PostMapping("/")
	public String postMethodName(@RequestParam Long productId, HttpSession session) {
//		Long userId = (Long) session.getAttribute("userId");
		Long userId = 1l;
		if (userId != null) {
			
			Favourites favourites = new Favourites();

			if (favouritesService.existsByUserAndProduct(userId, productId)) {
				favourites.setUserId(userId);
				favourites.setProductId(productId);
				favouritesService.removeFromFavourites(userId, productId);
				return "removed from favourites for user:" + userId;
			} 
			
			else {
				favouritesService.addToFavouries(favourites);
				return "added to the favourites for user:" + userId;
			}
		}
		return "user not exists";
	}

	@GetMapping("/user")
	public List<Favourites> getUserFavourites(HttpSession session) {
		Long userId = (Long) session.getAttribute("userId"); // Retrieve user name

		if (userId == null) {
			throw new RuntimeException("User not logged in!");
		}
		System.out.println("Fetching favourites for: " + userId);
		return favouritesService.getUserFavourites(userId);
	}

}

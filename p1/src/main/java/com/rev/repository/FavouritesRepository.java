package com.rev.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.rev.entity.Favourites;

@Repository
public interface FavouritesRepository extends JpaRepository<Favourites, Long> {

	List<Favourites> findByUserId(Long userId);

//    @Query("SELECT CASE WHEN COUNT(f) > 0 THEN true ELSE false END FROM Favourites f WHERE f.userId = :userId AND f.productId = :productId")
	boolean existsByUserIdAndProductId(@Param("userId") Long userId, @Param("productId") Long productId);

	List<Favourites> findByUserIdAndProductId(Long userId, Long productId);

	void deleteByUserIdAndProductId(Long userId, Long productId);
}

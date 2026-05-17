package com.hotel.reservation.repository;

import com.hotel.reservation.entity.Hotel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface HotelRepository extends JpaRepository<Hotel, Long> {
    List<Hotel> findByAvailableTrue();

    @Query("SELECT h FROM Hotel h WHERE h.location LIKE %:location% AND h.available = true")
    List<Hotel> findByLocation(@Param("location") String location);

    @Query("SELECT h FROM Hotel h WHERE h.pricePerNight BETWEEN :minPrice AND :maxPrice AND h.available = true")
    List<Hotel> findByPriceRange(@Param("minPrice") Double minPrice, @Param("maxPrice") Double maxPrice);
}
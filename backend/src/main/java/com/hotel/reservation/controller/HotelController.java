package com.hotel.reservation.controller;

import com.hotel.reservation.entity.Hotel;
import com.hotel.reservation.service.HotelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/hotels")
@CrossOrigin(origins = "*")
public class HotelController {

    @Autowired
    private HotelService hotelService;

    @GetMapping
    public ResponseEntity<List<Hotel>> getAllHotels() {
        List<Hotel> hotels = hotelService.getAllHotels();
        return ResponseEntity.ok(hotels);
    }

    @GetMapping("/available")
    public ResponseEntity<List<Hotel>> getAvailableHotels() {
        List<Hotel> hotels = hotelService.getAvailableHotels();
        return ResponseEntity.ok(hotels);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Hotel> getHotelById(@PathVariable Long id) {
        Optional<Hotel> hotel = hotelService.getHotelById(id);
        return hotel.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/search/location")
    public ResponseEntity<List<Hotel>> searchByLocation(@RequestParam String location) {
        List<Hotel> hotels = hotelService.searchHotelsByLocation(location);
        return ResponseEntity.ok(hotels);
    }

    @GetMapping("/search/price")
    public ResponseEntity<List<Hotel>> searchByPriceRange(
            @RequestParam Double minPrice,
            @RequestParam Double maxPrice) {
        List<Hotel> hotels = hotelService.searchHotelsByPriceRange(minPrice, maxPrice);
        return ResponseEntity.ok(hotels);
    }

    @PostMapping
    public ResponseEntity<Hotel> createHotel(@RequestBody Hotel hotel) {
        Hotel savedHotel = hotelService.saveHotel(hotel);
        return ResponseEntity.ok(savedHotel);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Hotel> updateHotel(@PathVariable Long id, @RequestBody Hotel hotel) {
        Optional<Hotel> existingHotel = hotelService.getHotelById(id);
        if (existingHotel.isPresent()) {
            hotel.setId(id);
            Hotel updatedHotel = hotelService.updateHotel(hotel);
            return ResponseEntity.ok(updatedHotel);
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteHotel(@PathVariable Long id) {
        hotelService.deleteHotel(id);
        return ResponseEntity.noContent().build();
    }
}
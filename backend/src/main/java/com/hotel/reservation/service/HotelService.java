package com.hotel.reservation.service;

import com.hotel.reservation.entity.Hotel;
import com.hotel.reservation.repository.HotelRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class HotelService {

    @Autowired
    private HotelRepository hotelRepository;

    public List<Hotel> getAllHotels() {
        return hotelRepository.findAll();
    }

    public List<Hotel> getAvailableHotels() {
        return hotelRepository.findByAvailableTrue();
    }

    public Optional<Hotel> getHotelById(Long id) {
        return hotelRepository.findById(id);
    }

    public List<Hotel> searchHotelsByLocation(String location) {
        return hotelRepository.findByLocation(location);
    }

    public List<Hotel> searchHotelsByPriceRange(Double minPrice, Double maxPrice) {
        return hotelRepository.findByPriceRange(minPrice, maxPrice);
    }

    public Hotel saveHotel(Hotel hotel) {
        return hotelRepository.save(hotel);
    }

    public Hotel updateHotel(Hotel hotel) {
        return hotelRepository.save(hotel);
    }

    public void deleteHotel(Long id) {
        hotelRepository.deleteById(id);
    }
}
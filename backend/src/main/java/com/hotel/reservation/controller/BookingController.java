package com.hotel.reservation.controller;

import com.hotel.reservation.entity.Booking;
import com.hotel.reservation.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/bookings")
@CrossOrigin(origins = "*")
public class BookingController {

    @Autowired
    private BookingService bookingService;

    @GetMapping
    public ResponseEntity<List<Booking>> getAllBookings() {
        List<Booking> bookings = bookingService.getAllBookings();
        return ResponseEntity.ok(bookings);
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<Booking>> getBookingsByUser(@PathVariable Long userId) {
        List<Booking> bookings = bookingService.getBookingsByUser(userId);
        return ResponseEntity.ok(bookings);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Booking> getBookingById(@PathVariable Long id) {
        Optional<Booking> booking = bookingService.getBookingById(id);
        return booking.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<?> createBooking(@RequestBody Map<String, Object> bookingRequest) {
        try {
            Long userId = Long.valueOf(bookingRequest.get("userId").toString());
            Long roomId = Long.valueOf(bookingRequest.get("roomId").toString());
            LocalDate checkIn = LocalDate.parse(bookingRequest.get("checkInDate").toString());
            LocalDate checkOut = LocalDate.parse(bookingRequest.get("checkOutDate").toString());
            Integer guests = Integer.valueOf(bookingRequest.get("numberOfGuests").toString());

            Booking booking = bookingService.createBooking(userId, roomId, checkIn, checkOut, guests);

            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("message", "Booking created successfully");
            response.put("booking", booking);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("success", "false");
            error.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<Booking> updateBooking(@PathVariable Long id, @RequestBody Booking booking) {
        Optional<Booking> existingBooking = bookingService.getBookingById(id);
        if (existingBooking.isPresent()) {
            booking.setId(id);
            Booking updatedBooking = bookingService.updateBooking(booking);
            return ResponseEntity.ok(updatedBooking);
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> cancelBooking(@PathVariable Long id) {
        bookingService.cancelBooking(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/stats/total")
    public ResponseEntity<Long> getTotalBookings() {
        Long total = bookingService.getTotalBookings();
        return ResponseEntity.ok(total);
    }

    @GetMapping("/stats/revenue")
    public ResponseEntity<Double> getTotalRevenue() {
        Double revenue = bookingService.getTotalRevenue();
        return ResponseEntity.ok(revenue);
    }
}
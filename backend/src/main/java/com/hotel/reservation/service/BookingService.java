package com.hotel.reservation.service;

import com.hotel.reservation.entity.Booking;
import com.hotel.reservation.entity.Room;
import com.hotel.reservation.entity.User;
import com.hotel.reservation.repository.BookingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Optional;

@Service
public class BookingService {

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private RoomService roomService;

    @Autowired
    private UserService userService;

    public List<Booking> getAllBookings() {
        return bookingRepository.findAll();
    }

    public List<Booking> getBookingsByUser(Long userId) {
        return bookingRepository.findByUserIdOrderByCreatedAtDesc(userId);
    }

    public Optional<Booking> getBookingById(Long id) {
        return bookingRepository.findById(id);
    }

    public Booking createBooking(Long userId, Long roomId, LocalDate checkIn, LocalDate checkOut, Integer guests) {
        Optional<User> user = userService.getUserById(userId);
        Optional<Room> room = roomService.getRoomById(roomId);

        if (user.isEmpty() || room.isEmpty()) {
            throw new RuntimeException("User or Room not found");
        }

        // Check if room is available for the dates
        List<Room> availableRooms = roomService.getAvailableRooms(room.get().getHotel().getId(), checkIn, checkOut, guests);
        if (!availableRooms.contains(room.get())) {
            throw new RuntimeException("Room is not available for the selected dates");
        }

        // Calculate total price
        long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
        double totalPrice = room.get().getPricePerNight() * nights;

        Booking booking = new Booking(checkIn, checkOut, guests, totalPrice, user.get(), room.get());
        return bookingRepository.save(booking);
    }

    public Booking updateBooking(Booking booking) {
        return bookingRepository.save(booking);
    }

    public void cancelBooking(Long id) {
        Optional<Booking> booking = bookingRepository.findById(id);
        if (booking.isPresent()) {
            booking.get().setStatus("CANCELLED");
            bookingRepository.save(booking.get());
        }
    }

    public Long getTotalBookings() {
        return bookingRepository.countConfirmedBookings();
    }

    public Double getTotalRevenue() {
        Double revenue = bookingRepository.sumTotalRevenue();
        return revenue != null ? revenue : 0.0;
    }
}
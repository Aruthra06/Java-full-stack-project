
CREATE DATABASE IF NOT EXISTS hotel_reservation;
USE hotel_reservation;


CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    role VARCHAR(20) DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE hotels (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    image_url VARCHAR(500) NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    amenities TEXT NOT NULL,
    available BOOLEAN DEFAULT TRUE
);


CREATE TABLE rooms (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) UNIQUE NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    price_per_night DOUBLE NOT NULL,
    description TEXT NOT NULL,
    available BOOLEAN DEFAULT TRUE,
    hotel_id BIGINT NOT NULL,
    FOREIGN KEY (hotel_id) REFERENCES hotels(id) ON DELETE CASCADE
);


CREATE TABLE bookings (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    number_of_guests INT NOT NULL,
    total_price DOUBLE NOT NULL,
    status VARCHAR(20) DEFAULT 'CONFIRMED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id BIGINT NOT NULL,
    room_id BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE
);


INSERT INTO users (name, email, password, phone, role) VALUES
('Admin User', 'admin@hotel.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '1234567890', 'ADMIN'),
('John Doe', 'john@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '9876543210', 'USER'),
('Jane Smith', 'jane@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '5556667777', 'USER');

INSERT INTO hotels (name, description, location, image_url, price_per_night, rating, amenities) VALUES
('Grand Palace Hotel', 'Luxury 5-star hotel with world-class amenities and stunning city views. Experience unparalleled comfort and elegance in the heart of the city.', 'New York, NY', 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800', 299.99, 5, 'Free WiFi, Swimming Pool, Spa, Fitness Center, Restaurant, Room Service, Concierge'),
('Ocean View Resort', 'Beachfront resort offering breathtaking ocean views and premium services. Perfect for relaxation and rejuvenation.', 'Miami, FL', 'https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9?w=800', 249.99, 4, 'Private Beach, Infinity Pool, Spa, Restaurant, Bar, Water Sports, Kids Club'),
('Mountain Lodge', 'Cozy mountain retreat surrounded by nature. Ideal for adventure seekers and those seeking peace and tranquility.', 'Aspen, CO', 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800', 199.99, 4, 'Fireplace, Hiking Trails, Ski Storage, Restaurant, Bar, Hot Tub, Game Room'),
('City Center Boutique', 'Modern boutique hotel in the heart of downtown. Stylish accommodations with contemporary design and urban convenience.', 'Los Angeles, CA', 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=800', 179.99, 4, 'Rooftop Bar, Fitness Center, Business Center, Valet Parking, Restaurant, Free WiFi'),
('Desert Oasis Spa', 'Tranquil desert retreat with luxurious spa facilities. Rejuvenate your body and mind in this peaceful sanctuary.', 'Phoenix, AZ', 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800', 229.99, 5, 'Full Spa, Desert Tours, Infinity Pool, Restaurant, Yoga Classes, Meditation Garden');


INSERT INTO rooms (room_number, room_type, capacity, price_per_night, description, hotel_id) VALUES
('101', 'Deluxe King', 2, 299.99, 'Spacious room with king bed, city view, and modern amenities', 1),
('102', 'Deluxe Twin', 2, 279.99, 'Comfortable room with two twin beds and city view', 1),
('201', 'Executive Suite', 4, 499.99, 'Luxurious suite with separate living area and premium amenities', 1),
('202', 'Presidential Suite', 6, 799.99, 'Ultimate luxury with panoramic city views and butler service', 1);


INSERT INTO rooms (room_number, room_type, capacity, price_per_night, description, hotel_id) VALUES
('101', 'Ocean View Room', 2, 249.99, 'Beautiful room with direct ocean views and balcony', 2),
('102', 'Beachfront Suite', 4, 399.99, 'Spacious suite with private beach access', 2),
('201', 'Family Room', 6, 349.99, 'Perfect for families with connecting rooms', 2);


INSERT INTO rooms (room_number, room_type, capacity, price_per_night, description, hotel_id) VALUES
('101', 'Mountain View Room', 2, 199.99, 'Cozy room with stunning mountain views', 3),
('102', 'Cabin Suite', 4, 299.99, 'Rustic suite with fireplace and mountain views', 3),
('201', 'Adventure Suite', 6, 399.99, 'Large suite perfect for groups and families', 3);

INSERT INTO rooms (room_number, room_type, capacity, price_per_night, description, hotel_id) VALUES
('101', 'Urban Deluxe', 2, 179.99, 'Modern room with city views and contemporary design', 4),
('102', 'Skyline Suite', 4, 299.99, 'Stunning suite with panoramic city skyline views', 4);


INSERT INTO rooms (room_number, room_type, capacity, price_per_night, description, hotel_id) VALUES
('101', 'Spa Retreat Room', 2, 229.99, 'Tranquil room designed for relaxation and wellness', 5),
('102', 'Desert Suite', 4, 379.99, 'Luxurious suite with private terrace and desert views', 5),
('201', 'Wellness Villa', 8, 599.99, 'Private villa perfect for wellness retreats and groups', 5);

INSERT INTO bookings (check_in_date, check_out_date, number_of_guests, total_price, user_id, room_id) VALUES
('2024-02-15', '2024-02-17', 2, 599.98, 2, 1),
('2024-02-20', '2024-02-22', 2, 499.98, 3, 5),
('2024-03-01', '2024-03-03', 4, 799.98, 2, 3);

// Hotel Reservation System JavaScript

const API_BASE_URL = 'http://localhost:8080/api';

// Global variables
let currentUser = null;
let selectedHotel = null;
let selectedRoom = null;

// DOM Content Loaded
document.addEventListener('DOMContentLoaded', function() {
    initializeApp();
    loadHotels();
    setupEventListeners();
    setupDateDefaults();
});

// Initialize Application
function initializeApp() {
    // Check if user is logged in
    const savedUser = localStorage.getItem('currentUser');
    if (savedUser) {
        currentUser = JSON.parse(savedUser);
        updateUIForLoggedInUser();
    }
}

// Setup Event Listeners
function setupEventListeners() {
    // Login Form
    document.getElementById('loginForm').addEventListener('submit', handleLogin);

    // Register Form
    document.getElementById('registerForm').addEventListener('submit', handleRegister);

    // Contact Form
    document.getElementById('contactForm').addEventListener('submit', handleContact);

    // Smooth scrolling for navigation
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
}

// Setup Date Defaults
function setupDateDefaults() {
    const today = new Date();
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    const checkInInput = document.getElementById('checkInDate');
    const checkOutInput = document.getElementById('checkOutDate');

    checkInInput.value = formatDate(today);
    checkOutInput.value = formatDate(tomorrow);

    // Set minimum dates
    checkInInput.min = formatDate(today);
    checkOutInput.min = formatDate(tomorrow);
}

// Format Date for Input Fields
function formatDate(date) {
    return date.toISOString().split('T')[0];
}

// Load Hotels
async function loadHotels() {
    try {
        const response = await fetch(`${API_BASE_URL}/hotels`);
        const hotels = await response.json();

        if (response.ok) {
            displayHotels(hotels);
        } else {
            showError('Failed to load hotels');
        }
    } catch (error) {
        console.error('Error loading hotels:', error);
        showError('Network error. Please try again later.');
    }
}

// Display Hotels
function displayHotels(hotels) {
    const container = document.getElementById('hotelsContainer');
    container.innerHTML = '';

    hotels.forEach(hotel => {
        const hotelCard = createHotelCard(hotel);
        container.appendChild(hotelCard);
    });
}

// Create Hotel Card
function createHotelCard(hotel) {
    const col = document.createElement('div');
    col.className = 'col-lg-4 col-md-6';

    const stars = '★'.repeat(hotel.rating) + '☆'.repeat(5 - hotel.rating);

    col.innerHTML = `
        <div class="hotel-card">
            <div class="hotel-image">
                <img src="${hotel.imageUrl}" alt="${hotel.name}" onerror="this.src='https://images.unsplash.com/photo-1564501049412-61c2a3083791?w=400'">
                <div class="hotel-overlay"></div>
                <div class="hotel-price">$${hotel.pricePerNight}/night</div>
            </div>
            <div class="hotel-content">
                <h3 class="hotel-title">${hotel.name}</h3>
                <div class="hotel-location">
                    <i class="fas fa-map-marker-alt"></i> ${hotel.location}
                </div>
                <div class="hotel-rating">
                    <span class="stars">${stars}</span>
                    <span class="rating-text">${hotel.rating}/5</span>
                </div>
                <p class="hotel-description">${hotel.description}</p>
                <div class="hotel-amenities">
                    ${hotel.amenities.split(', ').slice(0, 3).map(amenity =>
                        `<span class="amenity-tag">${amenity}</span>`
                    ).join('')}
                </div>
                <div class="hotel-actions">
                    <button class="btn btn-primary" onclick="viewHotelDetails(${hotel.id})">
                        <i class="fas fa-eye"></i> View Details
                    </button>
                    <button class="btn btn-outline-primary" onclick="bookHotel(${hotel.id})">
                        <i class="fas fa-calendar-check"></i> Book Now
                    </button>
                </div>
            </div>
        </div>
    `;

    return col;
}

// Search Hotels
async function searchHotels() {
    const location = document.getElementById('searchLocation').value;
    const checkIn = document.getElementById('checkInDate').value;
    const checkOut = document.getElementById('checkOutDate').value;
    const guests = document.getElementById('guests').value;

    if (!location.trim()) {
        showError('Please enter a location to search');
        return;
    }

    try {
        const response = await fetch(`${API_BASE_URL}/hotels/search/location?location=${encodeURIComponent(location)}`);
        const hotels = await response.json();

        if (response.ok && hotels.length > 0) {
            displayHotels(hotels);
            // Scroll to hotels section
            document.getElementById('hotels').scrollIntoView({ behavior: 'smooth' });
        } else {
            showError('No hotels found for the specified location');
        }
    } catch (error) {
        console.error('Error searching hotels:', error);
        showError('Network error. Please try again later.');
    }
}

// View Hotel Details
async function viewHotelDetails(hotelId) {
    try {
        const response = await fetch(`${API_BASE_URL}/hotels/${hotelId}`);
        const hotel = await response.json();

        if (response.ok) {
            selectedHotel = hotel;
            showHotelDetailsModal(hotel);
        } else {
            showError('Failed to load hotel details');
        }
    } catch (error) {
        console.error('Error loading hotel details:', error);
        showError('Network error. Please try again later.');
    }
}

// Show Hotel Details Modal
function showHotelDetailsModal(hotel) {
    const stars = '★'.repeat(hotel.rating) + '☆'.repeat(5 - hotel.rating);

    const modal = new bootstrap.Modal(document.getElementById('bookingModal'));
    document.getElementById('bookingContent').innerHTML = `
        <div class="hotel-detail-modal">
            <div class="row">
                <div class="col-md-6">
                    <img src="${hotel.imageUrl}" alt="${hotel.name}" class="img-fluid rounded mb-3" onerror="this.src='https://images.unsplash.com/photo-1564501049412-61c2a3083791?w=400'">
                </div>
                <div class="col-md-6">
                    <h3>${hotel.name}</h3>
                    <div class="mb-2">
                        <i class="fas fa-map-marker-alt"></i> ${hotel.location}
                    </div>
                    <div class="mb-2">
                        <span class="stars">${stars}</span>
                        <span class="ms-2">${hotel.rating}/5</span>
                    </div>
                    <div class="mb-3">
                        <span class="h4 text-primary">$${hotel.pricePerNight}</span>
                        <small class="text-muted">/night</small>
                    </div>
                    <p class="mb-3">${hotel.description}</p>
                    <div class="mb-3">
                        <h5>Amenities:</h5>
                        <div class="d-flex flex-wrap gap-2">
                            ${hotel.amenities.split(', ').map(amenity =>
                                `<span class="badge bg-primary">${amenity}</span>`
                            ).join('')}
                        </div>
                    </div>
                    <button class="btn btn-primary btn-lg" onclick="bookHotel(${hotel.id})">
                        <i class="fas fa-calendar-check"></i> Book This Hotel
                    </button>
                </div>
            </div>
        </div>
    `;
    modal.show();
}

// Book Hotel
function bookHotel(hotelId) {
    if (!currentUser) {
        showLoginModal();
        return;
    }

    // Load available rooms for this hotel
    loadAvailableRooms(hotelId);
}

// Load Available Rooms
async function loadAvailableRooms(hotelId) {
    const checkIn = document.getElementById('checkInDate').value;
    const checkOut = document.getElementById('checkOutDate').value;
    const guests = document.getElementById('guests').value;

    try {
        const response = await fetch(`${API_BASE_URL}/rooms/available?hotelId=${hotelId}&checkIn=${checkIn}&checkOut=${checkOut}&guests=${guests}`);
        const rooms = await response.json();

        if (response.ok) {
            showRoomSelectionModal(rooms, checkIn, checkOut, guests);
        } else {
            showError('Failed to load available rooms');
        }
    } catch (error) {
        console.error('Error loading rooms:', error);
        showError('Network error. Please try again later.');
    }
}

// Show Room Selection Modal
function showRoomSelectionModal(rooms, checkIn, checkOut, guests) {
    const modal = new bootstrap.Modal(document.getElementById('bookingModal'));

    let roomsHtml = '';
    if (rooms.length === 0) {
        roomsHtml = '<div class="alert alert-warning">No rooms available for the selected dates.</div>';
    } else {
        roomsHtml = rooms.map(room => `
            <div class="room-option border rounded p-3 mb-3" onclick="selectRoom(${room.id})">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="mb-1">${room.roomType} - ${room.roomNumber}</h5>
                        <p class="mb-1 text-muted">${room.description}</p>
                        <small class="text-muted">Capacity: ${room.capacity} guests</small>
                    </div>
                    <div class="text-end">
                        <div class="h5 text-primary mb-0">$${room.pricePerNight}</div>
                        <small class="text-muted">per night</small>
                    </div>
                </div>
            </div>
        `).join('');
    }

    document.getElementById('bookingContent').innerHTML = `
        <div class="room-selection-modal">
            <h4>Select Your Room</h4>
            <div class="booking-summary bg-light p-3 rounded mb-4">
                <div class="row">
                    <div class="col-md-3">
                        <strong>Check-in:</strong><br>
                        ${new Date(checkIn).toLocaleDateString()}
                    </div>
                    <div class="col-md-3">
                        <strong>Check-out:</strong><br>
                        ${new Date(checkOut).toLocaleDateString()}
                    </div>
                    <div class="col-md-3">
                        <strong>Guests:</strong><br>
                        ${guests}
                    </div>
                    <div class="col-md-3">
                        <strong>Nights:</strong><br>
                        ${Math.ceil((new Date(checkOut) - new Date(checkIn)) / (1000 * 60 * 60 * 24))}
                    </div>
                </div>
            </div>
            <div class="rooms-list">
                ${roomsHtml}
            </div>
            <div class="text-center mt-4">
                <button class="btn btn-secondary me-2" data-bs-dismiss="modal">Cancel</button>
                <button class="btn btn-primary" id="confirmBookingBtn" disabled onclick="confirmBooking('${checkIn}', '${checkOut}', ${guests})">
                    Confirm Booking
                </button>
            </div>
        </div>
    `;
    modal.show();
}

// Select Room
function selectRoom(roomId) {
    selectedRoom = roomId;

    // Remove previous selection
    document.querySelectorAll('.room-option').forEach(option => {
        option.classList.remove('border-primary', 'bg-light');
    });

    // Add selection to clicked room
    event.currentTarget.classList.add('border-primary', 'bg-light');

    // Enable confirm button
    document.getElementById('confirmBookingBtn').disabled = false;
}

// Confirm Booking
async function confirmBooking(checkIn, checkOut, guests) {
    if (!selectedRoom) {
        showError('Please select a room');
        return;
    }

    try {
        const bookingData = {
            userId: currentUser.id,
            roomId: selectedRoom,
            checkInDate: checkIn,
            checkOutDate: checkOut,
            numberOfGuests: guests
        };

        const response = await fetch(`${API_BASE_URL}/bookings`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(bookingData)
        });

        const result = await response.json();

        if (response.ok) {
            // Close booking modal
            bootstrap.Modal.getInstance(document.getElementById('bookingModal')).hide();

            // Show success modal
            const successModal = new bootstrap.Modal(document.getElementById('successModal'));
            successModal.show();

            // Reset selection
            selectedRoom = null;
        } else {
            showError(result.message || 'Failed to create booking');
        }
    } catch (error) {
        console.error('Error creating booking:', error);
        showError('Network error. Please try again later.');
    }
}

// Handle Login
async function handleLogin(event) {
    event.preventDefault();

    const email = document.getElementById('loginEmail').value;
    const password = document.getElementById('loginPassword').value;

    try {
        const response = await fetch(`${API_BASE_URL}/auth/login`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ email, password })
        });

        const result = await response.json();

        if (response.ok && result.success) {
            currentUser = result.user;
            localStorage.setItem('currentUser', JSON.stringify(currentUser));

            // Close modal and update UI
            bootstrap.Modal.getInstance(document.getElementById('loginModal')).hide();
            updateUIForLoggedInUser();

            showSuccess('Login successful!');
        } else {
            showError(result.message || 'Login failed');
        }
    } catch (error) {
        console.error('Error logging in:', error);
        showError('Network error. Please try again later.');
    }
}

// Handle Register
async function handleRegister(event) {
    event.preventDefault();

    const name = document.getElementById('registerName').value;
    const email = document.getElementById('registerEmail').value;
    const phone = document.getElementById('registerPhone').value;
    const password = document.getElementById('registerPassword').value;

    try {
        const response = await fetch(`${API_BASE_URL}/auth/register`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ name, email, phone, password })
        });

        const result = await response.json();

        if (response.ok && result.success) {
            currentUser = result.user;
            localStorage.setItem('currentUser', JSON.stringify(currentUser));

            // Close modal and update UI
            bootstrap.Modal.getInstance(document.getElementById('registerModal')).hide();
            updateUIForLoggedInUser();

            showSuccess('Registration successful!');
        } else {
            showError(result.message || 'Registration failed');
        }
    } catch (error) {
        console.error('Error registering:', error);
        showError('Network error. Please try again later.');
    }
}

// Handle Contact Form
function handleContact(event) {
    event.preventDefault();
    showSuccess('Thank you for your message! We will get back to you soon.');
    event.target.reset();
}

// Update UI for Logged In User
function updateUIForLoggedInUser() {
    const navButtons = document.querySelector('.navbar-nav');
    navButtons.innerHTML = `
        <li class="nav-item">
            <a class="nav-link" href="#home">Home</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#hotels">Hotels</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#about">About</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#contact">Contact</a>
        </li>
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                <i class="fas fa-user"></i> ${currentUser.name}
            </a>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="#" onclick="viewBookings()">My Bookings</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item" href="#" onclick="logout()">Logout</a></li>
            </ul>
        </li>
    `;
}

// Logout
function logout() {
    currentUser = null;
    localStorage.removeItem('currentUser');
    location.reload();
}

// View Bookings
function viewBookings() {
    // This would typically navigate to a bookings page
    alert('Bookings page would be implemented here');
}

// Show Login Modal
function showLoginModal() {
    const modal = new bootstrap.Modal(document.getElementById('loginModal'));
    modal.show();
}

// Show Register Modal
function showRegisterModal() {
    const modal = new bootstrap.Modal(document.getElementById('registerModal'));
    modal.show();
}

// Switch to Register Modal
function switchToRegister() {
    bootstrap.Modal.getInstance(document.getElementById('loginModal')).hide();
    setTimeout(() => showRegisterModal(), 300);
}

// Switch to Login Modal
function switchToLogin() {
    bootstrap.Modal.getInstance(document.getElementById('registerModal')).hide();
    setTimeout(() => showLoginModal(), 300);
}

// Show Success Message
function showSuccess(message) {
    // Simple alert for now - could be enhanced with toast notifications
    alert('✅ ' + message);
}

// Show Error Message
function showError(message) {
    // Simple alert for now - could be enhanced with toast notifications
    alert('❌ ' + message);
}

// Utility Functions
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// Add loading state to buttons
function setLoading(button, loading = true) {
    if (loading) {
        button.disabled = true;
        button.innerHTML = '<span class="loading"></span> Loading...';
    } else {
        button.disabled = false;
        // Restore original text (this would need to be enhanced)
        button.innerHTML = button.getAttribute('data-original-text') || 'Submit';
    }
}
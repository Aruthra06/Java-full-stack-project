// Dashboard JavaScript

const API_BASE_URL = 'http://localhost:8080/api';
let currentUser = null;

// DOM Content Loaded
document.addEventListener('DOMContentLoaded', function() {
    initializeDashboard();
});

// Initialize Dashboard
function initializeDashboard() {
    // Check if user is logged in
    const savedUser = localStorage.getItem('currentUser');
    if (!savedUser) {
        window.location.href = 'index.html';
        return;
    }

    currentUser = JSON.parse(savedUser);
    document.getElementById('userName').textContent = currentUser.name;

    loadDashboardData();
    loadBookings();
}

// Load Dashboard Data
async function loadDashboardData() {
    try {
        // Load booking statistics
        const bookingsResponse = await fetch(`${API_BASE_URL}/bookings/user/${currentUser.id}`);
        const bookings = await bookingsResponse.json();

        if (bookingsResponse.ok) {
            updateStatistics(bookings);
        }
    } catch (error) {
        console.error('Error loading dashboard data:', error);
        showError('Failed to load dashboard data');
    }
}

// Update Statistics
function updateStatistics(bookings) {
    const totalBookings = bookings.length;
    const upcomingBookings = bookings.filter(booking =>
        new Date(booking.checkInDate) > new Date()
    ).length;

    // Calculate total spent (mock calculation)
    const totalSpent = bookings.reduce((total, booking) => total + booking.totalPrice, 0);

    document.getElementById('totalBookings').textContent = totalBookings;
    document.getElementById('upcomingBookings').textContent = upcomingBookings;
    document.getElementById('totalSpent').textContent = `$${totalSpent.toFixed(2)}`;
    document.getElementById('loyaltyPoints').textContent = totalBookings * 10; // Mock loyalty points
}

// Load Bookings
async function loadBookings() {
    try {
        const response = await fetch(`${API_BASE_URL}/bookings/user/${currentUser.id}`);
        const bookings = await response.json();

        if (response.ok) {
            displayBookings(bookings);
        } else {
            showError('Failed to load bookings');
        }
    } catch (error) {
        console.error('Error loading bookings:', error);
        showError('Network error. Please try again later.');
    }
}

// Display Bookings
function displayBookings(bookings) {
    const container = document.getElementById('bookingsContainer');

    if (bookings.length === 0) {
        container.innerHTML = `
            <div class="text-center py-5">
                <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                <h4>No bookings found</h4>
                <p>You haven't made any bookings yet.</p>
                <a href="index.html" class="btn btn-primary">Browse Hotels</a>
            </div>
        `;
        return;
    }

    const bookingsHtml = bookings.map(booking => {
        const checkInDate = new Date(booking.checkInDate).toLocaleDateString();
        const checkOutDate = new Date(booking.checkOutDate).toLocaleDateString();
        const statusClass = getStatusClass(booking.status);
        const statusText = booking.status.charAt(0).toUpperCase() + booking.status.slice(1).toLowerCase();

        return `
            <div class="booking-card mb-3">
                <div class="card">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-md-2">
                                <div class="booking-id">
                                    <small class="text-muted">Booking ID</small>
                                    <div class="fw-bold">#${booking.id}</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="booking-dates">
                                    <small class="text-muted">Check-in</small>
                                    <div class="fw-bold">${checkInDate}</div>
                                    <small class="text-muted">Check-out</small>
                                    <div>${checkOutDate}</div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="booking-guests">
                                    <small class="text-muted">Guests</small>
                                    <div class="fw-bold">${booking.numberOfGuests}</div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="booking-price">
                                    <small class="text-muted">Total</small>
                                    <div class="fw-bold text-primary">$${booking.totalPrice.toFixed(2)}</div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <span class="badge ${statusClass}">${statusText}</span>
                            </div>
                            <div class="col-md-1">
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                        <i class="fas fa-ellipsis-v"></i>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="#" onclick="viewBookingDetails(${booking.id})">
                                            <i class="fas fa-eye"></i> View Details
                                        </a></li>
                                        ${booking.status === 'CONFIRMED' ? `
                                        <li><a class="dropdown-item text-danger" href="#" onclick="cancelBooking(${booking.id})">
                                            <i class="fas fa-times"></i> Cancel Booking
                                        </a></li>
                                        ` : ''}
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `;
    }).join('');

    container.innerHTML = bookingsHtml;
}

// Get Status Class for Badge
function getStatusClass(status) {
    switch (status.toLowerCase()) {
        case 'confirmed':
            return 'bg-success';
        case 'cancelled':
            return 'bg-danger';
        case 'pending':
            return 'bg-warning';
        default:
            return 'bg-secondary';
    }
}

// View Booking Details
function viewBookingDetails(bookingId) {
    // This would open a modal with detailed booking information
    alert('Booking details modal would be implemented here. Booking ID: ' + bookingId);
}

// Cancel Booking
async function cancelBooking(bookingId) {
    if (!confirm('Are you sure you want to cancel this booking?')) {
        return;
    }

    try {
        const response = await fetch(`${API_BASE_URL}/bookings/${bookingId}`, {
            method: 'DELETE'
        });

        if (response.ok) {
            showSuccess('Booking cancelled successfully');
            loadBookings(); // Reload bookings
            loadDashboardData(); // Reload statistics
        } else {
            showError('Failed to cancel booking');
        }
    } catch (error) {
        console.error('Error cancelling booking:', error);
        showError('Network error. Please try again later.');
    }
}

// Edit Profile
function editProfile() {
    alert('Profile editing would be implemented here');
}

// View History
function viewHistory() {
    // This could filter to show only past bookings
    alert('Booking history view would be implemented here');
}

// Contact Support
function contactSupport() {
    alert('Support contact would be implemented here');
}

// Logout
function logout() {
    localStorage.removeItem('currentUser');
    window.location.href = 'index.html';
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
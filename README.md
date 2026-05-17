# 🏨 LuxeStay - Modern Hotel Reservation System

A full-stack hotel reservation system built with Spring Boot, MySQL, and modern web technologies. Features a beautiful, responsive frontend with glassmorphism effects, 3D animations, and a robust backend API.

![Hotel Reservation System](https://images.unsplash.com/photo-1564501049412-61c2a3083791?w=800)

## ✨ Features

### Frontend Features
- 🎨 **Modern UI Design** - Glassmorphism effects and dark theme
- 📱 **Fully Responsive** - Works on all devices
- ✨ **3D Animations** - Smooth hover effects and transitions
- 🔍 **Advanced Search** - Search by location, dates, and guest count
- 🏨 **Hotel Cards** - Interactive hotel listings with ratings
- 📅 **Booking System** - Complete reservation workflow
- 👤 **User Authentication** - Login and registration
- 💬 **AI Chatbot UI** - Modern chatbot interface (frontend only)

### Backend Features
- 🔧 **Spring Boot API** - RESTful web services
- 🗄️ **MySQL Database** - Relational data storage
- 🔐 **Security** - Password encryption and authentication
- 📊 **Statistics** - Booking and revenue analytics
- 🏗️ **Layered Architecture** - Clean separation of concerns

## 🛠️ Technology Stack

### Backend
- **Java 17**
- **Spring Boot 3.1.0**
- **Spring Data JPA**
- **Spring Security**
- **MySQL 8.0**
- **Maven**

### Frontend
- **HTML5**
- **CSS3** (Modern styling with animations)
- **JavaScript** (ES6+)
- **Bootstrap 5.3**
- **Font Awesome Icons**

## 🚀 Quick Start (3 Steps)

### Step 1: Install Prerequisites
```bash
# Required Software:
# 1. Java 17 - https://adoptium.net/temurin/releases/
# 2. Apache Maven - https://maven.apache.org/download.cgi
# 3. MySQL 8.0 - https://dev.mysql.com/downloads/mysql/
```

### Step 2: Setup Database
```sql
# Open MySQL Workbench and run:
source database/schema.sql
```

### Step 3: Run the Application
```bash
# Option A: Use automated script (Windows)
double-click simple-setup.bat

# Option B: Manual setup
cd backend && mvn spring-boot:run
# Then open frontend/index.html in browser
```

### Test Credentials
- **Admin:** admin@hotel.com / password
- **User:** john@example.com / password

---

## 📋 Detailed Setup Instructions

```
hotel-reservation-system/
├── frontend/
│   ├── index.html          # Main homepage
│   ├── css/
│   │   └── style.css       # Modern styling with animations
│   └── js/
│       └── script.js       # Frontend functionality
├── backend/
│   ├── src/main/java/com/hotel/reservation/
│   │   ├── HotelReservationApplication.java
│   │   ├── entity/         # JPA Entities
│   │   │   ├── User.java
│   │   │   ├── Hotel.java
│   │   │   ├── Room.java
│   │   │   └── Booking.java
│   │   ├── repository/     # Data Access Layer
│   │   ├── service/        # Business Logic Layer
│   │   ├── controller/     # REST Controllers
│   │   └── config/         # Configuration Classes
│   ├── src/main/resources/
│   │   └── application.properties
│   └── pom.xml
├── database/
│   └── schema.sql          # Database schema and sample data
└── README.md
```

## 🚀 Quick Start

### Prerequisites

- **Java 17** or higher
- **MySQL 8.0** or higher
- **Maven 3.6+**
- **Git**

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/hotel-reservation-system.git
cd hotel-reservation-system
```

### 2. Database Setup

#### Option A: Using MySQL Command Line
```bash
# Login to MySQL
mysql -u root -p

# Create database and run schema
source database/schema.sql
```

#### Option B: Using MySQL Workbench
1. Open MySQL Workbench
2. Connect to your MySQL server
3. Open `database/schema.sql`
4. Execute the script

### 3. Backend Setup

1. **Navigate to backend directory:**
   ```bash
   cd backend
   ```

2. **Update database configuration** in `src/main/resources/application.properties`:
   ```properties
   spring.datasource.username=your_mysql_username
   spring.datasource.password=your_mysql_password
   ```

3. **Run the Spring Boot application:**
   ```bash
   mvn spring-boot:run
   ```

   The backend will start on `http://localhost:8080`

### 4. Frontend Setup

1. **Navigate to frontend directory:**
   ```bash
   cd ../frontend
   ```

2. **Open `index.html` in your browser:**
   - You can open it directly in a browser (Chrome recommended)
   - Or serve it using a local server:
     ```bash
     # Using Python
     python -m http.server 3000

     # Using Node.js (if you have http-server installed)
     npx http-server -p 3000
     ```

3. **Access the application:**
   - Frontend: `http://localhost:3000` (or open `index.html` directly)
   - Backend API: `http://localhost:8080`

## 🔧 Configuration

### Database Configuration

Edit `backend/src/main/resources/application.properties`:

```properties
# Database
spring.datasource.url=jdbc:mysql://localhost:3306/hotel_reservation?createDatabaseIfNotExist=true
spring.datasource.username=your_username
spring.datasource.password=your_password

# JPA
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

### CORS Configuration

The backend is configured to accept requests from `http://localhost:3000`. To change this, modify the CORS settings in `SecurityConfig.java`.

## 📊 API Endpoints

### Authentication
- `POST /api/auth/register` - User registration
- `POST /api/auth/login` - User login

### Hotels
- `GET /api/hotels` - Get all hotels
- `GET /api/hotels/{id}` - Get hotel by ID
- `GET /api/hotels/search/location?location={location}` - Search hotels by location
- `POST /api/hotels` - Create new hotel (admin)

### Rooms
- `GET /api/rooms/hotel/{hotelId}` - Get rooms for a hotel
- `GET /api/rooms/available?hotelId={id}&checkIn={date}&checkOut={date}&guests={count}` - Get available rooms

### Bookings
- `GET /api/bookings/user/{userId}` - Get user bookings
- `POST /api/bookings` - Create new booking
- `GET /api/bookings/stats/total` - Get total bookings count
- `GET /api/bookings/stats/revenue` - Get total revenue

## 🎨 UI Features

### Modern Design Elements
- **Glassmorphism Effects** - Translucent backgrounds with blur
- **Dark Theme** - Modern dark color scheme with blue accents
- **3D Hover Animations** - Cards lift and images scale on hover
- **Smooth Transitions** - All interactions are animated
- **Responsive Grid** - Adapts to all screen sizes

### Interactive Components
- **Hotel Cards** - With ratings, amenities, and booking buttons
- **Search Interface** - Location, date, and guest selection
- **Modal Dialogs** - For login, registration, and booking
- **Form Validation** - Real-time validation feedback

## 🔐 Security Features

- **Password Encryption** - BCrypt hashing
- **CORS Protection** - Configured for frontend origin
- **Input Validation** - Server-side validation
- **SQL Injection Prevention** - Parameterized queries

## 📱 Responsive Design

The application is fully responsive and works on:
- 📱 Mobile phones (320px+)
- 📱 Tablets (768px+)
- 💻 Laptops (1024px+)
- 🖥️ Desktops (1200px+)

## 🧪 Testing the Application

### Sample Users
- **Admin:** admin@hotel.com / password
- **User:** john@example.com / password

### Test Scenarios
1. **Browse Hotels** - View all available hotels
2. **Search** - Search by location (e.g., "New York")
3. **Register/Login** - Create account or login
4. **Book Hotel** - Complete booking workflow
5. **View Bookings** - Check booking history

## 🚀 Deployment

### Backend Deployment
```bash
# Build the application
mvn clean package

# Run the JAR file
java -jar target/hotel-reservation-0.0.1-SNAPSHOT.jar
```

### Frontend Deployment
- Host the `frontend/` directory on any web server
- For production, consider using Nginx or Apache

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support, email support@luxestay.com or create an issue in this repository.

## 🙏 Acknowledgments

- Images from [Unsplash](https://unsplash.com)
- Icons from [Font Awesome](https://fontawesome.com)
- UI Framework from [Bootstrap](https://getbootstrap.com)

---

**Made with ❤️ for the final year engineering project showcase**
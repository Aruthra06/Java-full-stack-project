# 🎯 LuxeStay - Pre-Launch Checklist

## ✅ **Prerequisites Check**

- [ ] **Java 17 Installed**
  ```powershell
  java -version
  ```
  Should show: `openjdk version "17.x.x"`

- [ ] **Maven Installed**
  ```powershell
  mvn -version
  ```
  Should show: `Apache Maven 3.x.x`

- [ ] **MySQL Installed & Running**
  - Check Windows Services (search: "Services")
  - Look for "MySQL80" status: Running
  - Or check: `mysql -u root -p` (should connect)

---

## 🗄️ **Database Setup**

- [ ] **Database Schema Executed**
  ```sql
  # Run in MySQL:
  source database/schema.sql
  ```
  
  Verify tables were created:
  ```sql
  USE hotel_reservation;
  SHOW TABLES;
  ```
  Should show: users, hotels, rooms, bookings

- [ ] **Sample Data Loaded**
  ```sql
  SELECT COUNT(*) FROM hotels;
  ```
  Should show: 5 hotels

---

## 🚀 **Ready to Launch**

### **Option A: One-Click (Recommended)**
- [ ] Double-click `RUN.bat`
- [ ] Wait for:
  - Backend window to open
  - Frontend to open in browser
  - Message: "Started HotelReservationApplication"

### **Option B: PowerShell**
```powershell
.\auto-setup.ps1
```

### **Option C: Manual - Terminal 1 (Backend)**
```powershell
cd backend
mvn spring-boot:run
```
Wait for: ✅ `Started HotelReservationApplication in X.XXX seconds`

### **Option D: Manual - Terminal 2 (Frontend)**
```powershell
Start-Process "frontend/index.html"
```

---

## 🧪 **Verification Tests**

### **Test 1: Frontend Opens**
- [ ] Browser opens with LuxeStay homepage
- [ ] Can see 5 hotel cards
- [ ] Hotel images load

### **Test 2: Backend is Running**
```powershell
# In PowerShell:
Invoke-WebRequest -Uri "http://localhost:8080/api/hotels"
```
Should return JSON list of 5 hotels

### **Test 3: Database Connection**
- [ ] No red errors in backend console
- [ ] Hotels display on frontend
- [ ] Can click "View Details" on any hotel

### **Test 4: User Registration**
- [ ] Click "Register" button
- [ ] Fill in form (Name, Email, Phone, Password)
- [ ] Submit
- [ ] Should see success message

### **Test 5: User Login**
- [ ] Click "Login"
- [ ] Use credentials: `john@example.com / password`
- [ ] Should log in successfully
- [ ] Nav bar shows username

### **Test 6: Hotel Booking**
- [ ] Click "Book Now" on a hotel
- [ ] Select check-in/out dates
- [ ] Click "Search Available Rooms"
- [ ] Select a room
- [ ] Complete booking
- [ ] See success confirmation

### **Test 7: User Dashboard**
- [ ] Open: `frontend/dashboard.html`
- [ ] Should show:
  - Welcome message with user name
  - Total bookings count
  - Your bookings listed
  - Quick action buttons

---

## 🔧 **Quick Troubleshooting**

### ❌ Backend Won't Start
```
✓ Check: java -version
✓ Check: mvn -version
✓ Check: MySQL running
✓ Wait 30-60 seconds for Spring Boot startup
✓ Check backend console for errors
```

### ❌ Frontend Won't Load
```
✓ Backend must be running first
✓ Clear browser cache (Ctrl+Shift+Delete)
✓ Try different browser (Chrome recommended)
✓ Check if port 8080 is available
```

### ❌ Database Connection Error
```
✓ MySQL must be running (Windows Services)
✓ Check: mysql -u root -p
✓ Run schema.sql again
✓ Check credentials in application.properties
```

### ❌ Hotels Not Showing
```
✓ Database must be set up
✓ Backend must be running
✓ Refresh browser (F5)
✓ Check browser console (F12)
```

---

## 📊 **Expected Port Usage**

- [ ] **Port 8080**: Backend API (Spring Boot)
- [ ] **Port 3306**: MySQL Database
- [ ] **Local File**: Frontend (no port needed)

---

## 🎮 **Test Account Credentials**

### Admin Account
```
Email: admin@hotel.com
Password: password
```

### User Account
```
Email: john@example.com
Password: password
```

### Create New Account
```
Click "Register" and fill form
```

---

## ✨ **Success Indicators**

You'll know it's working when you see:

1. ✅ Backend window shows:
   ```
   [INFO] Started HotelReservationApplication
   ```

2. ✅ Frontend shows:
   - LuxeStay logo
   - 5 hotel cards with images
   - Search bar
   - Login/Register buttons

3. ✅ Can perform:
   - Browse hotels
   - Search by location
   - Register new user
   - Login with credentials
   - View hotel details
   - Book a hotel
   - View booking in dashboard

---

## 🎊 **All Set!**

If all checks pass, your Hotel Reservation System is fully operational!

### **Next Steps:**
1. Explore the application
2. Test booking a hotel
3. View your dashboard
4. Deploy to production when ready

---

## 📞 **Support**

If you encounter issues:
1. Check this checklist again
2. Read `HOW_TO_RUN.md` for detailed instructions
3. Review `README.md` for complete documentation
4. Check browser console for JavaScript errors (F12)
5. Check backend terminal for Java errors
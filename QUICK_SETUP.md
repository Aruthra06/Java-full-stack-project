# LuxeStay - Quick Setup Guide

## 🚀 Quick Setup Instructions

### Prerequisites Installation

#### 1. Install Java 17
- Download from: https://adoptium.net/temurin/releases/
- Choose: Windows x64 MSI
- Install with default settings
- Verify: Open Command Prompt and run `java -version`

#### 2. Install Apache Maven
- Download from: https://maven.apache.org/download.cgi
- Download: apache-maven-3.9.5-bin.zip
- Extract to: C:\Program Files\Apache\Maven
- Add to PATH: C:\Program Files\Apache\Maven\apache-maven-3.9.5\bin
- Verify: Open Command Prompt and run `mvn -version`

#### 3. Install MySQL
- Download from: https://dev.mysql.com/downloads/mysql/
- Choose: MySQL Installer for Windows
- Install with "Developer Default" setup
- Set root password: `your_password_here`
- Verify: MySQL should be running as a service

### Database Setup

1. Open MySQL Workbench or Command Line Client
2. Connect to your MySQL server
3. Run the following commands:

```sql
-- Create database
CREATE DATABASE IF NOT EXISTS hotel_reservation;
USE hotel_reservation;

-- Run the schema (copy from database/schema.sql)
-- Or run: source C:\Users\Admin\Documents\Hotel management\database\schema.sql
```

### Project Setup

1. **Open Command Prompt as Administrator**
2. Navigate to project directory:
   ```cmd
   cd "C:\Users\Admin\Documents\Hotel management"
   ```

3. **Start Backend:**
   ```cmd
   cd backend
   mvn spring-boot:run
   ```
   Backend will start on http://localhost:8080

4. **Open Frontend:**
   - Open `frontend/index.html` in your web browser
   - Or use a local server:
   ```cmd
   cd frontend
   npx http-server -p 3000
   ```

### Test the Application

- **Frontend:** Open in browser
- **Backend API:** http://localhost:8080
- **Test Credentials:**
  - Admin: admin@hotel.com / password
  - User: john@example.com / password

### Troubleshooting

#### Java Not Found
- Check if JAVA_HOME is set: `echo %JAVA_HOME%`
- Add Java bin to PATH: `C:\Program Files\Eclipse Adoptium\jdk-17.x.x.x\bin`

#### Maven Not Found
- Check if MAVEN_HOME is set: `echo %MAVEN_HOME%`
- Add Maven bin to PATH: `C:\Program Files\Apache\Maven\apache-maven-3.9.5\bin`

#### MySQL Connection Issues
- Ensure MySQL service is running
- Check credentials in `backend/src/main/resources/application.properties`
- Update password if different: `spring.datasource.password=your_actual_password`

#### Port Already in Use
- Change port in `application.properties`: `server.port=8081`

### Alternative: Use the PowerShell Script

If you prefer automated setup, run the PowerShell script:

1. Open PowerShell as Administrator
2. Enable script execution:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
3. Run the setup script:
   ```powershell
   .\complete-setup.ps1
   ```

### Features to Test

1. **Homepage:** Browse hotels, search functionality
2. **Authentication:** Register new user, login
3. **Booking:** Select hotel → Choose room → Confirm booking
4. **Dashboard:** View bookings, manage account
5. **Admin Features:** All CRUD operations via API

### Deployment Ready

Once everything is working locally, you can deploy:

- **Backend:** Heroku, AWS, DigitalOcean
- **Frontend:** Netlify, Vercel, GitHub Pages
- **Database:** AWS RDS, PlanetScale, Railway

---

**Need help? Check the README.md for detailed documentation!**
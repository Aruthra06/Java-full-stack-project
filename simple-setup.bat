@echo off
REM LuxeStay - Simple Setup and Test Script

echo ========================================
echo   LuxeStay Hotel Reservation System
echo   Simple Setup Script
echo ========================================
echo.

cd /d "%~dp0"

echo Checking prerequisites...
echo.

REM Check Java
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Java is not installed!
    echo Please install Java 17 from: https://adoptium.net/temurin/releases/
    echo.
    echo Press any key to exit...
    pause >nul
    exit /b 1
) else (
    echo ✓ Java is installed
)

REM Check Maven
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Maven is not installed!
    echo Please install Maven from: https://maven.apache.org/download.cgi
    echo.
    echo Press any key to exit...
    pause >nul
    exit /b 1
) else (
    echo ✓ Maven is installed
)

echo.
echo Database Setup Instructions:
echo =============================
echo.
echo 1. Make sure MySQL is installed and running
echo 2. Open MySQL Workbench or Command Line Client
echo 3. Run the following commands:
echo.
echo    mysql -u root -p
echo    source database\schema.sql
echo.
echo 4. When prompted for password, enter your MySQL root password
echo.

set /p db_ready="Press Enter after database is set up..."

echo.
echo Starting backend server...
echo.

cd backend
start "Spring Boot Server" cmd /k "mvn spring-boot:run"
cd ..

timeout /t 15 /nobreak >nul

echo.
echo Opening frontend...
echo.

start "" "frontend\index.html"

echo.
echo ========================================
echo   Setup Complete!
echo ========================================
echo.
echo ✓ Backend Server: http://localhost:8080
echo ✓ Frontend: Opened in browser
echo.
echo Test Credentials:
echo Admin: admin@hotel.com / password
echo User: john@example.com / password
echo.
echo If backend fails to start:
echo 1. Check MySQL is running
echo 2. Verify database credentials in application.properties
echo 3. Update password if different
echo.
echo Press any key to exit...
pause >nul
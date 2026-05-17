# LuxeStay Hotel Reservation System - Setup Script

@echo off
echo ========================================
echo   LuxeStay Hotel Setup Script
echo ========================================
echo.

cd /d "%~dp0"

echo Step 1: Checking prerequisites...
echo.

REM Check if Java is installed
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Java is not installed. Please install Java 17 or higher.
    echo Download from: https://adoptium.net/
    pause
    exit /b 1
)
echo ✓ Java is installed

REM Check if Maven is installed
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Maven is not installed. Please install Maven 3.6+.
    echo Download from: https://maven.apache.org/download.cgi
    pause
    exit /b 1
)
echo ✓ Maven is installed

REM Check if MySQL is running
net start | find "MySQL" >nul 2>&1
if %errorlevel% neq 0 (
    echo WARNING: MySQL service is not running.
    echo Please start MySQL service or ensure MySQL is running.
    echo.
)

echo.
echo Step 2: Setting up database...
echo.

REM Try to connect to MySQL and run schema
echo Please ensure MySQL is running and you have the correct credentials.
echo The application.properties file should be configured with your MySQL credentials.
echo.
echo If you haven't set up the database yet, run the following commands in MySQL:
echo.
echo mysql -u root -p
echo source database/schema.sql
echo.
pause

echo.
echo Step 3: Starting the backend server...
echo.

cd backend
start "Spring Boot Server" cmd /k "mvn spring-boot:run"
cd ..

timeout /t 10 /nobreak >nul

echo.
echo Step 4: Opening the frontend...
echo.

REM Try to open the frontend in default browser
start "" "frontend/index.html"

echo.
echo ========================================
echo   Setup Complete!
echo ========================================
echo.
echo Backend Server: http://localhost:8080
echo Frontend: Open frontend/index.html in your browser
echo.
echo Default login credentials:
echo Admin: admin@hotel.com / password
echo User: john@example.com / password
echo.
echo Press any key to exit...
pause >nul
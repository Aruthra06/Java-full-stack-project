@echo off
REM =====================================================
REM LuxeStay - One-Click Automatic Setup & Run
REM =====================================================

setlocal enabledelayedexpansion
cd /d "%~dp0"

color 0A
cls

echo.
echo =====================================================
echo    LuxeStay Hotel Reservation System
echo    Automatic Setup & Run
echo =====================================================
echo.

REM Check prerequisites
echo Checking prerequisites...
echo.

java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Java is not installed
    echo.
    echo Download Java 17 from: https://adoptium.net/temurin/releases/
    echo.
    pause
    exit /b 1
)
echo [OK] Java is installed

mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Maven is not installed
    echo.
    echo Download Maven from: https://maven.apache.org/download.cgi
    echo.
    pause
    exit /b 1
)
echo [OK] Maven is installed

echo.
echo =====================================================
echo    DATABASE SETUP REQUIRED
echo =====================================================
echo.
echo You need to set up the MySQL database manually:
echo.
echo 1. Open MySQL Workbench or MySQL Command Line Client
echo 2. Run this file: database\schema.sql
echo.
echo Option A: MySQL Workbench
echo   - File > Open SQL Script > database\schema.sql
echo   - Click Execute (or Ctrl+Enter)
echo.
echo Option B: Command Line
echo   - mysql -u root -p
echo   - source database\schema.sql
echo.
set /p db_ready="Have you set up the database? (yes/no): "
if /i not "%db_ready%"=="yes" (
    echo.
    echo Please set up the database first, then run this script again.
    pause
    exit /b 1
)

echo.
echo =====================================================
echo    STARTING BACKEND SERVER
echo =====================================================
echo.
echo Starting Spring Boot application...
echo This may take 30-60 seconds...
echo.

cd backend
start "LuxeStay Backend Server" cmd /k "mvn spring-boot:run"
cd ..

timeout /t 10 /nobreak >nul

echo.
echo =====================================================
echo    OPENING FRONTEND
echo =====================================================
echo.

start "" "frontend\index.html"

echo.
echo =====================================================
echo    SETUP COMPLETE!
echo =====================================================
echo.
echo [SUCCESS] Your system is starting...
echo.
echo Frontend: Check your browser
echo Backend: http://localhost:8080
echo.
echo Test Credentials:
echo   Admin: admin@hotel.com / password
echo   User: john@example.com / password
echo.
echo Next Steps:
echo   1. Wait 30-60 seconds for backend to fully start
echo   2. Refresh your browser
echo   3. Click "Register" or use test credentials to login
echo   4. Book a hotel and enjoy!
echo.
echo =====================================================
echo.
pause
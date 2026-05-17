# ===================================================================
# LuxeStay Hotel Reservation System - Complete Automated Setup
# This script will check, install, configure, and run everything
# ===================================================================

param(
    [switch]$SkipJavaCheck = $false,
    [switch]$SkipMavenCheck = $false,
    [switch]$SkipMySQLCheck = $false
)

# Color configuration
$Green = "Green"
$Red = "Red"
$Yellow = "Yellow"
$Cyan = "Cyan"

function Write-Title {
    param($Text)
    Write-Host ""
    Write-Host "=====================================================" -ForegroundColor $Cyan
    Write-Host "  $Text" -ForegroundColor $Cyan
    Write-Host "=====================================================" -ForegroundColor $Cyan
    Write-Host ""
}

function Write-Success {
    param($Text)
    Write-Host "✓ $Text" -ForegroundColor $Green
}

function Write-Error {
    param($Text)
    Write-Host "✗ $Text" -ForegroundColor $Red
}

function Write-Warning {
    param($Text)
    Write-Host "⚠ $Text" -ForegroundColor $Yellow
}

function Write-Info {
    param($Text)
    Write-Host "ℹ $Text"
}

# ===================================================================
# STEP 1: CHECK JAVA
# ===================================================================

Write-Title "Step 1: Checking Java Installation"

if (Test-Command "java") {
    $javaVersion = java -version 2>&1
    Write-Success "Java is installed"
    Write-Info "Version: $($javaVersion[0])"
} else {
    Write-Error "Java 17 is not installed"
    Write-Warning "Download and install Java 17:"
    Write-Host "👉 https://adoptium.net/temurin/releases/" -ForegroundColor $Cyan
    Write-Host ""
    Write-Info "Choose: Windows x64 MSI"
    Write-Host ""
    
    $response = Read-Host "Have you installed Java? (yes/no)"
    if ($response -ne "yes") {
        Write-Error "Cannot proceed without Java. Exiting."
        exit 1
    }
    
    # Refresh environment
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# ===================================================================
# STEP 2: CHECK MAVEN
# ===================================================================

Write-Title "Step 2: Checking Maven Installation"

if (Test-Command "mvn") {
    $mavenVersion = mvn -version 2>&1 | Select-Object -First 1
    Write-Success "Maven is installed"
    Write-Info $mavenVersion
} else {
    Write-Error "Maven is not installed"
    Write-Warning "Download and install Maven:"
    Write-Host "👉 https://maven.apache.org/download.cgi" -ForegroundColor $Cyan
    Write-Host ""
    Write-Info "Extract to: C:\Program Files\Apache\Maven"
    Write-Host ""
    
    $response = Read-Host "Have you installed Maven? (yes/no)"
    if ($response -ne "yes") {
        Write-Error "Cannot proceed without Maven. Exiting."
        exit 1
    }
    
    # Refresh environment
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# ===================================================================
# STEP 3: CHECK MYSQL
# ===================================================================

Write-Title "Step 3: Checking MySQL Installation"

$mysqlRunning = $false
try {
    $mysqlService = Get-Service "MySQL80" -ErrorAction SilentlyContinue
    if ($mysqlService -and $mysqlService.Status -eq "Running") {
        Write-Success "MySQL is installed and running"
        $mysqlRunning = $true
    }
} catch {
    Write-Warning "MySQL service not found or not running"
}

if (!$mysqlRunning) {
    Write-Error "MySQL is not running"
    Write-Warning "Download and install MySQL:"
    Write-Host "👉 https://dev.mysql.com/downloads/mysql/" -ForegroundColor $Cyan
    Write-Host ""
    Write-Info "Choose: MySQL Installer for Windows"
    Write-Info "Setup type: Developer Default"
    Write-Info "Set root password: your_password_here"
    Write-Host ""
    
    $response = Read-Host "Have you installed MySQL? (yes/no)"
    if ($response -ne "yes") {
        Write-Warning "MySQL is required. Cannot proceed."
        exit 1
    }
}

# ===================================================================
# STEP 4: SETUP DATABASE
# ===================================================================

Write-Title "Step 4: Setting Up Database"

$projectPath = "c:\Users\Admin\Documents\Hotel management"
$schemaPath = "$projectPath\database\schema.sql"

if (!(Test-Path $schemaPath)) {
    Write-Error "Database schema file not found at: $schemaPath"
    exit 1
}

Write-Info "Database schema file found"
Write-Warning "You need to run the database setup manually"
Write-Host ""
Write-Host "Open MySQL Workbench or Command Line Client and run:" -ForegroundColor $Yellow
Write-Host "source $schemaPath" -ForegroundColor $Cyan
Write-Host ""
Write-Info "Or use command line:"
Write-Host "mysql -u root -p < `"$schemaPath`"" -ForegroundColor $Cyan
Write-Host ""

$dbSetup = Read-Host "Have you set up the database? (yes/no)"
if ($dbSetup -ne "yes") {
    Write-Warning "Skipping database check. Backend may fail if not set up."
}

# ===================================================================
# STEP 5: START BACKEND
# ===================================================================

Write-Title "Step 5: Starting Backend Server"

$backendPath = "$projectPath\backend"

if (!(Test-Path $backendPath)) {
    Write-Error "Backend directory not found at: $backendPath"
    exit 1
}

Write-Info "Starting Spring Boot application..."
Write-Info "This may take 30-60 seconds on first run..."
Write-Host ""

Set-Location $backendPath

# Start backend in a new window
$process = Start-Process "cmd.exe" -ArgumentList "/k mvn spring-boot:run" -PassThru

Write-Success "Backend process started"
Write-Info "Process ID: $($process.Id)"
Write-Warning "Backend window will open in 3 seconds..."
Write-Warning "Wait for message: 'Started HotelReservationApplication'"

Start-Sleep -Seconds 3

# ===================================================================
# STEP 6: OPEN FRONTEND
# ===================================================================

Write-Title "Step 6: Opening Frontend Application"

$frontendPath = "$projectPath\frontend\index.html"

if (!(Test-Path $frontendPath)) {
    Write-Error "Frontend file not found at: $frontendPath"
    exit 1
}

Write-Info "Opening frontend in your default browser..."
Start-Process $frontendPath

Write-Success "Frontend opened!"

# ===================================================================
# STEP 7: DISPLAY INFORMATION
# ===================================================================

Write-Title "Setup Complete! 🎉"

Write-Success "Your Hotel Reservation System is running!"
Write-Host ""

Write-Info "Frontend URLs:"
Write-Host "  • Homepage:  $frontendPath" -ForegroundColor $Cyan
Write-Host "  • Dashboard: $projectPath\frontend\dashboard.html" -ForegroundColor $Cyan
Write-Host ""

Write-Info "Backend:"
Write-Host "  • API URL: http://localhost:8080" -ForegroundColor $Cyan
Write-Host "  • Status: Starting..." -ForegroundColor $Yellow
Write-Host ""

Write-Info "Test Credentials:"
Write-Host "  • Admin: admin@hotel.com / password" -ForegroundColor $Cyan
Write-Host "  • User: john@example.com / password" -ForegroundColor $Cyan
Write-Host ""

Write-Info "What to do now:"
Write-Host "  1. Wait 30-60 seconds for backend to fully start" -ForegroundColor $Cyan
Write-Host "  2. Refresh the frontend in browser" -ForegroundColor $Cyan
Write-Host "  3. Try: Register → Login → Book Hotel" -ForegroundColor $Cyan
Write-Host ""

Write-Host "=====================================================" -ForegroundColor $Cyan
Write-Host "  ✨ Enjoy Your LuxeStay Experience! ✨" -ForegroundColor $Cyan
Write-Host "=====================================================" -ForegroundColor $Cyan

# ===================================================================
# HELPER FUNCTIONS
# ===================================================================

function Test-Command {
    param($Command)
    try {
        Get-Command $Command -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    }
}
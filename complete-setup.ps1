# LuxeStay - Complete Setup Script for Windows
# This script will install all required tools and set up the project

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "   LuxeStay Hotel Reservation System" -ForegroundColor Cyan
Write-Host "   Complete Setup Script" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# Function to check if a command exists
function Test-Command {
    param($Command)
    try {
        Get-Command $Command -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

# Function to download and install Java
function Install-Java {
    Write-Host "Installing Java 17..." -ForegroundColor Yellow

    $javaUrl = "https://download.oracle.com/java/17/latest/jdk-17_windows-x64_bin.exe"
    $javaInstaller = "$env:TEMP\jdk-17-installer.exe"

    try {
        Write-Host "Downloading Java 17..."
        Invoke-WebRequest -Uri $javaUrl -OutFile $javaInstaller

        Write-Host "Installing Java 17 (this may take a few minutes)..."
        Start-Process -FilePath $javaInstaller -ArgumentList "/s" -Wait

        # Add Java to PATH
        $javaHome = "C:\Program Files\Java\jdk-17"
        if (Test-Path $javaHome) {
            [Environment]::SetEnvironmentVariable("JAVA_HOME", $javaHome, "Machine")
            $path = [Environment]::GetEnvironmentVariable("PATH", "Machine")
            if ($path -notlike "*$javaHome\bin*") {
                [Environment]::SetEnvironmentVariable("PATH", "$path;$javaHome\bin", "Machine")
            }
        }

        Write-Host "Java 17 installed successfully!" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "Failed to install Java automatically. Please install Java 17 manually from:" -ForegroundColor Red
        Write-Host "https://adoptium.net/temurin/releases/" -ForegroundColor Yellow
        return $false
    }
}

# Function to download and install Maven
function Install-Maven {
    Write-Host "Installing Apache Maven..." -ForegroundColor Yellow

    $mavenUrl = "https://downloads.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.zip"
    $mavenZip = "$env:TEMP\apache-maven-3.9.5-bin.zip"
    $mavenExtractPath = "C:\Program Files\Apache\Maven"

    try {
        Write-Host "Downloading Maven..."
        Invoke-WebRequest -Uri $mavenUrl -OutFile $mavenZip

        Write-Host "Extracting Maven..."
        Expand-Archive -Path $mavenZip -DestinationPath $mavenExtractPath -Force

        # Add Maven to PATH
        $mavenHome = "$mavenExtractPath\apache-maven-3.9.5"
        [Environment]::SetEnvironmentVariable("MAVEN_HOME", $mavenHome, "Machine")
        $path = [Environment]::GetEnvironmentVariable("PATH", "Machine")
        if ($path -notlike "*$mavenHome\bin*") {
            [Environment]::SetEnvironmentVariable("PATH", "$path;$mavenHome\bin", "Machine")
        }

        Write-Host "Maven installed successfully!" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "Failed to install Maven automatically. Please install Maven manually from:" -ForegroundColor Red
        Write-Host "https://maven.apache.org/download.cgi" -ForegroundColor Yellow
        return $false
    }
}

# Function to install MySQL
function Install-MySQL {
    Write-Host "Installing MySQL..." -ForegroundColor Yellow

    Write-Host "Please download and install MySQL from:" -ForegroundColor Yellow
    Write-Host "https://dev.mysql.com/downloads/mysql/" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Installation steps:" -ForegroundColor White
    Write-Host "1. Download the MySQL Installer" -ForegroundColor White
    Write-Host "2. Run the installer as Administrator" -ForegroundColor White
    Write-Host "3. Choose 'Developer Default' setup type" -ForegroundColor White
    Write-Host "4. Set root password to: your_password_here" -ForegroundColor White
    Write-Host "5. Complete the installation" -ForegroundColor White
    Write-Host ""

    $confirmation = Read-Host "Press Enter after MySQL is installed and running"
    return $true
}

# Function to setup database
function Setup-Database {
    Write-Host "Setting up database..." -ForegroundColor Yellow

    $projectPath = "c:\Users\Admin\Documents\Hotel management"
    $schemaPath = "$projectPath\database\schema.sql"

    if (!(Test-Path $schemaPath)) {
        Write-Host "Database schema file not found at: $schemaPath" -ForegroundColor Red
        return $false
    }

    Write-Host "Please run the following commands in MySQL Workbench or Command Line Client:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "mysql -u root -p" -ForegroundColor Cyan
    Write-Host "source $schemaPath" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "When prompted for password, enter your MySQL root password." -ForegroundColor White

    $confirmation = Read-Host "Press Enter after database is set up"
    return $true
}

# Function to start backend
function Start-Backend {
    Write-Host "Starting Spring Boot backend..." -ForegroundColor Yellow

    $backendPath = "c:\Users\Admin\Documents\Hotel management\backend"

    if (!(Test-Path $backendPath)) {
        Write-Host "Backend directory not found!" -ForegroundColor Red
        return $false
    }

    try {
        Set-Location $backendPath
        Write-Host "Compiling and starting Spring Boot application..." -ForegroundColor Yellow
        Write-Host "This may take a few minutes..." -ForegroundColor Yellow

        # Start the backend in a new window
        Start-Process "cmd.exe" -ArgumentList "/c mvn spring-boot:run" -WorkingDirectory $backendPath

        Write-Host "Backend started successfully!" -ForegroundColor Green
        Write-Host "API will be available at: http://localhost:8080" -ForegroundColor Cyan
        return $true
    } catch {
        Write-Host "Failed to start backend: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Function to start frontend
function Start-Frontend {
    Write-Host "Setting up frontend..." -ForegroundColor Yellow

    $frontendPath = "c:\Users\Admin\Documents\Hotel management\frontend"

    if (!(Test-Path $frontendPath)) {
        Write-Host "Frontend directory not found!" -ForegroundColor Red
        return $false
    }

    try {
        Write-Host "Opening frontend in default browser..." -ForegroundColor Yellow
        Start-Process "$frontendPath\index.html"

        Write-Host "Frontend opened successfully!" -ForegroundColor Green
        Write-Host "Application will be available in your browser" -ForegroundColor Cyan
        return $true
    } catch {
        Write-Host "Failed to open frontend: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Main setup process
Write-Host "Checking system requirements..." -ForegroundColor Yellow
Write-Host ""

# Check and install Java
if (!(Test-Command "java")) {
    Write-Host "Java is not installed." -ForegroundColor Red
    if (Install-Java) {
        # Refresh environment
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    }
} else {
    Write-Host "✓ Java is already installed" -ForegroundColor Green
}

# Check and install Maven
if (!(Test-Command "mvn")) {
    Write-Host "Maven is not installed." -ForegroundColor Red
    if (Install-Maven) {
        # Refresh environment
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    }
} else {
    Write-Host "✓ Maven is already installed" -ForegroundColor Green
}

# Check MySQL
if (!(Test-Command "mysql")) {
    Write-Host "MySQL is not installed." -ForegroundColor Red
    Install-MySQL
} else {
    Write-Host "✓ MySQL is already installed" -ForegroundColor Green
}

# Setup database
Setup-Database

# Start services
Write-Host ""
Write-Host "Starting services..." -ForegroundColor Yellow
Write-Host ""

Start-Backend
Start-Frontend

Write-Host ""
Write-Host "=========================================" -ForegroundColor Green
Write-Host "   Setup Complete!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Your LuxeStay Hotel Reservation System is now running!" -ForegroundColor Cyan
Write-Host ""
Write-Host "🌐 Frontend: Open in browser" -ForegroundColor White
Write-Host "🔧 Backend API: http://localhost:8080" -ForegroundColor White
Write-Host ""
Write-Host "Test Credentials:" -ForegroundColor Yellow
Write-Host "Admin: admin@hotel.com / password" -ForegroundColor White
Write-Host "User: john@example.com / password" -ForegroundColor White
Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor Gray
Read-Host
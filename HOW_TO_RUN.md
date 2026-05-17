# 🚀 LuxeStay - Multiple Ways to Run

## ⚡ **FASTEST: One-Click Run**

### **Windows - Double-Click to Run**
```
RUN.bat
```
This will:
✅ Check Java and Maven
✅ Remind you to set up database
✅ Start backend automatically
✅ Open frontend in browser

---

## 🎯 **Quick Setup Options**

### **Option 1: Simple Batch Script (Windows)**
```cmd
simple-setup.bat
```

### **Option 2: PowerShell Script**
```powershell
# Open PowerShell as Administrator
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\auto-setup.ps1
```

### **Option 3: Manual Terminal Commands**
```bash
# Terminal 1: Backend
cd backend
mvn spring-boot:run

# Terminal 2: Frontend
# Open in browser: frontend/index.html
```

---

## 📋 **Prerequisites Setup**

### **Step 1: Install Java 17**
Download: https://adoptium.net/temurin/releases/
- Choose Windows x64 MSI
- Install with default settings
- Restart terminal

### **Step 2: Install Maven**
Download: https://maven.apache.org/download.cgi
- Extract to: C:\Program Files\Apache\Maven
- Add to PATH

### **Step 3: Install MySQL**
Download: https://dev.mysql.com/downloads/mysql/
- Choose MySQL Installer
- Select Developer Default
- Set root password

### **Step 4: Setup Database**
```sql
# Open MySQL and run:
source database/schema.sql
```

---

## ✨ **All Ways to Launch**

### **1️⃣ Batch File (Easiest)**
```
Location: RUN.bat
Action: Double-click
Result: Everything starts automatically
```

### **2️⃣ PowerShell Script**
```powershell
.\auto-setup.ps1
```

### **3️⃣ Simple Batch**
```
Location: simple-setup.bat
Action: Double-click
```

### **4️⃣ Terminal - Backend**
```bash
cd backend
mvn spring-boot:run
```

### **5️⃣ VS Code**
```
Press F5 to run with launch.json configuration
Or click Run in sidebar
```

### **6️⃣ Manual Frontend**
```
Location: frontend/index.html
Action: Double-click or drag to browser
```

### **7️⃣ Backend + Frontend (Separate Terminals)**
```bash
# Terminal 1
cd backend && mvn spring-boot:run

# Terminal 2
# Open frontend/index.html
```

---

## 🔍 **What Runs Where**

| Component | Location | URL | Port |
|-----------|----------|-----|------|
| Frontend | `frontend/index.html` | Direct file or browser | N/A |
| Dashboard | `frontend/dashboard.html` | Direct file | N/A |
| Backend API | Spring Boot | http://localhost:8080 | 8080 |
| Database | MySQL | localhost | 3306 |

---

## 🎮 **Test Credentials**

```
Admin User:
  Email: admin@hotel.com
  Password: password

Regular User:
  Email: john@example.com
  Password: password
```

---

## 📊 **Full Application Flow**

```
1. Frontend opens (index.html)
   ↓
2. User registers or logs in
   ↓
3. Backend API processes auth (http://localhost:8080)
   ↓
4. Database stores/retrieves data (MySQL)
   ↓
5. Frontend shows hotels and booking system
   ↓
6. User makes booking
   ↓
7. Backend saves to database
   ↓
8. User views dashboard (dashboard.html)
```

---

## 🆘 **Troubleshooting**

### **Backend Won't Start**
```
✓ Check Java: java -version
✓ Check Maven: mvn -version
✓ Check MySQL: MySQL service running?
✓ Update password in: backend/src/main/resources/application.properties
```

### **Frontend Shows Errors**
```
✓ Ensure backend is running on port 8080
✓ Wait 30-60 seconds for Spring Boot to start
✓ Check browser console for errors (F12)
✓ Clear browser cache (Ctrl+Shift+Delete)
```

### **Database Connection Error**
```
✓ Verify MySQL is running
✓ Check credentials in application.properties
✓ Run schema.sql file
✓ Check database exists: hotel_reservation
```

### **Port Already in Use**
```
# Change port in: backend/src/main/resources/application.properties
server.port=8081
```

---

## 📁 **File Structure**

```
Hotel management/
├── RUN.bat                    ← Double-click this to start!
├── simple-setup.bat          
├── auto-setup.ps1            
├── complete-setup.ps1        
├── frontend/
│   ├── index.html           ← Homepage
│   ├── dashboard.html       ← User dashboard
│   ├── css/style.css        
│   └── js/script.js         
├── backend/
│   ├── pom.xml
│   ├── src/main/...
│   └── src/main/resources/
│       └── application.properties
├── database/
│   └── schema.sql           ← Run this in MySQL
├── .vscode/
│   ├── launch.json         ← VS Code run config
│   └── tasks.json          ← VS Code tasks
└── README.md
```

---

## 🚀 **Start Right Now**

### **Fastest Way (60 seconds)**
1. Make sure Java, Maven, MySQL installed
2. Run: `database/schema.sql` in MySQL
3. Double-click: `RUN.bat`
4. Wait 30-60 seconds for backend to start
5. Enjoy your hotel reservation system!

---

## ✅ **Checklist**

- [ ] Java 17 installed
- [ ] Maven installed
- [ ] MySQL installed and running
- [ ] Database schema executed
- [ ] RUN.bat double-clicked
- [ ] Backend started (check terminal window)
- [ ] Frontend opened in browser
- [ ] Test login works
- [ ] Can book a hotel

---

## 🎊 **You're All Set!**

Pick your favorite way to launch and start exploring the LuxeStay Hotel Reservation System!

**Most Recommended:** `RUN.bat` ⭐⭐⭐⭐⭐
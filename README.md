# Flutter Items App & .NET Core API (Multi-Platform) 🚀

โปรเจกต์นี้เป็นแอปพลิเคชัน Flutter ที่เชื่อมต่อกับ .NET Core API พร้อมระบบการเข้าสู่ระบบแบบจำลอง รองรับการทำงานบนหลายแพลตฟอร์ม

## 🎉 **STATUS: COMPLETE & READY!**

**✅ ระบบเข้าสู่ระบบพร้อมใช้งาน** | **✅ API ทำงานปกติ** | **✅ Flutter App พร้อมแล้ว**

## 🏗️ โครงสร้างโปรเจกต์

```
agent_exam/
├── flutter_items_app/    # Flutter Application (Multi-Platform)
├── ItemsApi/            # .NET Core Web API
├── .vscode/             # VS Code Configuration
│   ├── launch.json      # Debug configurations
│   ├── tasks.json       # Build & run tasks
│   └── settings.json    # Workspace settings
├── start-api.sh         # Quick API startup script
├── start-flutter.sh     # Quick Flutter startup script  
├── start-flutter-web.sh # Quick Flutter web startup script
├── LOGIN_README.md      # Login system documentation
├── SYSTEM_COMPLETE.md   # Complete system status
└── INTEGRATION_TEST.md  # Integration test results
```

## 🚀 Quick Start (Ready to Use!)

### Option 1: VS Code Debug (Recommended)
```bash
# 1. Open in VS Code
code .

# 2. Go to Debug panel (⌘+Shift+D)
# 3. Select "🔄 Full Stack (API + Flutter macOS)" 
# 4. Press F5 to start both API and Flutter
```

### Option 2: Manual Scripts
```bash
# Start API server
./start-api.sh

# Start Flutter (Desktop)
./start-flutter.sh

# Or start Flutter (Web)
./start-flutter-web.sh
```

### 🔑 Demo Login Accounts
- **Admin**: `admin` / `admin123` (ผู้ดูแลระบบ)
- **User**: `user` / `user123` (ผู้ใช้ทั่วไป)
- **Demo**: `demo` / `demo` (ผู้ใช้ทดสอบ)

### 🌐 URLs
- **API Server**: http://localhost:5160
- **Flutter Web**: http://localhost:3000 (when using web version)

---

## 📱 Flutter App Features

- ✅ **Multi-Platform Support**: Windows Desktop, Web, macOS, iOS, และ Android
- ✅ **Responsive Design**: แสดงผลที่แตกต่างกันสำหรับ Desktop และ Mobile
- ✅ **Material Design 3**: UI สวยงามและทันสมัย
- ✅ **Desktop Layout**: Sidebar navigation สำหรับ Windows Desktop
- ✅ **Grid View**: แสดงรายการแบบ Grid บน Desktop
- ✅ **API Integration**: เรียก API และแสดงผลข้อมูล
- ✅ **Error Handling**: Loading states และ Error handling
- ✅ **Thai Language**: รองรับภาษาไทยเต็มรูปแบบ

## 🔧 .NET Core API Features

- ✅ RESTful API endpoint `/api/items`
- ✅ ส่งข้อมูล JSON list of strings
- ✅ เปิดใช้งาน CORS สำหรับ Flutter
- ✅ รองรับข้อมูลภาษาไทย

## 🎯 Supported Platforms

| Platform | Status | Notes |
|----------|--------|-------|
| 🪟 Windows Desktop | ✅ | Native Windows app with desktop-optimized UI |
| 🌐 Web (Chrome/Edge) | ✅ | PWA-ready with responsive design |
| 🍎 macOS | ✅ | Native macOS app |
| 📱 iOS | ✅ | Native iOS app |
| 🤖 Android | ✅ | Native Android app |

## 🚀 วิธีการรันโปรเจกต์

### 🎮 Quick Start (แนะนำ)

**ใช้ VS Code Tasks และ Debug Configurations:**

1. เปิด VS Code ใน folder `agent_exam`
2. กด `F5` เพื่อเข้า Debug mode
3. เลือก configuration:
   - `Launch Flutter (Web) + API` - รัน Web app + API
   - `Launch Flutter (Windows) + API` - รัน Windows app + API
   - `Flutter: Debug (Web)` - รัน Web app เท่านั้น
   - `Flutter: Debug (Windows)` - รัน Windows app เท่านั้น
   - `ItemsApi: Debug` - รัน API เท่านั้น

### 🔧 Manual Setup

#### Backend (.NET Core API)

```bash
cd ItemsApi
dotnet run
```
API จะรันที่: `http://localhost:5160`

#### Frontend (Flutter App)

```bash
cd flutter_items_app
flutter pub get

# Windows Desktop
flutter run -d windows

# Web Browser
flutter run -d chrome

# Mobile/Other platforms
flutter run -d ios      # iOS
flutter run -d android  # Android
flutter run -d macos    # macOS
```

### 🔨 Build สำหรับ Production

```bash
# Build Windows Desktop
flutter build windows

# Build Web
flutter build web

# Build iOS
flutter build ios

# Build Android
flutter build apk
```

## 🐛 Troubleshooting

### Java Version Issues (Android)

หากพบ error "Android Gradle plugin requires Java 17 to run. You are currently using Java 11":

**วิธีแก้ไข:**

1. **รันสคริปต์อัตโนมัติ:**
   ```powershell
   .\fix-java-version.ps1
   .\fix-vscode-java.ps1
   ```

2. **แก้ไขด้วยตนเอง:**
   ```powershell
   # ตั้งค่า JAVA_HOME
   $env:JAVA_HOME="C:\Program Files\Android\Android Studio\jbr"
   
   # ตั้งค่าถาวร
   [Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Android\Android Studio\jbr", "User")
   ```

3. **รีสตาร์ท VS Code** และเปิด workspace ใหม่

4. **หากยังมีปัญหา** ให้รันคำสั่งใน VS Code terminal:
   ```powershell
   $env:JAVA_HOME="C:\Program Files\Android\Android Studio\jbr"
   ```

### การตรวจสอบ Java Version

```bash
# ตรวจสอบ Java version ปัจจุบัน
java -version

# ตรวจสอบ Android Studio's Java
"C:\Program Files\Android\Android Studio\jbr\bin\java.exe" -version
```
   
   # รันบน Android Emulator
   flutter run -d android
   \`\`\`

## 📋 API Endpoints

### GET /api/items
ดึงรายการข้อมูลทั้งหมด

**Response:**
\`\`\`json
[
  "รายการที่ 1",
  "รายการที่ 2", 
  "รายการที่ 3",
  "สินค้า A",
  "สินค้า B",
  "บริการพิเศษ"
]
\`\`\`

## 🛠️ เทคโนโลยีที่ใช้

### Frontend
- **Flutter** - Cross-platform mobile & desktop framework
- **Dart** - Programming language
- **HTTP Package** - สำหรับเรียก API

### Backend
- **.NET Core 9** - Web API framework
- **C#** - Programming language
- **ASP.NET Core** - Web framework

## 📱 Platform Support

- ✅ **macOS** (รันและทดสอบแล้ว)
- ✅ **iOS** (รองรับผ่าน Flutter)
- ✅ **Android** (รองรับผ่าน Flutter)

## 🔑 Key Features

1. **Cross-Platform**: รันได้ทั้ง macOS, iOS, และ Android
2. **Real-time API**: เชื่อมต่อ Flutter กับ .NET Core ผ่าน HTTP
3. **Thai Language Support**: รองรับการแสดงผลภาษาไทย
4. **Modern UI**: ใช้ Material Design 3
5. **Error Handling**: จัดการข้อผิดพลาดอย่างเหมาะสม

## 🎯 การใช้งาน

1. รัน Backend API ก่อน
2. รัน Flutter App
3. กดปุ่ม "ดึงข้อมูล" ในแอป
4. รายการจะแสดงขึ้นมาจาก API

## 📝 Notes

- Backend API ต้องรันอยู่ก่อนที่จะใช้งาน Flutter app
- Flutter app เชื่อมต่อกับ API ที่ `http://127.0.0.1:5160`
- สำหรับ macOS ได้เพิ่ม network permission ใน entitlements แล้ว

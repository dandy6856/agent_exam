# 🚀 Items App - Full Stack Flutter + .NET

ระบบจัดการรายการสินค้าและบริการ พร้อมระบบ Login จำลอง

## 📋 ส่วนประกอบ

### 🌐 Backend (ItemsApi - .NET 8)
- **Framework**: ASP.NET Core Web API
- **Port**: http://localhost:5160
- **Features**:
  - ระบบ Login จำลอง
  - API สำหรับรายการสินค้า
  - CORS สำหรับ Flutter

### 📱 Frontend (flutter_items_app - Flutter)
- **Framework**: Flutter (Material Design 3)
- **Platforms**: macOS, iOS, Android, Web
- **Features**:
  - ระบบ Login แบบ responsive
  - แสดงรายการสินค้าจาก API
  - รองรับ Desktop และ Mobile UI

## 🔐 ข้อมูลทดสอบ

| Username | Password | Role |
|----------|----------|------|
| `admin` | `admin123` | ผู้ดูแลระบบ |
| `user` | `user123` | ผู้ใช้ทั่วไป |
| `demo` | `demo` | ผู้ใช้ทดสอบ |

## 🚀 วิธีการรัน

### Option 1: ใช้ Scripts (แนะนำ)

#### 1. รัน API Server
```bash
./start-api.sh
```

#### 2. รัน Flutter App (Terminal ใหม่)
```bash
./start-flutter.sh
```

### Option 2: รัน Manual

#### 1. รัน API Server
```bash
cd ItemsApi
dotnet build
dotnet run --urls="http://localhost:5160"
```

#### 2. รัน Flutter App
```bash
cd flutter_items_app
flutter clean
flutter pub get
flutter run -d macos  # หรือ -d chrome สำหรับ web
```

### Option 3: ใช้ VS Code Debug

1. เปิด VS Code
2. ไปที่ Debug panel (Cmd+Shift+D)
3. เลือก "🔄 Full Stack (API + Flutter macOS)"
4. กด Start Debugging (F5)

## 🌐 API Endpoints

### Authentication
- **POST** `/api/auth/login` - เข้าสู่ระบบ
- **POST** `/api/auth/logout` - ออกจากระบบ
- **GET** `/api/auth/status` - สถานะเซิร์ฟเวอร์
- **GET** `/api/auth/demo-users` - ข้อมูลผู้ใช้ทดสอบ

### Items
- **GET** `/api/items` - รายการสินค้าทั้งหมด

## 📱 การทดสอบ

### 1. ทดสอบ API
```bash
# ตรวจสอบสถานะเซิร์ฟเวอร์
curl http://localhost:5160/api/auth/status

# ทดสอบ Login
curl -X POST http://localhost:5160/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"demo","password":"demo"}'

# ดูรายการสินค้า
curl http://localhost:5160/api/items
```

### 2. ทดสอบ Flutter App
1. เปิดแอป
2. กดปุ่ม "เข้าสู่ระบบ"
3. ใช้ข้อมูลทดสอบหรือกดที่ชื่อผู้ใช้ในกล่องข้อมูลทดสอบ
4. หลังเข้าสู่ระบบแล้ว กด "ดึงข้อมูล" เพื่อทดสอบการเชื่อมต่อ API

## 🛠 Platform-specific Configuration

### Android Emulator
- แอปจะใช้ `10.0.2.2:5160` แทน `localhost:5160` อัตโนมัติ

### iOS Simulator / macOS / Web
- แอปจะใช้ `127.0.0.1:5160`

## 📁 โครงสร้างโปรเจกต์

```
agent_exam/
├── ItemsApi/                 # .NET Web API
│   ├── Controllers/
│   │   ├── AuthController.cs # ระบบ Login
│   │   └── ItemsController.cs # API สินค้า
│   ├── Models/
│   │   └── AuthModels.cs     # Models สำหรับ Auth
│   └── Program.cs            # Entry point
├── flutter_items_app/        # Flutter App
│   ├── lib/
│   │   ├── main.dart         # หน้าหลัก
│   │   ├── models/
│   │   │   └── user.dart     # User model
│   │   ├── pages/
│   │   │   └── login_page.dart # หน้า Login
│   │   └── services/
│   │       └── auth_service.dart # Auth service
│   └── pubspec.yaml
├── .vscode/
│   ├── launch.json           # Debug configurations
│   └── tasks.json            # VS Code tasks
├── start-api.sh              # Script รัน API
├── start-flutter.sh          # Script รัน Flutter
└── README.md                 # ไฟล์นี้
```

## 🔧 Requirements

- **.NET 8 SDK**
- **Flutter SDK**
- **VS Code** (optional, for debugging)
- **Xcode** (สำหรับ macOS/iOS)
- **Android Studio** (สำหรับ Android)

## 💡 Tips

1. **รัน API ก่อนเสมอ** - Flutter app ต้องการ API server
2. **ใช้ข้อมูลทดสอบ** - กดที่ข้อมูลทดสอบในหน้า Login เพื่อใส่ข้อมูลอัตโนมัติ
3. **Desktop vs Mobile** - UI จะเปลี่ยนแปลงตามขนาดหน้าจอ
4. **Hot Reload** - Flutter รองรับ hot reload ในขณะพัฒนา

## 🐛 Troubleshooting

### API ไม่ทำงาน
```bash
# ตรวจสอบ port
lsof -i :5160

# ตรวจสอบ .NET version
dotnet --version
```

### Flutter ไม่ทำงาน
```bash
# ตรวจสอบ Flutter
flutter doctor

# Clean project
flutter clean && flutter pub get
```

### ไม่สามารถเชื่อมต่อ API
- ตรวจสอบว่า API server รันอยู่ที่ port 5160
- ใน Android Emulator ตรวจสอบว่าใช้ `10.0.2.2` แทน `localhost`
- ตรวจสอบ firewall/antivirus settings

---

🎉 **สนุกกับการพัฒนา Full Stack Flutter + .NET!**

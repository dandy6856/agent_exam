# Flutter Items App & .NET Core API

โปรเจกต์นี้เป็นแอปพลิเคชัน Flutter ที่เชื่อมต่อกับ .NET Core API เพื่อแสดงรายการข้อมูล

## 🏗️ โครงสร้างโปรเจกต์

```
agent_exam/
├── flutter_items_app/    # Flutter Application
└── ItemsApi/            # .NET Core Web API
```

## 📱 Flutter App Features

- ✅ รองรับ macOS, iOS, และ Android
- ✅ UI สวยงามด้วย Material Design 3
- ✅ เรียก API และแสดงผลข้อมูล
- ✅ Loading states และ Error handling
- ✅ รองรับภาษาไทย

## 🔧 .NET Core API Features

- ✅ RESTful API endpoint `/api/items`
- ✅ ส่งข้อมูล JSON list of strings
- ✅ เปิดใช้งาน CORS สำหรับ Flutter
- ✅ รองรับข้อมูลภาษาไทย

## 🚀 การรันโปรเจกต์

### Backend (.NET Core API)

1. เข้าไปใน folder ItemsApi:
   \`\`\`bash
   cd ItemsApi
   \`\`\`

2. รัน API server:
   \`\`\`bash
   dotnet run
   \`\`\`

   API จะรันที่: `http://localhost:5160`

### Frontend (Flutter App)

1. เข้าไปใน folder flutter_items_app:
   \`\`\`bash
   cd flutter_items_app
   \`\`\`

2. ติดตั้ง dependencies:
   \`\`\`bash
   flutter pub get
   \`\`\`

3. รันแอปบน platform ที่ต้องการ:
   \`\`\`bash
   # รันบน macOS
   flutter run -d macos
   
   # รันบน iOS Simulator
   flutter run -d ios
   
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

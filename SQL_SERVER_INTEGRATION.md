# SQL Server Integration Guide

## การเชื่อมต่อ SQL Server สำเร็จแล้ว! ✅

### ข้อมูลการเชื่อมต่อ
- **Server IP**: 192.168.18.55  
- **Database**: ItemsDb
- **Username**: bubble
- **Password**: dT$sql6856
- **API Port**: http://localhost:5161

### คุณสมบัติที่ทำงานได้แล้ว

#### 1. ✅ Entity Framework Core Integration
- ใช้ SQL Server Provider
- Auto-migration สำเร็จ
- Seed data พร้อมใช้งาน

#### 2. ✅ API Endpoints ทำงานเต็มรูปแบบ

**GET /api/items** - ดึงรายการสินค้าทั้งหมด
```bash
curl http://localhost:5161/api/items
```

**GET /api/items/{id}** - ดึงสินค้าตาม ID
```bash
curl http://localhost:5161/api/items/1
```

**POST /api/items** - เพิ่มสินค้าใหม่
```powershell
$body = @{
    name = "สินค้าใหม่"
    description = "คำอธิบาย"
    price = 299.00
    quantity = 25
    category = "หมวดหมู่"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:5161/api/items" -Method POST -Body $body -ContentType "application/json"
```

**PUT /api/items/{id}** - แก้ไขสินค้า
**DELETE /api/items/{id}** - ลบสินค้า (soft delete)

#### 3. ✅ Database Features
- **Soft Delete**: ข้อมูลที่ลบจะถูกทำเครื่องหมายเป็น IsActive = false
- **Audit Trail**: บันทึก CreatedDate และ UpdatedDate
- **Data Validation**: ตรวจสอบข้อมูลก่อนบันทึก
- **Unicode Support**: รองรับภาษาไทยและตัวอักษรพิเศษ

### โครงสร้าง Database

**Table: Items**
```sql
CREATE TABLE [Items] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(100) NOT NULL,
    [Description] nvarchar(500) NULL,
    [Price] decimal(18,2) NOT NULL,
    [Quantity] int NOT NULL,
    [Category] nvarchar(50) NULL,
    [CreatedDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    [UpdatedDate] datetime2 NULL,
    [IsActive] bit NOT NULL,
    CONSTRAINT [PK_Items] PRIMARY KEY ([Id])
);
```

### ข้อมูลตัวอย่างที่มีอยู่
1. รายการที่ 1 - ราคา 100.00 บาท
2. รายการที่ 2 - ราคา 200.00 บาท  
3. สินค้า A - ราคา 500.00 บาท
4. สินค้าใหม่ - ราคา 299.00 บาท (เพิ่มผ่าน API)

### วิธีการรัน API Server

```bash
cd "f:\dev2025\agent_exam\ItemsApi"
dotnet run --launch-profile http
```

API จะทำงานที่: http://localhost:5161

### วิธีการทดสอบ SQL Server โดยตรง

ใช้ไฟล์ `SQL Pi4.session.sql` ที่มี SQL scripts สำหรับทดสอบ:

```sql
-- ดูข้อมูลทั้งหมด
SELECT * FROM Items WHERE IsActive = 1;

-- เพิ่มข้อมูลใหม่
INSERT INTO Items (Name, Description, Price, Quantity, Category, CreatedDate, IsActive)
VALUES ('ทดสอบ', 'รายการทดสอบ', 100.00, 5, 'ทดสอบ', GETDATE(), 1);
```

### การแก้ไขปัญหาที่เจอ
1. ✅ แก้ไข Java version conflicts สำหรับ Android build
2. ✅ เพิ่ม Entity Framework packages
3. ✅ เปลี่ยน port จาก 5160 เป็น 5161 เพื่อหลีกเลี่ยง conflicts
4. ✅ ปิด pending model changes warning
5. ✅ เพิ่ม Unicode และ Thai language support

### Next Steps
- ✅ API พร้อมใช้งานกับ SQL Server
- ✅ Flutter app สามารถเชื่อมต่อกับ API ได้
- ✅ Database มีข้อมูลตัวอย่างพร้อมใช้งาน

**ระบบพร้อมใช้งานเต็มรูปแบบแล้ว! 🎉**

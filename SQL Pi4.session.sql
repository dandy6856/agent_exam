-- SQL Server Database Test Script
-- เชื่อมต่อกับ SQL Server: 192.168.18.55
-- Database: ItemsDb
-- User: bubble
-- Password: dT$sql6856

-- ตรวจสอบข้อมูลในตาราง Items
SELECT * FROM Items WHERE IsActive = 1;

-- นับจำนวนรายการทั้งหมด
SELECT COUNT(*) as TotalItems FROM Items;

-- นับจำนวนรายการแยกตาม Category
SELECT Category, COUNT(*) as ItemCount, AVG(Price) as AvgPrice 
FROM Items 
WHERE IsActive = 1 
GROUP BY Category;

-- เพิ่มข้อมูลทดสอบใหม่
INSERT INTO Items (Name, Description, Price, Quantity, Category, CreatedDate, IsActive)
VALUES 
('บริการพิเศษ', 'บริการดูแลลูกค้าพิเศษ', 1500.00, 3, 'บริการ', GETDATE(), 1),
('สินค้า B', 'สินค้าคุณภาพมาตรฐาน', 350.00, 15, 'สินค้า', GETDATE(), 1),
('ชุดคอมโบ', 'ชุดสินค้าราคาพิเศษ', 800.00, 8, 'โปรโมชั่น', GETDATE(), 1);

-- ตรวจสอบข้อมูลหลังจากเพิ่ม
SELECT * FROM Items WHERE IsActive = 1 ORDER BY CreatedDate DESC;

-- ทดสอบการอัปเดตข้อมูล
UPDATE Items 
SET Price = 120.00, UpdatedDate = GETDATE() 
WHERE Id = 1;

-- ทดสอบการลบข้อมูล (Soft Delete)
UPDATE Items 
SET IsActive = 0, UpdatedDate = GETDATE() 
WHERE Name = 'ชุดคอมโบ';

-- ดูข้อมูลสุดท้าย
SELECT Id, Name, Price, Quantity, Category, CreatedDate, UpdatedDate, IsActive 
FROM Items 
ORDER BY Id;

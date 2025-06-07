import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'models/user.dart';
import 'models/item.dart';
import 'pages/login_page.dart';
import 'services/auth_service.dart';
import 'services/items_service.dart';

// ฟังก์ชันหลักของแอปพลิเคชัน Flutter
void main() {
  runApp(const MyApp());
}

// คลาส MyApp เป็นจุดเริ่มต้นของแอปพลิเคชัน
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Items App', // ชื่อแอปพลิเคชัน
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ), // ธีมสีของแอป
        useMaterial3: true, // ใช้ Material Design 3
      ),
      home: const AuthWrapper(), // หน้าแรกของแอป
    );
  }
}

/// Wrapper สำหรับตรวจสอบสถานะการเข้าสู่ระบบ
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  User? _currentUser;

  /// แสดงหน้า Login
  Future<void> _showLogin() async {
    final user = await Navigator.of(
      context,
    ).push<User>(MaterialPageRoute(builder: (context) => const LoginPage()));

    if (user != null) {
      setState(() {
        _currentUser = user;
      });
    }
  }

  /// ออกจากระบบ
  Future<void> _logout() async {
    await AuthService.logout();
    setState(() {
      _currentUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      // แสดงหน้าต้อนรับก่อนเข้าสู่ระบบ
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory,
                  size: 100,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 24),
                Text(
                  'Items App',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'ระบบจัดการรายการสินค้าและบริการ',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                ElevatedButton.icon(
                  onPressed: _showLogin,
                  icon: const Icon(Icons.login),
                  label: const Text('เข้าสู่ระบบ'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // แสดงหน้าหลักหลังจากเข้าสู่ระบบแล้ว
    return ResponsiveItemsPage(user: _currentUser!, onLogout: _logout);
  }
}

// คลาส ResponsiveItemsPage ใช้สำหรับแสดงหน้า UI ที่ปรับเปลี่ยนตามขนาดหน้าจอ
class ResponsiveItemsPage extends StatelessWidget {
  final User user;
  final VoidCallback onLogout;

  const ResponsiveItemsPage({
    super.key,
    required this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // ตรวจสอบว่าเป็น Desktop (Windows/Web) หรือไม่
        bool isDesktop = constraints.maxWidth > 800;

        if (isDesktop) {
          return DesktopLayout(user: user, onLogout: onLogout);
        } else {
          return MobileLayout(user: user, onLogout: onLogout);
        }
      },
    );
  }
}

// คลาส DesktopLayout ใช้สำหรับแสดง UI ใน Desktop
class DesktopLayout extends StatelessWidget {
  final User user;
  final VoidCallback onLogout;

  const DesktopLayout({super.key, required this.user, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 280, // กำหนดความกว้างของ Sidebar
            decoration: BoxDecoration(
              color:
                  Theme.of(
                    context,
                  ).colorScheme.surfaceVariant, // สีพื้นหลังของ Sidebar
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // เงาของ Sidebar
                  blurRadius: 4,
                  offset: const Offset(2, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary, // สีหลัก
                        Theme.of(context).colorScheme.primaryContainer, // สีรอง
                      ],
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Items App', // ชื่อแอปพลิเคชัน
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'รายการสินค้าและบริการ', // คำอธิบายแอป
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),

                // ข้อมูลผู้ใช้
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            user.displayName.isNotEmpty
                                ? user.displayName[0]
                                : user.username[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          user.displayName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '@${user.username}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            user.role,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ข้อมูลระบบ
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ข้อมูลระบบ', // ข้อมูลแพลตฟอร์ม
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildInfoCard(
                          'Platform',
                          'Desktop',
                        ), // การ์ดข้อมูลแพลตฟอร์ม
                        _buildInfoCard(
                          'API Endpoint',
                          '${AuthService.getBaseUrl()}:5161',
                        ), // การ์ดข้อมูล API
                        _buildInfoCard(
                          'UI Framework',
                          'Flutter',
                        ), // การ์ดข้อมูล UI Framework
                      ],
                    ),
                  ),
                ),

                // ปุ่มออกจากระบบ
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onLogout,
                      icon: const Icon(Icons.logout),
                      label: const Text('ออกจากระบบ'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade50,
                        foregroundColor: Colors.red.shade700,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Main content
          const Expanded(child: ItemsContent()),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// คลาส MobileLayout ใช้สำหรับแสดง UI ใน Mobile
class MobileLayout extends StatelessWidget {
  final User user;
  final VoidCallback onLogout;

  const MobileLayout({super.key, required this.user, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการสินค้า'), // ชื่อหน้าใน Mobile
        backgroundColor:
            Theme.of(
              context,
            ).colorScheme.inversePrimary, // สีพื้นหลังของ AppBar
        elevation: 2, // ความสูงของเงา AppBar
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                onLogout();
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'profile',
                    child: Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.displayName),
                            Text(
                              '@${user.username}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.red),
                        SizedBox(width: 8),
                        Text('ออกจากระบบ', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  user.displayName.isNotEmpty
                      ? user.displayName[0]
                      : user.username[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: const ItemsContent(), // เนื้อหาในหน้า Mobile
    );
  }
}

// คลาส ItemsContent ใช้สำหรับแสดงรายการสินค้า
class ItemsContent extends StatefulWidget {
  const ItemsContent({super.key});

  @override
  State<ItemsContent> createState() => _ItemsContentState();
}

class _ItemsContentState extends State<ItemsContent> {
  List<Item> items = []; // รายการสินค้า
  bool isLoading = false; // สถานะการโหลดข้อมูล
  String? error; // ข้อผิดพลาด

  Future<void> fetchItems() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final itemsList = await ItemsService.getItems();
      setState(() {
        items = itemsList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ได้: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ตรวจสอบว่าเป็น desktop layout หรือไม่
    bool isDesktop = MediaQuery.of(context).size.width > 800;

    return Padding(
      padding: EdgeInsets.all(isDesktop ? 32.0 : 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop) ...[
            Text(
              'รายการสินค้าจาก SQL Server',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'ดึงข้อมูลจาก SQL Server Database',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
          ],
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isLoading ? null : fetchItems,
              icon: const Icon(Icons.refresh),
              label: const Text('ดึงข้อมูล'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, isDesktop ? 56 : 50),
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: isDesktop ? 16 : 12,
                ),
              ),
            ),
          ),
          SizedBox(height: isDesktop ? 24 : 16),
          if (isLoading)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    SizedBox(height: isDesktop ? 24 : 16),
                    const Text('กำลังดึงข้อมูล...'),
                  ],
                ),
              ),
            )
          else if (error != null)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                      size: isDesktop ? 80 : 64,
                    ),
                    SizedBox(height: isDesktop ? 24 : 16),
                    Text(
                      error!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: isDesktop ? 18 : 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else if (items.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.list_alt,
                      size: isDesktop ? 80 : 64,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(height: isDesktop ? 24 : 16),
                    Text(
                      'กดปุ่ม "ดึงข้อมูล" เพื่อแสดงรายการ',
                      style: TextStyle(
                        fontSize: isDesktop ? 18 : 16,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child:
                  isDesktop
                      ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2.2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: Text(
                                          '${item.id}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            if (item.category != null)
                                              Text(
                                                item.category!,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '฿${item.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  if (item.description != null)
                                    Text(
                                      item.description!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.inventory,
                                        size: 16,
                                        color: Colors.grey.shade600,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'คงเหลือ: ${item.quantity}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              item.isActive
                                                  ? Colors.green.shade100
                                                  : Colors.red.shade100,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          item.isActive
                                              ? 'ใช้งาน'
                                              : 'ปิดใช้งาน',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color:
                                                item.isActive
                                                    ? Colors.green.shade700
                                                    : Colors.red.shade700,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                      : ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  '${item.id}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (item.description != null)
                                    Text(
                                      item.description!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        '฿${item.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'คงเหลือ: ${item.quantity}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      if (item.category != null) ...[
                                        const SizedBox(width: 8),
                                        Text(
                                          item.category!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          item.isActive
                                              ? Colors.green.shade100
                                              : Colors.red.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      item.isActive ? 'ใช้งาน' : 'ปิดใช้งาน',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color:
                                            item.isActive
                                                ? Colors.green.shade700
                                                : Colors.red.shade700,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

/// บริการจัดการการเข้าสู่ระบบ
class AuthService {
  /// กำหนด base URL ตาม platform
  static String getBaseUrl() {
    // ใช้ 10.0.2.2 สำหรับ Android Emulator, 127.0.0.1 สำหรับ platforms อื่น
    if (defaultTargetPlatform == TargetPlatform.android) {
      return '10.0.2.2';
    } else {
      return '127.0.0.1';
    }
  }

  /// เข้าสู่ระบบ
  static Future<LoginResponse> login(String username, String password) async {
    try {
      final baseUrl = getBaseUrl();
      final response = await http.post(
        Uri.parse('http://$baseUrl:5160/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );

      final Map<String, dynamic> data = json.decode(response.body);
      return LoginResponse.fromJson(data);
    } catch (e) {
      return LoginResponse(
        success: false,
        message: 'ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ได้: $e',
      );
    }
  }

  /// ออกจากระบบ
  static Future<bool> logout() async {
    try {
      final baseUrl = getBaseUrl();
      final response = await http.post(
        Uri.parse('http://$baseUrl:5160/api/auth/logout'),
        headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// ตรวจสอบสถานะเซิร์ฟเวอร์
  static Future<bool> checkServerStatus() async {
    try {
      final baseUrl = getBaseUrl();
      final response = await http.get(
        Uri.parse('http://$baseUrl:5160/api/auth/status'),
        headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

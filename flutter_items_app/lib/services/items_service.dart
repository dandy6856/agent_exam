import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item.dart';
import 'auth_service.dart';

/// บริการจัดการข้อมูลสินค้า
class ItemsService {
  static String get baseUrl => AuthService.getBaseUrl();
  static String get itemsUrl => 'http://$baseUrl:5160/api/items';

  /// ดึงรายการสินค้าทั้งหมด
  static Future<List<Item>> getItems() async {
    try {
      final response = await http.get(
        Uri.parse(itemsUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => Item.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load items: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// ดึงข้อมูลสินค้าตาม ID
  static Future<Item> getItem(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$itemsUrl/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Item.fromJson(data);
      } else {
        throw Exception('Failed to load item: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// สร้างสินค้าใหม่
  static Future<Item> createItem({
    required String name,
    String? description,
    required double price,
    required int quantity,
    String? category,
  }) async {
    try {
      final Map<String, dynamic> createData = {
        'name': name,
        'description': description,
        'price': price,
        'quantity': quantity,
        'category': category,
      };

      final response = await http.post(
        Uri.parse(itemsUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(createData),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Item.fromJson(data);
      } else {
        throw Exception('Failed to create item: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// อัปเดตข้อมูลสินค้า
  static Future<void> updateItem({
    required int id,
    required String name,
    String? description,
    required double price,
    required int quantity,
    String? category,
  }) async {
    try {
      final Map<String, dynamic> updateData = {
        'name': name,
        'description': description,
        'price': price,
        'quantity': quantity,
        'category': category,
      };

      final response = await http.put(
        Uri.parse('$itemsUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updateData),
      );

      if (response.statusCode != 204) {
        throw Exception('Failed to update item: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// ลบสินค้า (soft delete)
  static Future<void> deleteItem(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$itemsUrl/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 204) {
        throw Exception('Failed to delete item: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}

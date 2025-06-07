/// โมเดลข้อมูลผู้ใช้
class User {
  final String username;
  final String displayName;
  final String role;

  User({required this.username, required this.displayName, required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] ?? '',
      displayName: json['displayName'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'username': username, 'displayName': displayName, 'role': role};
  }
}

/// โมเดลผลลัพธ์การเข้าสู่ระบบ
class LoginResponse {
  final bool success;
  final String message;
  final String? token;
  final User? user;

  LoginResponse({
    required this.success,
    required this.message,
    this.token,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: json['token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

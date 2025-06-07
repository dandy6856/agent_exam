namespace ItemsApi.Models
{
    /// <summary>
    /// โมเดลสำหรับข้อมูลการเข้าสู่ระบบ
    /// </summary>
    public class LoginRequest
    {
        public string Username { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
    }

    /// <summary>
    /// โมเดลสำหรับผลลัพธ์การเข้าสู่ระบบ
    /// </summary>
    public class LoginResponse
    {
        public bool Success { get; set; }
        public string Message { get; set; } = string.Empty;
        public string? Token { get; set; }
        public UserInfo? User { get; set; }
    }

    /// <summary>
    /// ข้อมูลผู้ใช้
    /// </summary>
    public class UserInfo
    {
        public string Username { get; set; } = string.Empty;
        public string DisplayName { get; set; } = string.Empty;
        public string Role { get; set; } = string.Empty;
    }
}

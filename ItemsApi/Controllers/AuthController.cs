using Microsoft.AspNetCore.Mvc;
using ItemsApi.Models;

namespace ItemsApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly ILogger<AuthController> _logger;

        public AuthController(ILogger<AuthController> logger)
        {
            _logger = logger;
        }

        /// <summary>
        /// จำลองการเข้าสู่ระบบ
        /// </summary>
        [HttpPost("login")]
        public ActionResult<LoginResponse> Login([FromBody] LoginRequest request)
        {
            _logger.LogInformation($"Login attempt for username: {request.Username}");

            // จำลองข้อมูลผู้ใช้
            var users = new Dictionary<string, (string password, string displayName, string role)>
            {
                { "admin", ("admin123", "ผู้ดูแลระบบ", "Administrator") },
                { "user", ("user123", "ผู้ใช้ทั่วไป", "User") },
                { "demo", ("demo", "ผู้ใช้ทดสอบ", "Demo") }
            };

            // ตรวจสอบว่ามีผู้ใช้และรหัสผ่านถูกต้องหรือไม่
            if (users.ContainsKey(request.Username) && 
                users[request.Username].password == request.Password)
            {
                var user = users[request.Username];
                
                _logger.LogInformation($"Login successful for user: {request.Username}");

                return Ok(new LoginResponse
                {
                    Success = true,
                    Message = "เข้าสู่ระบบสำเร็จ",
                    Token = $"fake-jwt-token-{request.Username}-{DateTime.Now.Ticks}",
                    User = new UserInfo
                    {
                        Username = request.Username,
                        DisplayName = user.displayName,
                        Role = user.role
                    }
                });
            }

            _logger.LogWarning($"Login failed for username: {request.Username}");

            return Unauthorized(new LoginResponse
            {
                Success = false,
                Message = "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง"
            });
        }

        /// <summary>
        /// จำลองการออกจากระบบ
        /// </summary>
        [HttpPost("logout")]
        public ActionResult<LoginResponse> Logout()
        {
            _logger.LogInformation("User logged out");

            return Ok(new LoginResponse
            {
                Success = true,
                Message = "ออกจากระบบสำเร็จ"
            });
        }

        /// <summary>
        /// ตรวจสอบสถานะการเข้าสู่ระบบ
        /// </summary>
        [HttpGet("status")]
        public ActionResult<object> GetStatus()
        {
            return Ok(new
            {
                authenticated = true,
                server = "ItemsApi",
                timestamp = DateTime.Now,
                message = "API พร้อมใช้งาน",
                endpoints = new
                {
                    login = "/api/auth/login",
                    logout = "/api/auth/logout",
                    items = "/api/items"
                }
            });
        }

        /// <summary>
        /// ข้อมูลผู้ใช้ทดสอบ (สำหรับการพัฒนา)
        /// </summary>
        [HttpGet("demo-users")]
        public ActionResult<object> GetDemoUsers()
        {
            var demoUsers = new[]
            {
                new { username = "admin", password = "admin123", role = "ผู้ดูแลระบบ" },
                new { username = "user", password = "user123", role = "ผู้ใช้ทั่วไป" },
                new { username = "demo", password = "demo", role = "ผู้ใช้ทดสอบ" }
            };

            return Ok(new
            {
                message = "ข้อมูลผู้ใช้ทดสอบ",
                users = demoUsers,
                note = "ใช้สำหรับการทดสอบเท่านั้น"
            });
        }
    }
}

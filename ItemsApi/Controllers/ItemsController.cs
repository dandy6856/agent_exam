using Microsoft.AspNetCore.Mvc;

namespace ItemsApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ItemsController : ControllerBase
    {
        [HttpGet]
        public ActionResult<IEnumerable<string>> GetItems()
        {
            var items = new List<string>
            {
                "รายการที่ 1",
                "รายการที่ 2", 
                "รายการที่ 3",
                "สินค้า A",
                "สินค้า B",
                "บริการพิเศษ"
            };

            return Ok(items);
        }
    }
}

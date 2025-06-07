using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ItemsApi.Data;
using ItemsApi.Models;
using ItemsApi.Models.DTOs;

namespace ItemsApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ItemsController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public ItemsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/Items
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ItemDto>>> GetItems()
        {
            var items = await _context.Items
                .Where(i => i.IsActive)
                .Select(i => new ItemDto
                {
                    Id = i.Id,
                    Name = i.Name,
                    Description = i.Description,
                    Price = i.Price,
                    Quantity = i.Quantity,
                    Category = i.Category,
                    CreatedDate = i.CreatedDate,
                    UpdatedDate = i.UpdatedDate,
                    IsActive = i.IsActive
                })
                .ToListAsync();

            return Ok(items);
        }

        // GET: api/Items/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ItemDto>> GetItem(int id)
        {
            var item = await _context.Items.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            var itemDto = new ItemDto
            {
                Id = item.Id,
                Name = item.Name,
                Description = item.Description,
                Price = item.Price,
                Quantity = item.Quantity,
                Category = item.Category,
                CreatedDate = item.CreatedDate,
                UpdatedDate = item.UpdatedDate,
                IsActive = item.IsActive
            };

            return Ok(itemDto);
        }

        // POST: api/Items
        [HttpPost]
        public async Task<ActionResult<ItemDto>> CreateItem(CreateItemDto createItemDto)
        {
            var item = new Item
            {
                Name = createItemDto.Name,
                Description = createItemDto.Description,
                Price = createItemDto.Price,
                Quantity = createItemDto.Quantity,
                Category = createItemDto.Category,
                CreatedDate = DateTime.Now,
                IsActive = true
            };

            _context.Items.Add(item);
            await _context.SaveChangesAsync();

            var itemDto = new ItemDto
            {
                Id = item.Id,
                Name = item.Name,
                Description = item.Description,
                Price = item.Price,
                Quantity = item.Quantity,
                Category = item.Category,
                CreatedDate = item.CreatedDate,
                UpdatedDate = item.UpdatedDate,
                IsActive = item.IsActive
            };

            return CreatedAtAction(nameof(GetItem), new { id = item.Id }, itemDto);
        }

        // PUT: api/Items/5
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateItem(int id, UpdateItemDto updateItemDto)
        {
            var item = await _context.Items.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            item.Name = updateItemDto.Name;
            item.Description = updateItemDto.Description;
            item.Price = updateItemDto.Price;
            item.Quantity = updateItemDto.Quantity;
            item.Category = updateItemDto.Category;
            item.IsActive = updateItemDto.IsActive;
            item.UpdatedDate = DateTime.Now;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ItemExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // DELETE: api/Items/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteItem(int id)
        {
            var item = await _context.Items.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }

            // Soft delete - just mark as inactive
            item.IsActive = false;
            item.UpdatedDate = DateTime.Now;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ItemExists(int id)
        {
            return _context.Items.Any(e => e.Id == id);
        }
    }
}

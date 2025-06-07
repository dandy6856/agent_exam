using System.ComponentModel.DataAnnotations;

namespace ItemsApi.Models
{
    public class Item
    {
        public int Id { get; set; }
        
        [Required]
        [MaxLength(100)]
        public string Name { get; set; } = string.Empty;
        
        [MaxLength(500)]
        public string? Description { get; set; }
        
        public decimal Price { get; set; }
        
        public int Quantity { get; set; }
        
        [MaxLength(50)]
        public string? Category { get; set; }
        
        public DateTime CreatedDate { get; set; } = DateTime.Now;
        
        public DateTime? UpdatedDate { get; set; }
        
        public bool IsActive { get; set; } = true;
    }
}

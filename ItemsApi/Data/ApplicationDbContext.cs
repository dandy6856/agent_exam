using Microsoft.EntityFrameworkCore;
using ItemsApi.Models;

namespace ItemsApi.Data
{    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.ConfigureWarnings(warnings => 
                warnings.Ignore(Microsoft.EntityFrameworkCore.Diagnostics.RelationalEventId.PendingModelChangesWarning));
        }

        public DbSet<Item> Items { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configure Item entity
            modelBuilder.Entity<Item>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Name).IsRequired().HasMaxLength(100);
                entity.Property(e => e.Description).HasMaxLength(500);
                entity.Property(e => e.Category).HasMaxLength(50);
                entity.Property(e => e.Price).HasColumnType("decimal(18,2)");
                entity.Property(e => e.CreatedDate).HasDefaultValueSql("GETDATE()");
            });

            // Seed some initial data
            modelBuilder.Entity<Item>().HasData(
                new Item 
                { 
                    Id = 1, 
                    Name = "รายการที่ 1", 
                    Description = "รายการทดสอบแรก", 
                    Price = 100.00m, 
                    Quantity = 10, 
                    Category = "ทดสอบ",
                    CreatedDate = DateTime.Now
                },
                new Item 
                { 
                    Id = 2, 
                    Name = "รายการที่ 2", 
                    Description = "รายการทดสอบที่สอง", 
                    Price = 200.00m, 
                    Quantity = 5, 
                    Category = "ทดสอบ",
                    CreatedDate = DateTime.Now
                },
                new Item 
                { 
                    Id = 3, 
                    Name = "สินค้า A", 
                    Description = "สินค้าคุณภาพสูง", 
                    Price = 500.00m, 
                    Quantity = 20, 
                    Category = "สินค้า",
                    CreatedDate = DateTime.Now
                }
            );
        }
    }
}

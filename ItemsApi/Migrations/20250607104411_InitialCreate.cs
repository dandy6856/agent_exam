using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace ItemsApi.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Items",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Description = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true),
                    Price = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Quantity = table.Column<int>(type: "int", nullable: false),
                    Category = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()"),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsActive = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Items", x => x.Id);
                });

            migrationBuilder.InsertData(
                table: "Items",
                columns: new[] { "Id", "Category", "CreatedDate", "Description", "IsActive", "Name", "Price", "Quantity", "UpdatedDate" },
                values: new object[,]
                {
                    { 1, "ทดสอบ", new DateTime(2025, 6, 7, 17, 44, 11, 222, DateTimeKind.Local).AddTicks(842), "รายการทดสอบแรก", true, "รายการที่ 1", 100.00m, 10, null },
                    { 2, "ทดสอบ", new DateTime(2025, 6, 7, 17, 44, 11, 222, DateTimeKind.Local).AddTicks(1066), "รายการทดสอบที่สอง", true, "รายการที่ 2", 200.00m, 5, null },
                    { 3, "สินค้า", new DateTime(2025, 6, 7, 17, 44, 11, 222, DateTimeKind.Local).AddTicks(1068), "สินค้าคุณภาพสูง", true, "สินค้า A", 500.00m, 20, null }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Items");
        }
    }
}

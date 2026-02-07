using Microsoft.EntityFrameworkCore;
using Photography.Api.Models;

namespace Photography.Api.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Employee> Employees { get; set; } = null!;

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Employee>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Name).IsRequired().HasMaxLength(200);
                entity.Property(e => e.Email).IsRequired().HasMaxLength(200);
                entity.Property(e => e.Phone).HasMaxLength(50);
                entity.Property(e => e.Department).HasMaxLength(100);
                entity.Property(e => e.Designation).HasMaxLength(100);
            });
        }
    }
}

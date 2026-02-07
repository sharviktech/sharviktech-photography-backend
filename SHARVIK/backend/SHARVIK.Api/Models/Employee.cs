using System.ComponentModel.DataAnnotations;

namespace SHARVIK.Api.Models
{
    public class Employee
    {
        public int Id { get; set; }

        [Required]
        [MaxLength(200)]
        public string Name { get; set; } = string.Empty;

        [Required]
        [EmailAddress]
        [MaxLength(200)]
        public string Email { get; set; } = string.Empty;

        [MaxLength(50)]
        public string? Phone { get; set; }

        [MaxLength(100)]
        public string? Department { get; set; }

        [MaxLength(100)]
        public string? Designation { get; set; }
    }
}

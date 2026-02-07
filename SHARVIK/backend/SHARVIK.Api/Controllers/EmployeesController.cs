using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SHARVIK.Api.Data;
using SHARVIK.Api.Models;

namespace SHARVIK.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmployeesController : ControllerBase
    {
        private readonly AppDbContext _context;

        public EmployeesController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/employees
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var list = new List<Employee> { new Employee { Id = 1, Name = "Alice Johnson", Email = "alice.johnson@example.com", Phone = "123-456-7890", Department = "HR", Designation = "Manager" }, new Employee { Id = 2, Name = "Bob Smith", Email = "bob.smith@example.com", Phone = "987-654-3210", Department = "IT", Designation = "Developer" }, new Employee { Id = 3, Name = "Charlie Brown", Email = "charlie.brown@example.com", Phone = "555-555-5555", Department = "Finance", Designation = "Analyst" } };
              
            //var list = await _context.Employees.AsNoTracking().ToListAsync();
            return Ok(list);
        }

        // GET: api/employees/5
        [HttpGet("{id:int}")]
        public async Task<IActionResult> Get(int id)
        {
            var emp = await _context.Employees.FindAsync(id);
            if (emp == null) return NotFound();
            return Ok(emp);
        }

        // POST: api/employees
        [HttpPost]
        public async Task<IActionResult> Create([FromBody] Employee employee)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            _context.Employees.Add(employee);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(Get), new { id = employee.Id }, employee);
        }

        // PUT: api/employees/5
        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, [FromBody] Employee employee)
        {
            if (id != employee.Id) return BadRequest("Id mismatch.");
            if (!ModelState.IsValid) return BadRequest(ModelState);

            var exists = await _context.Employees.AnyAsync(e => e.Id == id);
            if (!exists) return NotFound();

            _context.Entry(employee).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        // DELETE: api/employees/5
        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            var emp = await _context.Employees.FindAsync(id);
            if (emp == null) return NotFound();

            _context.Employees.Remove(emp);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}

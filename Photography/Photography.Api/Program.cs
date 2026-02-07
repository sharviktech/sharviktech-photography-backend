using Microsoft.EntityFrameworkCore;
using Photography.Api.Data;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers()
    .AddJsonOptions(opts => { opts.JsonSerializerOptions.PropertyNamingPolicy = null; });
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Configure DbContext using connection string from appsettings.json
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") ?? "Server=(localdb)\\mssqllocaldb;Database=PhotographyDb;Trusted_Connection=True;MultipleActiveResultSets=true";
builder.Services.AddDbContext<AppDbContext>(options => options.UseSqlServer(connectionString));

// Enable CORS for Angular dev server
builder.Services.AddCors(options =>
{
    options.AddPolicy(name: "AllowAngularDevClient",
        policy =>
        {
            policy.WithOrigins("http://localhost:4200")
                  .AllowAnyHeader()
                  .AllowAnyMethod();
        });
});

var app = builder.Build();

// Automatically apply migrations (safe for dev)
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    try
    {
        db.Database.Migrate();
    }
    catch
    {
        // For production, handle migration exceptions appropriately
    }
}

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    //app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseCors("AllowAngularDevClient");
app.UseAuthorization();
app.MapControllers();
app.Run();

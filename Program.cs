using Microsoft.EntityFrameworkCore;
using BookStore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
    });
});

builder.Services.AddDbContext<BookStoreContext>(options =>
    options.UseSqlite(builder.Configuration.GetConnectionString("BookStoreDatabase")));

builder.Services.AddControllersWithViews();

builder.WebHost.UseKestrel(options =>
{
    options.ListenLocalhost(7001);
});

var app = builder.Build();

// Apply migrations automatically
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<BookStoreContext>();
    db.Database.Migrate();
}

// Configure the HTTP request pipeline.
app.UseCors("AllowAll");
app.UseFileServer();
app.UseRouting();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();

using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace BookStore.Controllers
{
    public class HomeController : Controller
    {
        private readonly BookStoreContext _context;

        public HomeController(BookStoreContext context)
        {
            _context = context ?? throw new ArgumentNullException(nameof(context));
        }

        public async Task<IActionResult> Index()
        {
            var books = await _context.Book.Include(b => b.Category).ToListAsync();
            return View(books);
        }

        [HttpGet]
        public async Task<IActionResult> Search(string title, string category)
        {
            var books = await _context.Book
                .Include(b => b.Category)
                .Where(b => (string.IsNullOrEmpty(title) || b.Title.Contains(title)) &&
                            (string.IsNullOrEmpty(category) || b.Category.Name.Contains(category)))
                .ToListAsync();
            return View("Search", books); // Search
        }


        [HttpPost]
        public async Task<IActionResult> AddBook(Book book)
        {
            if (ModelState.IsValid)
            {
                _context.Book.Add(book);
                await _context.SaveChangesAsync();
            }
            return RedirectToAction("Index");
        }

        [HttpPost]
        public async Task<IActionResult> DeleteBook(int id)
        {
            var book = await _context.Book.FindAsync(id);
            if (book != null)
            {
                _context.Book.Remove(book);
                await _context.SaveChangesAsync();
            }
            return RedirectToAction("Index");
        }

        [HttpGet]
        public async Task<IActionResult> Summary()
        {
            var summary = await _context.Book
                .GroupBy(b => b.Category.Name)
                .Select(g => new { Category = g.Key, Count = g.Count() })
                .ToListAsync();
            return Json(summary);
        }

    }
}

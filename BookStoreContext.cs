using Microsoft.EntityFrameworkCore;

namespace BookStore
{
    public class BookStoreContext : DbContext
    {
        public BookStoreContext(DbContextOptions<BookStoreContext> options)
            : base(options)
        {
        }

        public DbSet<Book> Book { get; set; }
        public DbSet<Category> Category { get; set; }
    }
}

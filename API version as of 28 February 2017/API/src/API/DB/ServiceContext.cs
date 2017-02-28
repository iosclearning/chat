using Microsoft.EntityFrameworkCore;

namespace API.Models
{
    public class ServiceContext : DbContext
    {
        public ServiceContext(DbContextOptions<ServiceContext> options)
            : base(options)
        { }

        public DbSet<Configuration> Configurations { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Contact> Contacts { get; set; }
        public DbSet<MessageClass> Messages { get; set; }
        public DbSet<ContactList> ContactLists { get; set; }
        public DbSet<Chat> Chats { get; set; }
        public DbSet<GroupUser> GroupUsers { get; set; }
    }
}

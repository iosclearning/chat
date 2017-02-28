using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;
using API.Models;
using API.Repository.ConfigurationRepository;
using API.Repository.ContactRepository;
using API.Repository.MessageRepository;
using API.Repository.UserRepository;
using API.Repository.ContactListRepository;
using API.Repository.ChatRepository;

namespace API
{
    public class Startup
    {
        public Startup(IHostingEnvironment env)
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(env.ContentRootPath)
                .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
                .AddJsonFile($"appsettings.{env.EnvironmentName}.json", optional: true)
                .AddEnvironmentVariables();
            Configuration = builder.Build();
        }

        public IConfigurationRoot Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            // Add framework services.
            services.AddMvc();

            services.AddCors();

            services.AddSingleton<IConfigurationRepository, ConfigurationRepository>();
            services.AddSingleton<IUserRepository, UserRepository>();
            services.AddSingleton<IContactRepository, ContactRepository>();
            services.AddSingleton<IMessageRepository, MessageRepository>();
            services.AddSingleton<IContactListRepository, ContactListRepository>();
            services.AddSingleton<IChatRepository, ChatRepository>();

            //var connection = @"Server=(localdb)\mssqllocaldb;Database=APIChatServiceDatabase;Trusted_Connection=True;";
            var connection = @"Server=tcp:apichatservicedatabase.database.windows.net,1433;Initial Catalog=APIChatServiceDatabase;Persist Security Info=False;User ID=dadmin;Password=Training2017!;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";

        services.AddDbContext<ServiceContext>(options => options.UseSqlServer(connection));
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, ILoggerFactory loggerFactory)
        {
            loggerFactory.AddConsole(Configuration.GetSection("Logging"));
            loggerFactory.AddDebug();

            app.UseMvc();
        }
    }
}

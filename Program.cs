using System;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;

namespace my_mvc_demo_react
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateWebHostBuilder(args).Build().Run();
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args)
        {
            object port = Environment.GetEnvironmentVariable("PORT");
            if(null == port) {
                port = 8081;
            }

            return WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>().UseUrls("http://*:" + port); ;

        }

    }
}

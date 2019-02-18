using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SmartCities.Startup))]
namespace SmartCities
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}

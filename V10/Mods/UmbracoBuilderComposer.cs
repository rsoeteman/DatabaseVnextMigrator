using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Notifications;

namespace Convert10Site.Mods;

public class UmbracoBuilderComposer :IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        //services
        builder.Services.AddNotifications();
    }
}
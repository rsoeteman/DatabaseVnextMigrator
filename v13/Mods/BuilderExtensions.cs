using Lucene.Net.Util.Fst;
using Convert13Site.Mods.NotificationHandlers;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Infrastructure.DependencyInjection;
using Umbraco.Cms.Infrastructure.PublishedCache.Persistence;

namespace Convert13Site.Mods
{
    public static class BuilderExtensions 
    {
        public static  IUmbracoBuilder AddNotifications(this IUmbracoBuilder builder)
        {
            builder.AddNotificationHandler<UmbracoApplicationStartingNotification, ResetAdminUser>();
            return builder;
        }
    }
}

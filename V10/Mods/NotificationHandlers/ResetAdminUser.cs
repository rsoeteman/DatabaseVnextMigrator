using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Security;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Web.Common.Models;
using Umbraco.Cms.Web.Common.Security;

namespace Convert10Site.Mods
{
    public class ResetAdminUser : INotificationHandler<UmbracoApplicationStartingNotification>
    {
        private readonly IUserService _userService;
        private readonly IBackOfficeUserManager _backOfficeUserManager;

        public ResetAdminUser(IUserService userService, IBackOfficeUserManager backOfficeUserManager)
        {
            _userService = userService;
            _backOfficeUserManager = backOfficeUserManager;
        }

        public void Handle(UmbracoApplicationStartingNotification notification)
        {
            if (notification.RuntimeLevel >= RuntimeLevel.Run || notification.RuntimeLevel == RuntimeLevel.Upgrade)
            {
                var user= _userService.GetUserById(-1);
                if (user != null && user.Email != "richard@soetemansoftware.nl")
                {
                    //Old admin user, hack me in
                    user.Name = "Richard Soeteman";
                    user.Email = "richard@soetemansoftware.nl";
                    user.Username =  "richard@soetemansoftware.nl";
                    _userService.Save(user);

                    var identityUser =  _backOfficeUserManager.FindByEmailAsync(user.Email).Result;
                    if (identityUser != null)
                    {
                        var token = _backOfficeUserManager.GeneratePasswordResetTokenAsync(identityUser).Result;

                        _backOfficeUserManager.ResetPasswordAsync(identityUser, token, "test123456");
                       
                    }
                }
            }
        }
    }
}

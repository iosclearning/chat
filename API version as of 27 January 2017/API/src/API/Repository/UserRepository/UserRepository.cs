using System;
using System.Linq;
using API.Models;

namespace API.Repository.UserRepository
{
    public class UserRepository : IUserRepository
    {
        private readonly ServiceContext _serviceContext;

        public UserRepository(ServiceContext serviceContext)
        {
            _serviceContext = serviceContext;
        }

        public string Register(User user)
        {
            if(!string.IsNullOrEmpty(user.Email)
                && !string.IsNullOrEmpty(user.Password))
            {
                User foundUser = _serviceContext.Users.FirstOrDefault(u => u.Email == user.Email);
                if(foundUser != null)
                {
                    return "User with the provided email is already restarted. Please Log In.";
                }
                else
                {
                    user.AccessToken = Guid.NewGuid().ToString().Replace("-", "").Substring(0, 8);
                    _serviceContext.Users.Add(user);
                    _serviceContext.SaveChangesAsync();
                    return user.AccessToken;
                }
            } else
            {
                return "Please provide valid email and password.";
            }
        }

        public string Login(User user)
        {
            if (!string.IsNullOrEmpty(user.Email)
                && !string.IsNullOrEmpty(user.Password))
            {
                User foundUser = _serviceContext.Users.FirstOrDefault(u => u.Email == user.Email);
                if (foundUser == null)
                {
                    return "User with the provided email is not registered. Please Register.";
                }
                else
                {
                    return foundUser.AccessToken;
                }
            }
            else
            {
                return "Please provide valid email and password.";
            }
        }
    }
}

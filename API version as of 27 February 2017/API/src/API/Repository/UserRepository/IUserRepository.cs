using System;
using API.Models;

namespace API.Repository.UserRepository
{
    public interface IUserRepository
    {
        string Register(User user);
        string Login(User user);
        User GetUserData(string accessToken);
        User UpdateUserData(User user);
    }
}

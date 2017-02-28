using System;
using System.Linq;
using API.Models;
using System.Security.Cryptography;
using System.Text;
using Microsoft.AspNetCore.Cryptography.KeyDerivation;

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
                    string hashedPassword = HashPassword(user);
                    user.Password = hashedPassword;
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
                string hashedPassword = GetHashedPassword(user, foundUser);
                User authenticatedUser = _serviceContext.Users.FirstOrDefault(u => u.Email == user.Email && u.Password == hashedPassword);
                if (foundUser == null)
                {
                    return "User with the provided email is not registered. Please Register.";
                }
                if(authenticatedUser == null)
                {
                    return "Incorrect password.";
                }
                else if(authenticatedUser != null)
                {
                    return authenticatedUser.AccessToken;
                }
                else
                {
                    return "Unknown error occurred. Please contact administrator for assistance.";
                }
            }
            else
            {
                return "Please provide valid email and password.";
            }
        }

        public User GetUserData(string accessToken)
        {
            User user = _serviceContext.Users.FirstOrDefault(u => u.AccessToken == accessToken);
            if(user != null)
            {
                return user;
            }
            else
            {
                return new User();
            }
        }

        public User UpdateUserData(User user)
        {
            User foundUser = _serviceContext.Users.FirstOrDefault(u => u.AccessToken == user.AccessToken);
            try
            {
                foundUser.FirstName = user.FirstName;
                foundUser.LastName = user.LastName;
                foundUser.Sex = user.Sex;
                foundUser.Username = user.Username;
                foundUser.Password = user.Password;
                _serviceContext.Users.Update(foundUser);
                _serviceContext.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Somethign went wrong ", ex.InnerException);
            }
            return foundUser;
        }

        private string HashPassword(User user)
        {
            byte[] salt = new byte[128 / 8];
            user.Salt = salt;
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }
            string hashedPassword = Convert.ToBase64String(KeyDerivation.Pbkdf2(
                password: user.Password,
                salt: salt,
                prf: KeyDerivationPrf.HMACSHA1,
                iterationCount: 10000,
                numBytesRequested: 256 / 8));
            return hashedPassword;
        }

        private string GetHashedPassword(User user, User foundUser)
        {
            string hashedPassword = Convert.ToBase64String(KeyDerivation.Pbkdf2(
                password: user.Password,
                salt: foundUser.Salt,
                prf: KeyDerivationPrf.HMACSHA1,
                iterationCount: 10000,
                numBytesRequested: 256 / 8));
            return hashedPassword;
        }
    }
}

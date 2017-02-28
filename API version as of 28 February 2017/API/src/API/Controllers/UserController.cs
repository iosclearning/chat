using Microsoft.AspNetCore.Mvc;
using System;
using API.Helpers;
using API.Models;
using API.Repository.UserRepository;

namespace API.Controllers
{
    [Route("api/[controller]")]
    public class UserController : Controller
    {
        private readonly IUserRepository _userRepository;

        public UserController(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        [HttpPost]
        [Route("Register")]
        public IActionResult Register([FromBody]User user)
        {
            string accessToken = _userRepository.Register(user);

            return Ok(accessToken);
        }

        [HttpPost]
        [Route("Login")]
        public IActionResult Login([FromBody]User user)
        {
            string accessToken = _userRepository.Login(user);

            return Ok(accessToken);
        }

        [HttpPost]
        [Route("GetUserData")]
        public IActionResult GetUserData([FromBody]User user)
        {
            User foundUser = _userRepository.GetUserData(user.AccessToken);

            return Ok(foundUser);
        }

        [HttpPost]
        [Route("UpdateUserData")]
        public IActionResult UpdateUserData([FromBody]User user)
        {
            User updatedUser = _userRepository.UpdateUserData(user);

            return Ok(updatedUser);
        }
    }
}

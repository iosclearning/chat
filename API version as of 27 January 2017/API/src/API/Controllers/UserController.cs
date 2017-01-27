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
    }
}

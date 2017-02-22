using Microsoft.AspNetCore.Mvc;
using System;
using API.Helpers;
using API.Models;
using API.Repository.MessageRepository;

namespace API.Controllers
{
    [Route("api/[controller]")]
    public class MessageController : Controller
    {
        private readonly IMessageRepository _messageRepository;

        public MessageController(IMessageRepository messageRepository)
        {
            _messageRepository = messageRepository;
        }

        [HttpPost]
        [Route("SendMessage")]
        public IActionResult SendMessage([FromBody]Message message)
        {
            var response = _messageRepository.SaveMessage(message);
            return Ok(response);
        }

        [HttpGet]
        [Route("GetSpecificMessage/{id}")]
        public IActionResult GetSpecificMessage(int id)
        {
            var message = _messageRepository.GetSpecificMessage(id);
            return Ok(message);
        }

        [HttpGet]
        [Route("GetLastMessage")]
        public IActionResult GetLastMessage()
        {
            var message = _messageRepository.GetLastMessage();
            return Ok(message);
        }
    }
}

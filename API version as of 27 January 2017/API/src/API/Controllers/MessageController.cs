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
            Message savedMessage = _messageRepository.SendMessage(message);

            return Ok(savedMessage);
        }

        [HttpPost]
        [Route("GetMessage")]
        public IActionResult GetMessage([FromBody]Object input)
        {
            dynamic data = input;
            string id = data.id.ToString();

            Guid guidInput = Helper.ConvertStringToGuid(id);

            Message message = _messageRepository.GetMessage(guidInput);

            return Ok(message);
        }
    }
}

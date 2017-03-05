using Microsoft.AspNetCore.Mvc;
using System;
using API.Helpers;
using API.Models;
using API.Repository.MessageRepository;
using API.Repository.ChatRepository;
using System.Collections.Generic;

namespace API.Controllers
{
    [Route("api/[controller]")]
    public class ChatController : Controller
    {
        private readonly IChatRepository _chatRepository;

        public ChatController(IChatRepository chatRepository)
        {
            _chatRepository = chatRepository;
        }

        [HttpGet]
        [Route("GetChats")]
        public IActionResult GetChats()
        {
            List<Chat> response = _chatRepository.GetChats();
            return Ok(response);
        }

        [HttpGet]
        [Route("GetChatMessages/{id}")]
        public IActionResult GetChatMessages(int id)
        {
            List<MessageClass> response = _chatRepository.GetMessages(id);
            return Ok(response);
        }

        [HttpGet]
        [Route("GetUserMessages/{id}")]
        public IActionResult GetUserMessages(int id)
        {
            List<MessageClass> response = _chatRepository.GetUserMessages(id);
            return Ok(response);
        }

        [HttpGet]
        [Route("GetAllUserMessages/{id}")]
        public IActionResult GetAllUserMessages(int id)
        {
            List<MessageClass> response = _chatRepository.GetAllUserMessages(id);
            return Ok(response);
        }
    }
}

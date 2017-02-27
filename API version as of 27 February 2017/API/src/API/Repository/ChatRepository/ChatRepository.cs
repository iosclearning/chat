using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using API.Models;

namespace API.Repository.ChatRepository
{
    public class ChatRepository : IChatRepository
    {
        private readonly ServiceContext _serviceContext;

        public ChatRepository(ServiceContext serviceContext)
        {
            _serviceContext = serviceContext;
        }

        public List<Chat> GetChats()
        {
            List<Chat> chats = _serviceContext.Chats.OrderBy(c => c.CreatedDate).ToList();
            return chats;
        }

        public List<Message> GetMessages(int chatId)
        {
            List<Message> messages = _serviceContext.Messages.Where(m => m.ChatId == chatId).ToList();
            return messages;
        }

        public List<Message> GetUserMessages(int userId)
        {
            List<Message> messages = _serviceContext.Messages.Where(m => m.RecipientUserId == userId && !m.IsRead).ToList();
            return messages;
        }

        public List<Message> GetAllUserMessages(int userId)
        {
            List<Message> messages = _serviceContext.Messages.Where(m => m.RecipientUserId == userId).ToList();
            return messages;
        }
    }
}

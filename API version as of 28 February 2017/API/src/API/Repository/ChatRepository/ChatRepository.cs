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

        public List<MessageClass> GetMessages(int chatId)
        {
            List<MessageClass> messages = _serviceContext.Messages.Where(m => m.ChatId == chatId).ToList();
            return messages;
        }

        public List<MessageClass> GetUserMessages(int userId)
        {
            List<MessageClass> messages = _serviceContext.Messages.Where(m => m.UserIdFrom == userId).ToList();
            return messages;
        }

        public List<MessageClass> GetAllUserMessages(int userId)
        {
            List<MessageClass> messages = _serviceContext.Messages.Where(m => m.UserIdFrom == userId).ToList();
            return messages;
        }
    }
}

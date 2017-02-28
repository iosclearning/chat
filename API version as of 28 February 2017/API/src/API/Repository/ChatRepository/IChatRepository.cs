using API.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace API.Repository.ChatRepository
{
    public interface IChatRepository
    {
        List<Chat> GetChats();
        List<MessageClass> GetMessages(int chatId);
        List<MessageClass> GetUserMessages(int chatId);
        List<MessageClass> GetAllUserMessages(int chatId);
    }
}

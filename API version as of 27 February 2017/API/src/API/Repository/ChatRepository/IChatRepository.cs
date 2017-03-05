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
        List<Message> GetMessages(int chatId);
        List<Message> GetUserMessages(int chatId);
        List<Message> GetAllUserMessages(int chatId);
    }
}

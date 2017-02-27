using System;
using API.Models;

namespace API.Repository.MessageRepository
{
    public interface IMessageRepository
    {
        Boolean SaveMessage(Message message);
        Message GetSpecificMessage(int id);
        Message GetLastMessage();
    }
}

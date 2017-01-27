using System;
using API.Models;

namespace API.Repository.MessageRepository
{
    public interface IMessageRepository
    {
        Message SendMessage(Message message);
        Message GetMessage(Guid id);
    }
}

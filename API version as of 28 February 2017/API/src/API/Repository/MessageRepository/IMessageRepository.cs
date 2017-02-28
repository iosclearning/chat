using System;
using API.Models;

namespace API.Repository.MessageRepository
{
    public interface IMessageRepository
    {
        Boolean SaveMessage(MessageClass message);
        MessageClass GetSpecificMessage(int id);
        MessageClass GetLastMessage();
    }
}

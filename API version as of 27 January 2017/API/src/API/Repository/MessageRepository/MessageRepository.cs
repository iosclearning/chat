using System;
using System.Linq;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using API.Models;

namespace API.Repository.MessageRepository
{
    public class MessageRepository : IMessageRepository
    {
        private readonly ServiceContext _serviceContext;

        public MessageRepository(ServiceContext serviceContext)
        {
            _serviceContext = serviceContext;
        }

        public Message SendMessage(Message message)
        {
            Message response;

            if(message.Id == Guid.Empty)
            {
                message.Id = new Guid();
                response = SaveMessage(message);
            }
            else
            {
                response = UpdateMessage(message);
            }

            return response;
        }

        public Message GetMessage(Guid id)
        {
            try
            {
                Message message = _serviceContext.Messages.First(m => m.Id == id);

                return message;
            }
            catch (Exception exception)
            {
                throw new Exception("GetMessage method throw an exception", exception);
            }
        }

        private Message SaveMessage(Message message)
        {
            try
            {
                message.TimeReceived = DateTime.Now;

                EntityEntry<Message> savedMessage = _serviceContext.Messages.Add(message);

                _serviceContext.SaveChanges();

                return savedMessage.Entity;
            }
            catch (Exception exception)
            {
                throw new Exception("SaveMessage method throw an exception", exception);
            }
        }

        private Message UpdateMessage(Message message)
        {
            try
            {
                Message foundMessage = _serviceContext.Messages.First(m => m.Id == message.Id);

                foundMessage.TimeReceived = DateTime.Now;
                foundMessage.TimeSent = message.TimeSent;
                foundMessage.Content = message.Content;

                EntityEntry<Message> updatedMessage = _serviceContext.Messages.Update(foundMessage);

                _serviceContext.SaveChanges();

                return updatedMessage.Entity;
            }
            catch (Exception exception)
            {
                throw new Exception("UpdateMessage method throw an exception", exception);
            }
        }
    }
}

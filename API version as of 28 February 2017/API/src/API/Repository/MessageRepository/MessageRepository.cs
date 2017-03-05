﻿using System;
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

        public Boolean SaveMessage(MessageClass message)
        {
            message.SentTime = DateTime.Now;
            var response = _serviceContext.Messages.Add(message);
            _serviceContext.SaveChanges();
            return response.IsKeySet;
        }

        public MessageClass GetSpecificMessage(int id)
        {
            var message = _serviceContext.Messages.FirstOrDefault(m => m.Id == id);
            return message;
        }

        public MessageClass GetLastMessage()
        {
            var message = _serviceContext.Messages.OrderByDescending(m => m.SentTime).FirstOrDefault();
            return message;
        }
    }
}

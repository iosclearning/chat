using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using API.Models;

namespace API.Repository.ContactListRepository
{
    public class ContactListRepository : IContactListRepository
    {
        private readonly ServiceContext _serviceContext;

        public ContactListRepository(ServiceContext serviceContext)
        {
            _serviceContext = serviceContext;
        }
    }
}

using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using API.Helpers;
using API.Models;
using API.Repository.ContactListRepository;

namespace API.Controllers
{
    [Route("api/[controller]")]
    public class ContactListController : Controller
    {
        private readonly IContactListRepository _contactListRepository;

        public ContactListController(IContactListRepository contactListRepository)
        {
            _contactListRepository = contactListRepository;
        }
    }
}

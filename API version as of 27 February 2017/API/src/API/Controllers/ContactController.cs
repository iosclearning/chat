using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using API.Helpers;
using API.Models;
using API.Repository.ContactRepository;

namespace API.Controllers
{
    [Route("api/[controller]")]
    public class ContactController : Controller
    {
        private readonly IContactRepository _contactRepository;

        public ContactController(IContactRepository contactRepository)
        {
            _contactRepository = contactRepository;
        }

        [HttpPost]
        [Route("SaveContact")]
        public IActionResult SaveContact([FromBody]Contact input)
        {
            Contact contact = _contactRepository.SaveContact(input);

            return Ok(contact);
        }

        [HttpPut]
        [Route("UpdateContact")]
        public IActionResult UpdateContact([FromBody]Contact input)
        {
            Contact contact = _contactRepository.UpdateContact(input);

            return Ok(contact);
        }

        [HttpPost]
        [Route("DeleteContact")]
        public IActionResult DeleteContact([FromBody]Object input)
        {
            dynamic data = input;
            string id = data.id.ToString();

            Guid guidInput = Helper.ConvertStringToGuid(id);

            GuidObject guid = _contactRepository.DeleteContact(guidInput);

            return Ok(guid);
        }

        [HttpGet]
        [Route("GetAllContacts")]
        public IActionResult GetAllContacts()
        {
            List<Contact> contacts = _contactRepository.GetAllContacts();

            return Ok(contacts);
        }

        [HttpPost]
        [Route("GetContact")]
        public IActionResult GetContact([FromBody]Object input)
        {
            dynamic data = input;
            string id = data.id.ToString();

            Guid guidInput = Helper.ConvertStringToGuid(id);

            Contact contact = _contactRepository.GetContact(guidInput);

            return Ok(contact);
        }
    }
}

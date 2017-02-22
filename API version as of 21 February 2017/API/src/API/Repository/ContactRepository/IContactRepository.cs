using System;
using System.Collections.Generic;
using API.Models;

namespace API.Repository.ContactRepository
{
    public interface IContactRepository
    {
        Contact SaveContact(Contact contact);
        Contact UpdateContact(Contact contact);
        GuidObject DeleteContact(Guid id);
        List<Contact> GetAllContacts();
        Contact GetContact(Guid id);
    }
}

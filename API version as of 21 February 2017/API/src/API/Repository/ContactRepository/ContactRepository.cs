using System;
using System.Collections.Generic;
using System.Linq;
using API.Models;

namespace API.Repository.ContactRepository
{
    public class ContactRepository : IContactRepository
    {
        private readonly ServiceContext _serviceContext;

        public ContactRepository(ServiceContext serviceContext)
        {
            _serviceContext = serviceContext;
        }

        public Contact SaveContact(Contact contact)
        {
            try
            {
                contact.Id = Guid.NewGuid();

                _serviceContext.Contacts.Add(contact);
                _serviceContext.SaveChanges();

                return contact;
            }
            catch (Exception exception)
            {

                throw new Exception("SaveContact method throw an exception", exception);
            }
        }

        public Contact UpdateContact(Contact contact)
        {
            try
            {
                Contact modifiedContact = _serviceContext.Contacts.First(c => c.Id == contact.Id);

                modifiedContact.Name = contact.Name;
                modifiedContact.Surname = contact.Surname;
                modifiedContact.ImagePath = contact.ImagePath;
                modifiedContact.Address = contact.Address;
                modifiedContact.PhoneNumber = contact.PhoneNumber;
                modifiedContact.Email = contact.Email;

                _serviceContext.Contacts.Update(modifiedContact);
                _serviceContext.SaveChanges();

                return modifiedContact;
            }
            catch (Exception exception)
            {
                throw new Exception("UpdateContact method throw an exception", exception);
            }
        }

        public GuidObject DeleteContact(Guid id)
        {
            try
            {
                Contact contact = _serviceContext.Contacts.First(c => c.Id == id);

                _serviceContext.Contacts.Remove(contact);

                _serviceContext.SaveChanges();

                GuidObject guid = new GuidObject();
                guid.Id = id;

                return guid;
            }
            catch (Exception exception)
            {
                throw new Exception("DeleteContact method throw an exception", exception);
            }
        }

        public List<Contact> GetAllContacts()
        {
            try
            {
                List<Contact> contacts = _serviceContext.Contacts.ToList();

                return contacts;
            }
            catch (Exception exception)
            {
                throw new Exception("GetAllContacts method throw an exception", exception);
            }
        }

        public Contact GetContact(Guid id)
        {
            try
            {
                Contact contact = _serviceContext.Contacts.First(c => c.Id == id);

                return contact;
            }
            catch (Exception exception)
            {
                throw new Exception("GetContact method throw an exception", exception);
            }
        }
    }
}

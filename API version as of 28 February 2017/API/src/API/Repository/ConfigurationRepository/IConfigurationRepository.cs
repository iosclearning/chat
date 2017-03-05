using System;
using API.Models;


namespace API.Repository.ConfigurationRepository
{
    public interface IConfigurationRepository
    {
        Configuration GetConfigurationById(Guid id);
    }
}

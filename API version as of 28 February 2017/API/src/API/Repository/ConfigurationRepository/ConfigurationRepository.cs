using System;
using System.Linq;
using API.Models;

namespace API.Repository.ConfigurationRepository
{
    public class ConfigurationRepository : IConfigurationRepository
    {
        private readonly ServiceContext _serviceContext;

        public ConfigurationRepository(ServiceContext serviceContext)
        {
            _serviceContext = serviceContext;
        }

        Configuration IConfigurationRepository.GetConfigurationById(Guid id)
        {
            try
            {
                Configuration configuration = _serviceContext.Configurations.First(c => c.id == id);

                return configuration;
            }
            catch (Exception exception)
            {
                throw new Exception("GetConfigurationById method throw an exception", exception);
            }
        }
    }
}

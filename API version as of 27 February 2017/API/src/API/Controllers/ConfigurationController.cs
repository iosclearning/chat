using Microsoft.AspNetCore.Mvc;
using System;
using API.Helpers;
using API.Models;
using API.Repository.ConfigurationRepository;

namespace API.Controllers
{
    [Route("api/[controller]")]
    public class ConfigurationController : Controller
    {
        private readonly IConfigurationRepository _configurationRepository;

        public ConfigurationController(IConfigurationRepository configurationRepository)
        {
            _configurationRepository = configurationRepository;
        }

        [HttpPost]
        [Route("GetConfigurationById")]
        public IActionResult GetConfigurationById([FromBody]Object input)
        {
            dynamic data = input;
            string id = data.id.ToString();

            Guid guid = Helper.ConvertStringToGuid(id);

            Configuration configuration = _configurationRepository.GetConfigurationById(guid);

            return Ok(configuration);
        }
    }
}

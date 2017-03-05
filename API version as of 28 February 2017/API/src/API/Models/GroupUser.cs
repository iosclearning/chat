using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace API.Models
{
    [Table("GroupUser")]
    public class GroupUser
    {
        [Key]
        public int id { get; set; }
        public int UserIdParticipant { get; set; }
        public int ChatId { get; set; }
    }
}

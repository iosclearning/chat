using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace API.Models
{
    [Table("MessageState")]
    public class MessageState
    {
        [Key]
        public int Id { get; set; }
        public DateTime ReceivedTime { get; set; }
        public int Status { get; set; }
        public bool Seen { get; set; }
        public DateTime SeenTime { get; set; }
        public int UserId { get; set; }
        public int MessageId { get; set; }
    }
}

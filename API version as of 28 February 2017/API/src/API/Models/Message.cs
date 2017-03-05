using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace API.Models
{
    [Table("Messages")]
    public class MessageClass
    {
        [Key]
        public int Id { get; set; }
        public int UserIdFrom { get; set; }
        public DateTime? SentTime { get; set; }
        public string Message { get; set; }
        public byte[] Media { get; set; }
        public int? ChatId { get; set; }
        public string ReplyMessage { get; set; }
    }
}

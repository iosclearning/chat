using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace API.Models
{
    [Table("Messages")]
    public class Message
    {
        [Key]
        public int Id { get; set; }
        public int userIdFrom { get; set; }
        public DateTime? SentTime { get; set; }
        public string MessageContent { get; set; }
        public int? ChatId { get; set; }
        public string ReplyMessage { get; set; }
        public DateTime? ReplyTime { get; set; }
        public bool IsRead { get; set; }
    }
}

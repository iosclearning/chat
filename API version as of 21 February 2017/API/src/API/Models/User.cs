using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace API.Models
{
    [Table("User")]
    public class User
    {
        [Key]
        public int Id { get; set; }
        public int? SocialId { get; set; }
        public int SocialType { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public bool? HideMe { get; set; }
        public int? Sex { get; set; }
        public DateTime? BirthDate { get; set; }
        public int? Status { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string AccessToken { get; set; }
    }
}

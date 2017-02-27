﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace API.Models
{
    public class Chat
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
        public bool? IsGroup { get; set; }
        public DateTime? CreatedDate { get; set; }
    }
}

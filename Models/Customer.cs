using System;
using System.Collections.Generic;

namespace Meteoros.Assignment.API.Models
{
    public partial class Customer
    {
        public int Id { get; set; }
        public string CustomerName { get; set; } = null!;
        public string PhoneNumber { get; set; } = null!;
    }
}

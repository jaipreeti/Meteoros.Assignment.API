using System;
using System.Collections.Generic;

namespace Meteoros.Assignment.API.Models
{
    public partial class Sale
    {
        public Guid SalesId { get; set; }
        public int CustomerId { get; set; }
        public int ProductId { get; set; }
        public double SalesPrice { get; set; }
        public DateTime SalesDate { get; set; }
    }
}

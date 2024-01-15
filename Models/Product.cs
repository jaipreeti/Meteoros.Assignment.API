﻿using System;
using System.Collections.Generic;

namespace Meteoros.Assignment.API.Models
{
    public partial class Product
    {
        public int? Id { get; set; }
        public string Name { get; set; } = null!;
        public string? Description { get; set; }
        public double? Price { get; set; }
        public double? Discount { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Meteoros.Assignment.API.Models;
using System.Net;

namespace Meteoros.Assignment.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomersController : ControllerBase
    {
        private readonly METEOROS_AssignmentDBContext _context;

        public CustomersController(METEOROS_AssignmentDBContext context)
        {
            _context = context;
        }

        // GET: api/Customers
        [HttpGet]
        public async Task<ActionResult> GetCustomers()
        {
            if (_context.Customers == null)
            {
                return NotFound();
            }
            var data = _context.Customers.ToList();
            data.ForEach(x => x.PhoneNumber = MaskMobileNumber(x.PhoneNumber));
            return Ok(data);
        }

        // GET: api/GetCustomersforDropdown
        [HttpGet("GetCustomersforDropdown")]
        public async Task<ActionResult> GetCustomersforDropdown()
        {
            if (_context.Products == null)
            {
                return NotFound();
            }
            var customers = _context.Customers.ToList();
            return Ok(customers);

        }

        private string MaskMobileNumber(string input)
        {
            try
            {
                string firstPart = input.Substring(0, 8);
                int len = input.Length;
                string lastPart = input.Substring(len - 2, 2);
                string middlePart = new String('X', 8);
                return middlePart + lastPart;
            }
            catch (Exception)
            {
                return input;
            }

        }



        // POST: api/Customers
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Customer>> PostCustomer(Customer customer)
        {
            if (_context.Customers == null)
            {
                return Problem("Entity set 'METEOROS_AssignmentDBContext.Customers'  is null.");
            }
            _context.Customers.Add(customer);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCustomer", new { id = customer.Id }, customer);
        }

        private bool CustomerExists(int id)
        {
            return (_context.Customers?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}

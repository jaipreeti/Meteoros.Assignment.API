using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Meteoros.Assignment.API.Models;
using static NuGet.Packaging.PackagingConstants;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace Meteoros.Assignment.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SalesController : ControllerBase
    {
        private readonly METEOROS_AssignmentDBContext _context;

        public SalesController(METEOROS_AssignmentDBContext context)
        {
            _context = context;
        }

        // GET: api/Sales
        [HttpGet]
        public async Task<ActionResult> GetSales()
        {
            if (_context.Sales == null)
            {
                return NotFound();
            }
            var salesData = _context.Sales.ToList();
            var cusData = _context.Customers.ToList();
            var products = _context.Products.ToList();
            var res = from s in salesData
                      join c in cusData on s.CustomerId equals c.Id
                      join p in products on s.ProductId equals p.Id
                      select new
                      {
                          customerName = c.CustomerName,
                          productName = p.Name,
                          salesPrice = s.SalesPrice,
                          salesDate = s.SalesDate
                      };
            return Ok(res);
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
        // GET: api/Sales/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Sale>> GetSale(Guid id)
        {
            if (_context.Sales == null)
            {
                return NotFound();
            }
            var sale = await _context.Sales.FindAsync(id);

            if (sale == null)
            {
                return NotFound();
            }

            return sale;
        }

        // POST: api/Sales
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Sale>> PostSale(Sale sale)
        {
            if (_context.Sales == null)
            {
                return Problem("Entity set 'METEOROS_AssignmentDBContext.Sales'  is null.");
            }
            sale.SalesId = Guid.NewGuid();
            sale.SalesDate = DateTime.UtcNow;
            _context.Sales.Add(sale);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (SaleExists(sale.SalesId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetSale", new { id = sale.SalesId }, sale);
        }

        // GET: api/GetProductCustomer
        [HttpGet("GetProductCustomer")]
        public async Task<ActionResult> GetProductCustomer()
        {

            var res = _context.Sales
             .AsEnumerable()
             .GroupBy(x => x.CustomerId)
             .Join(
         inner: _context.Customers,
         outerKeySelector: s => s.Key,
         innerKeySelector: c => c.Id,
         resultSelector: (s, c) => new
         {
             customerName = c.CustomerName,
             phoneNumber = MaskMobileNumber(c.PhoneNumber)
         });
            return Ok(res);

        }
        // GET: api/GetLastSalesCustomer
        [HttpGet("GetLastSalesCustomer")]
        public async Task<ActionResult> GetLastSalesCustomer()
        {
            var salesData = _context.Sales
                .OrderByDescending(x => x.SalesDate)
                .Take(1)
                .ToList();
            var cusData = _context.Customers.ToList();
            var res = from s in salesData
                      join c in cusData on s.CustomerId equals c.Id
                      select new
                      {
                          customerName = c.CustomerName,
                          phoneNumber = MaskMobileNumber(c.PhoneNumber)
                      };
            //foreach(var item in res)
            //{
            //    string firstTwoDigits = item.phoneNumber.Substring(0, 2);
            //    string lastTwoDigits = item.phoneNumber.Substring(item.phoneNumber.Length - 2, 2);

            //    // Mask the middle digits
            //    string maskedMiddle = new string('*', item.phoneNumber.Length - 4);

            //    // Concatenate the parts to form the masked number
            //    string maskedNumber = $"{firstTwoDigits}{maskedMiddle}{lastTwoDigits}";
            //    item.phoneNumber = maskedNumber.ToString();
            //}
            return Ok(res);

        }

        private bool SaleExists(Guid id)
        {
            return (_context.Sales?.Any(e => e.SalesId == id)).GetValueOrDefault();
        }
    }
}

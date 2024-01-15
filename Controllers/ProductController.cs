using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Meteoros.Assignment.API.Models;
using System.Runtime.InteropServices;

namespace Meteoros.Assignment.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly METEOROS_AssignmentDBContext _context;

        public ProductController(METEOROS_AssignmentDBContext context)
        {
            _context = context;
        }

        // GET: api/GetProductsforDropdown
        [HttpGet("GetProductsforDropdown")]
        public async Task<ActionResult> GetProductsforDropdown()
        {
            if (_context.Products == null)
            {
                return NotFound();
            }
            var products = _context.Products.ToList();
            return Ok(products);

        }

        // GET: api/Product
        [HttpGet]
        public async Task<ActionResult> GetProducts()
        {
            if (_context.Products == null)
            {
                return NotFound();
            }
            var Top10product = _context.Sales
                 .GroupBy(sale => sale.ProductId)
                 .Select(groupedSales => new
                 {
                     ProductId = groupedSales.Key,
                     TotalSalesPrice = groupedSales.Sum(s => s.SalesPrice)
                 })
                 .OrderByDescending(result => result.TotalSalesPrice)
                 .Take(10)
                 .Join(
                     inner: _context.Products.AsEnumerable(), // Bring Products into memory
                     outerKeySelector: result => result.ProductId,
                     innerKeySelector: product => product.Id,
                     resultSelector: (result, product) => new
                     {
                         ProductId = result.ProductId,
                         ProductName = product.Name,
                         Description = product.Description,
                         Price = product.Price,
                         Discount = product.Discount
                     })?
                 .ToList();

            return Ok(Top10product);
            //return top10Products
        }

        // GET: api/Product/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Product>> GetProduct(int id)
        {
            if (_context.Products == null)
            {
                return NotFound();
            }
            var product = await _context.Products.FindAsync(id);

            if (product == null)
            {
                return NotFound();
            }

            return product;
        }

        [HttpPost]
        public async Task<ActionResult<Product>> PostProduct(Product product)
        {
            if (_context.Products == null)
            {
                return Problem("Entity set 'METEOROS_AssignmentDBContext.Products'  is null.");
            }
            //product.Id=Guid.NewGuid().ToString;
            _context.Products.Add(product);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetProduct", new { id = product.Id }, product);
        }

    }
}

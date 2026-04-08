# Part 3 Text

# Handle Edge Cases
- No sales → ignored
- Division by zero avoided
- Multiple warehouses handled
- Missing supplier → (could extend with LEFT JOIN)
- Large datasets → can optimize with aggregation queries

  ## Explanation

  The low-stock alerts endpoint works by identifying products across all warehouses of a given company that are at risk of running out of inventory based on recent sales activity. First, the system defines what qualifies as “recent” (assumed to be the last 30 days) and retrieves all relevant product, inventory, warehouse, and supplier data using joined queries to minimize database calls and avoid performance issues like the N+1 problem. For each product-warehouse combination, the system calculates total sales within this time window and derives an average daily sales rate, which represents how quickly the product is being consumed. Products with no recent sales are ignored, as they do not require immediate restocking attention. The current inventory level is then compared against a predefined low-stock threshold for each product. If the stock falls below this threshold, the system flags it as a low-stock alert. Additionally, it estimates the number of days until stock depletion by dividing current stock by the average daily sales rate, providing actionable insight for restocking decisions. Supplier information is included in the response to facilitate quick reordering. The final response aggregates all such alerts along with a total count. This approach ensures that alerts are meaningful (based on actual demand), scalable (through optimized queries), and useful for business operations by combining inventory status with supplier context.

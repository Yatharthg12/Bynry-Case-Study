from datetime import datetime, timedelta
from sqlalchemy import func

@app.route('/api/companies/<int:company_id>/alerts/low-stock', methods=['GET'])
def low_stock_alerts(company_id):
    recent_days = 30
    cutoff_date = datetime.utcnow() - timedelta(days=recent_days)

    alerts = []

    # Query inventory + product + warehouse + supplier
    results = db.session.query(
        Product.id,
        Product.name,
        Product.sku,
        Warehouse.id,
        Warehouse.name,
        Inventory.quantity,
        Product.low_stock_threshold,
        Supplier.id,
        Supplier.name,
        Supplier.contact_email
    ).join(Inventory, Product.id == Inventory.product_id)\
     .join(Warehouse, Inventory.warehouse_id == Warehouse.id)\
     .join(product_suppliers, product_suppliers.c.product_id == Product.id)\
     .join(Supplier, Supplier.id == product_suppliers.c.supplier_id)\
     .filter(Warehouse.company_id == company_id)\
     .all()

    for row in results:
        product_id = row[0]
        warehouse_id = row[3]

        # Get avg daily sales
        sales = db.session.query(
            func.sum(Sale.quantity)
        ).filter(
            Sale.product_id == product_id,
            Sale.warehouse_id == warehouse_id,
            Sale.created_at >= cutoff_date
        ).scalar() or 0

        avg_daily_sales = sales / recent_days if sales > 0 else 0

        # Skip if no recent sales
        if avg_daily_sales == 0:
            continue

        current_stock = row[5]
        threshold = row[6]

        if current_stock < threshold:
            days_until_stockout = int(current_stock / avg_daily_sales) if avg_daily_sales else None

            alerts.append({
                "product_id": product_id,
                "product_name": row[1],
                "sku": row[2],
                "warehouse_id": warehouse_id,
                "warehouse_name": row[4],
                "current_stock": current_stock,
                "threshold": threshold,
                "days_until_stockout": days_until_stockout,
                "supplier": {
                    "id": row[7],
                    "name": row[8],
                    "contact_email": row[9]
                }
            })

    return {
        "alerts": alerts,
        "total_alerts": len(alerts)
    }

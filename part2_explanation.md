# Remaining Part-2

## Missing Requirements

- Should SKU be global or per company?
- Can a product have multiple suppliers or priority supplier?
- What would you definerecent sale as?
- Do bundles reduce inventory automatically?
- Should inventory logs include user/action source?
- Can warehouses transfer stock between each other?

## Design Decisions

- UNIQUE(product_id, warehouse_id) → prevents duplicate inventory rows
- Inventory logs → audit + analytics
- Join tables (many-to-many) → scalable supplier model
- Bundle table → flexible composition system
- Indexes (implicit via PK/unique) → fast queries

CREATE TABLE companies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE warehouses (
    id SERIAL PRIMARY KEY,
    company_id INT REFERENCES companies(id),
    name VARCHAR(255),
    location TEXT
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    company_id INT REFERENCES companies(id),
    name VARCHAR(255),
    sku VARCHAR(100) UNIQUE NOT NULL,
    price DECIMAL(10,2),
    is_bundle BOOLEAN DEFAULT FALSE
);

CREATE TABLE inventory (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(id),
    warehouse_id INT REFERENCES warehouses(id),
    quantity INT DEFAULT 0,
    UNIQUE(product_id, warehouse_id)
);

CREATE TABLE inventory_logs (
    id SERIAL PRIMARY KEY,
    product_id INT,
    warehouse_id INT,
    change INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE suppliers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    contact_email VARCHAR(255)
);

CREATE TABLE product_suppliers (
    product_id INT REFERENCES products(id),
    supplier_id INT REFERENCES suppliers(id),
    PRIMARY KEY (product_id, supplier_id)
);

CREATE TABLE product_bundles (
    bundle_id INT REFERENCES products(id),
    component_id INT REFERENCES products(id),
    quantity INT,
    PRIMARY KEY (bundle_id, component_id)
);

CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    product_id INT,
    warehouse_id INT,
    quantity INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

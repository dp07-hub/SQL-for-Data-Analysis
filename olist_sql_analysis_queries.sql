
-- 1. SELECT, WHERE, ORDER BY, GROUP BY
SELECT 
    product_id, 
    COUNT(order_id) AS total_orders
FROM 
    order_items
GROUP BY 
    product_id
ORDER BY 
    total_orders DESC
LIMIT 10;

-- 2. INNER JOIN: Customer and Orders
SELECT 
    c.customer_unique_id, 
    o.order_id, 
    o.order_status
FROM 
    customers c
INNER JOIN 
    orders o ON c.customer_id = o.customer_id
LIMIT 10;

-- 3. LEFT JOIN: Orders with or without reviews
SELECT 
    o.order_id, 
    r.review_score
FROM 
    orders o
LEFT JOIN 
    order_reviews r ON o.order_id = r.order_id
LIMIT 10;

-- 4. SUBQUERY: Avg delivery time by seller
SELECT 
    seller_id,
    AVG(JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_approved_at)) AS avg_delivery_days
FROM 
    order_items oi
JOIN 
    orders o ON oi.order_id = o.order_id
WHERE 
    order_delivered_customer_date IS NOT NULL
GROUP BY 
    seller_id
LIMIT 10;

-- 5. AGGREGATE FUNCTION: Avg review per product
SELECT 
    oi.product_id, 
    AVG(r.review_score) AS avg_score
FROM 
    order_items oi
JOIN 
    order_reviews r ON oi.order_id = r.order_id
GROUP BY 
    oi.product_id
ORDER BY 
    avg_score DESC
LIMIT 10;

-- 6. CREATE VIEW: Top 20 sellers
CREATE VIEW top_20_sellers AS
SELECT 
    seller_id, 
    COUNT(order_id) AS total_orders
FROM 
    order_items
GROUP BY 
    seller_id
ORDER BY 
    total_orders DESC
LIMIT 20;

-- 7. INDEX OPTIMIZATION: Create index on customer_id
CREATE INDEX idx_customer_id ON orders(customer_id);

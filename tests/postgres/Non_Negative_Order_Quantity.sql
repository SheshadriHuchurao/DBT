-- Return invalid rows: any returned row makes the test fail.

SELECT
    order_id,
    product_id,
    quantity
FROM {{ ref('fact_fact__order_items') }}
WHERE order_id <= 0 
   OR quantity <= 0
   OR order_id IS NULL
   OR quantity IS NULL
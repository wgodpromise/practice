CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0) -- Количество на складе
);

CREATE TABLE order_history (
    log_id SERIAL PRIMARY KEY,
    product_id INT,
    quantity_changed INT,
    notes VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO products (product_id, name, quantity) VALUES
(1, 'Ноутбук', 20),
(2, 'Смартфон', 50);

BEGIN;

UPDATE products SET quantity = quantity - 5 WHERE product_id = 1;

INSERT INTO order_history (product_id, quantity_changed, notes) VALUES
(1, -5, 'уменьшение кол-ва')

COMMIT;

BEGIN;

UPDATE products SET quantity = quantity -100 WHERE product_id = 2;

INSERT INTO order_history (product_id, quantity_changed, notes) VALUES (2, -100, 'продажа 100 айфонов');

COMMIT;

SELECT * FROM products;
SELECT * FROM order_history;

BEGIN;

UPDATE products SET quantity = quantity - 2 WHERE product_id = 1;

ROLLBACK;

COMMIT;


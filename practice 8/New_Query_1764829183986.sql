CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE NOT NULL,
    recommended_by INT,
    FOREIGN KEY (recommended_by) REFERENCES Customers(customer_id)
);

-- Создание таблицы Товаров
CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Создание таблицы Заказов
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Создание таблицы Состава Заказа
CREATE TABLE Order_Items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Наполнение таблиц данными
INSERT INTO Customers (customer_id, full_name, email, registration_date, recommended_by) VALUES
(1, 'Иван Иванов', 'ivan.ivanov@example.com', '2023-01-15', NULL),
(2, 'Мария Петрова', 'maria.petrova@example.com', '2023-02-20', 1),
(3, 'Алексей Смирнов', 'alex.smirnov@example.com', '2023-03-10', 1),
(4, 'Елена Васильева', 'elena.v@example.com', '2023-04-01', 2),
(5, 'Андрей Николаев', 'andrey.n@example.com', '2023-05-01', NULL);

INSERT INTO Products (product_name, category, price) VALUES
('Смартфон', 'Электроника', 70000.00),
('Ноутбук', 'Электроника', 120000.00),
('Кофемашина', 'Бытовая техника', 25000.00),
('Книга "Основы SQL"', 'Книги', 1500.00),
('Фен', 'Бытовая техника', 4500.00),
('Пылесос', 'Бытовая техника', 15000.00);

INSERT INTO Orders (customer_id, order_date, status) VALUES
(1, '2024-05-10', 'Доставлен'),
(2, '2024-05-12', 'В обработке'),
(1, '2024-05-15', 'Отправлен'),
(3, '2024-05-16', 'Доставлен');

INSERT INTO Order_Items (order_id, product_id, quantity, price_per_unit) VALUES
(1, 1, 1, 70000.00),  -- Иван купил Смартфон
(1, 4, 2, 1400.00),   -- и 2 книги
(2, 2, 1, 120000.00), -- Мария купила Ноутбук
(3, 3, 1, 25000.00),  -- Иван купил Кофемашину
(4, 1, 1, 70000.00),  -- Алексей купил Смартфон
(4, 5, 1, 4500.00);   -- и Фен

SELECT 
    c.full_name,
    o.order_date
FROM customers c
JOIN orders O ON c.customer_id = o.customer_id;

SELECT c.full_name,
o.order_id
FROM customers c
LEFT JOIN orders o ON o.order_id = NULL;

SELECT 
o.order_id,
p.product_name,
oi.quantity,
oi.price_per_unit
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id 
WHERE o.order_id = 1;

SELECT full_name
FROM customers
WHERE customer_id IN (
    SELECT o.customer_id
    FROM orders o 
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p on oi.product_id = p.product_id
    WHERE p.product_id = '1'
);

SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

SELECT order_id, order_date
FROM orders o
WHERE EXISTS (
    SELECT 1
    FROM order_items oi 
    JOIN products p ON oi.product_id = p.product_id
    WHERE oi.order_id = o.order_id  AND p.price > 100000
);

SELECT DISTINCT
c.full_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN products p ON p.product_id = oi.order_id AND p.product_name = 'Ноутбук'
WHERE p.product_id is NULL

SELECT 
full_name
FROM customers c 
WHERE customer_id NOT IN (
    SELECT DISTINCT o.customer_id
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE p.product_name = 'Ноутбук'
);

SELECT p.product_name, oi.product_id
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL

SELECT c.full_name, p.product_name, o.order_date
FROM customers c
FULL OUTER JOIN orders o on c.customer_id = o.customer_id
FULL OUTER JOIN order_items oi ON o.order_id = oi.order_id
FULL OUTER JOIN products p ON p.product_id = oi.product_id

SELECT DISTINCT c.full_name, price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE p.price > (select max(price) from products);


SELECT c.full_name from products p
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE p.price = (
    SELECT max(price) FROM products
);


select * from products p
WHERE p.product_id IN (SELECT p.product_id FROM order_items
WHERE order_id IN (SELECT order_id FROM orders
WHERE customer_id IN (SELECT customer_id FROM orders
WHERE p.price = (SELECT max(price) FROM products)))
);

SELECT c.full_name,
p.category
from customers c
CROSS JOIN products p;

SELECT
    recommender.full_name AS recommended_by,
    customer.full_name AS new_customer
FROM Customers customer
JOIN Customers recommender ON customer.recommended_by = recommender.customer_id;
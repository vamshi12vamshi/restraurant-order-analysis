use restraunt;
SELECT * FROM order_details;

ALTER TABLE order_details
RENAME COLUMN ï»¿order_details_id TO order_detail_id;

-- 1 View the order_details table
SELECT *
FROM order_details

-- 2 What is the date range of table

SELECT MIN(order_date) as min_date,MAX(order_date) AS max_date
FROM order_details; 


-- 3 How many orders were made within the date range
SELECT  COUNT(DISTINCT order_id) AS orders_made
FROM order_details;


-- 4 How many items were made withis this date range
SELECT order_date,COUNT(order_id) no_of_items
FROM order_details
GROUP BY order_date;

-- 5 Which order has most number of items
SELECT order_id,COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;

-- 6 How many orders has more than 12 items
SELECT COUNT(*) AS row_orders
FROM
(SELECT order_id,COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
HAVING num_items>12) AS num_orders;


   -- menu_items table
-- 7. View the menu_items on the menu.
SELECT * 
FROM menu_items;

-- 8.Find the number of items on the menu
SELECT COUNT(*) as no_of_items
FROM menu_items;


-- 9. what are the least and most expensive items on the menu
-- most expensive item
SELECT *
FROM menu_items
ORDER BY price DESC
LIMIT 1;

-- Least expensive item
SELECT *
FROM menu_items
ORDER BY price ASC
LIMIT 1;
-- 10 How many Italian Dishes are their in menu
SELECT COUNT(*) AS italian_dishes
FROM menu_items
WHERE category="Italian";

-- 11 what are the least and most expensive Italian Dishes are their in menu

# Most expensive italian dishes in menu
SELECT *
FROM menu_items
WHERE category ="Italian"
ORDER BY price DESC
LIMIT 1;

# Least expensive italian dishes in menu
SELECT *
FROM menu_items
WHERE category ="Italian"
ORDER BY price ASC
LIMIT 1;

-- 12 How many dishes are there in each category
SELECT category,COUNT(*) no_of_dishes
FROM menu_items
GROUP BY category;

-- 13 What is the average dishes price per each category
SELECT category,AVG(price) as avg_price
FROM menu_items
GROUP BY category;


-- 14 Combine the menu_item and order_details into a single table
SELECT *
FROM menu_items;

SELECT *
FROM order_details;

SELECT *
FROM order_details
LEFT JOIN menu_items
ON order_details.item_id=menu_items.menu_item_id;


-- 15 What were the Least and most ordered items and what categories were they in ?

-- Least ordered itema
SELECT menu_items.category,menu_items.item_name,COUNT(order_details.order_detail_id) as num_purchases
FROM order_details
LEFT JOIN menu_items
ON order_details.item_id=menu_items.menu_item_id
GROUP BY menu_items.item_name,menu_items.category
ORDER BY num_purchases ASC
LIMIT 1;

-- most ordered itema
SELECT menu_items.category,menu_items.item_name,COUNT(order_details.order_detail_id) as num_purchases
FROM order_details
LEFT JOIN menu_items
ON order_details.item_id=menu_items.menu_item_id
GROUP BY menu_items.item_name,menu_items.category
ORDER BY num_purchases DESC
LIMIT 1;


-- 16 What were the top 5 orders that spent more money
SELECT order_details.order_id,ROUND(SUM(menu_items.price),2) AS money_spent
FROM order_details
LEFT JOIN menu_items
ON order_details.item_id=menu_items.menu_item_id
GROUP BY order_details.order_id
ORDER BY money_spent DESC
LIMIT 5;
 
-- 17 View the details of highest spend order.what insights can you gather from the
SELECT menu_items.category,COUNT(order_details.item_id) AS num_items
FROM order_details
LEFT JOIN menu_items
ON order_details.item_id=menu_items.menu_item_id
WHERE order_details.order_id=440
GROUP BY menu_items.category
ORDER BY num_items DESC;

-- 18 View the details of top 5 highest spend orders.what insghits can you gather
SELECT order_details.order_id,menu_items.category,COUNT(order_details.item_id) AS num_items
FROM order_details
LEFT JOIN menu_items
ON order_details.item_id=menu_items.menu_item_id
WHERE order_details.order_id IN ( '440','2075','1957','330','2675')
GROUP BY order_details.order_id,menu_items.category;



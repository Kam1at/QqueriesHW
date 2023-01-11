SELECT contact_name, country							--contact_name, country из таблицы customers
FROM customers

SELECT order_id, shipped_date - order_date as days		--идентификатор заказа и разница между датами формирования
FROM orders												--заказа и его отгрузкой из таблицы orders

SELECT DISTINCT city 									--все города без повторов, в которых
FROM customers											--зарегестрированы заказчики

SELECT COUNT(*) FROM orders								--количество заказов

SELECT COUNT(DISTINCT ship_country) FROM orders			--количество стран, в которые откружался товар

SELECT order_id, ship_country							--заказы, доставленные в страны France, Germany, Spain
FROM orders
WHERE ship_country IN ('France', 'Germany', 'Spain')

SELECT DISTINCT ship_country, ship_city					--уникальные города и страны, куда отправлялись заказы
FROM orders												--отсортированы по странам и городам
ORDER BY ship_country, ship_city

SELECT AVG(shipped_date - order_date)					--сколько дней в среднем уходит на доставку
FROM orders												--товара в Германию
WHERE ship_country = 'Germany'

SELECT MIN(unit_price), MAX(unit_price)					--минимальная и максимальная цена среди продуктов
FROM products											--не снятых с продажи
WHERE discontinued <> 1

SELECT MIN(unit_price), MAX(unit_price)					--минимальная и максимальная цена среди продуктов
FROM products											--не снятых с продажи и которых имеется не меньше 20
WHERE discontinued <> 1 
AND units_in_stock >= 20

SELECT DISTINCT ship_city, ship_country					--заказы, отправленные в города, заканчивающиеся на 'burg'
FROM orders												--вывести без повторений две колонки (город, страна)
WHERE ship_city LIKE '%burg'

SELECT order_id, customer_id, freight, ship_country		--из таблицы orders идентификатор заказа, идентификатор заказчика,
FROM orders												--вес и страну отгузки. Заказ откружен в страны, начинающиеся на 'P'.
WHERE ship_country LIKE 'P%'							--Результат отсортирован по весу (по убыванию). Вывести первые 10 записей.
ORDER BY freight DESC
LIMIT 10

SELECT last_name, home_phone							--фамилия и телефон сотрудников, у которых в данных отсутствует регион
FROM employees
WHERE region IS NULL

SELECT country, COUNT(*)								--количество поставщиков (suppliers) в каждой из стран.
FROM suppliers											--Результат отсортировать по убыванию количества поставщиков в стране
GROUP BY country
ORDER BY COUNT(*) DESC

SELECT ship_country, SUM(freight)						--суммарный вес заказов (в которых известен регион) по странам, но
FROM orders												--вывести только те результаты, где суммарный вес на страну больше 2750.
WHERE ship_region IS NOT NULL							--Отсортировать по убыванию суммарного веса
GROUP BY ship_country
HAVING SUM(freight) > 2750
ORDER BY SUM(freight) DESC

SELECT country FROM customers							--страны, в которых зарегистированы и заказчики (customers),
INTERSECT												--и поставщики (suppliers), и работники (employees).
SELECT country FROM suppliers
INTERSECT
SELECT country FROM employees

SELECT country FROM customers							--страны, в которых зарегистированы и заказчики (customers),
INTERSECT												--и поставщики (suppliers), но не зарегистрированы работники (employees).
SELECT country FROM suppliers
EXCEPT 
SELECT country FROM employees
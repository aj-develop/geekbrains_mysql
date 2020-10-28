-- Тема “Сложные запросы”

/*
1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
 */
SELECT u.id, u.name
FROM users AS u
RIGHT JOIN orders AS o ON u.id = o.user_id;

/*
2. Выведите список товаров products и разделов catalogs, который соответствует товару.
 */
SELECT p.id AS product_id, p.name AS product_name, c.id AS catalog_id, c.name AS catalog_name
FROM products AS p
JOIN  catalogs AS c ON p.catalog_id = c.id;

/*
3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
Поля from, to и label содержат английские названия городов, поле name — русское.
Выведите список рейсов flights с русскими названиями городов.
 */
SELECT id,
	(SELECT name FROM cities WHERE label = `from`) AS `from`,
	(SELECT name FROM cities WHERE label = `to`) AS `to`
FROM flights
ORDER BY id;
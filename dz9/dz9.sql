-- "Транзакции, переменные, представления"

/*
    1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
    Переместите запись id = 1 из таблицы shop.users в таблицу sample.users.
    Используйте транзакции.
 */
START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
COMMIT;

/*
    2. Создайте представление, которое выводит название name товарной позиции из таблицы products
    и соответствующее название каталога name из таблицы catalogs.
 */
CREATE OR REPLACE VIEW prods_view(p_id, p_name, c_name) AS
SELECT p.id AS p_id, p.name, cat.name
FROM products AS p
LEFT JOIN catalogs AS cat ON p.catalog_id = cat.id;



-- “Хранимые процедуры и функции, триггеры"

/*
    1. Создайте хранимую функцию hello(), которая будет возвращать приветствие,
    в зависимости от текущего времени суток.
    С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
    с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
    с 18:00 до 00:00 — "Добрый вечер",
    с 00:00 до 6:00 — "Доброй ночи".
 */
DROP PROCEDURE IF EXISTS hello;
delimiter //
CREATE PROCEDURE hello()
BEGIN
	CASE
		WHEN CURTIME() BETWEEN '06:00:00' AND '12:00:00' THEN
			SELECT 'Доброе утро';
		WHEN CURTIME() BETWEEN '12:00:00' AND '18:00:00' THEN
			SELECT 'Добрый день';
		WHEN CURTIME() BETWEEN '18:00:00' AND '00:00:00' THEN
			SELECT 'Добрый вечер';
		ELSE
			SELECT 'Доброй ночи';
	END CASE;
END //
delimiter ;

CALL hello();

/*
    2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
    Допустимо присутствие обоих полей или одно из них.
    Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
    Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
    При попытке присвоить полям NULL-значение необходимо отменить операцию.
 */
DROP TRIGGER IF EXISTS nullTrigger;
delimiter //
CREATE TRIGGER nullTrigger BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! NULL in both fields!';
	END IF;
END //
delimiter ;
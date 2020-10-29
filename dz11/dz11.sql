/**
    Практическое задание по теме “Оптимизация запросов”

    1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users,
    catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы,
    идентификатор первичного ключа и содержимое поля name.
*/

-- 1.
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME DEFAULT NOW(),
	table_name VARCHAR(255) NOT NULL,
	str_id BIGINT UNSIGNED NOT NULL,
	name_value VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE;

DROP TRIGGER IF EXISTS watchlog_users;
delimiter //
CREATE TRIGGER watchlog_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (table_name, str_id, name_value) VALUES ('users', NEW.id, NEW.name);
END //
delimiter ;

/* По такому же принципу создаются триггеры для catalogs и products */

/**
    Практическое задание по теме “Оптимизация запросов”

    2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
*/
DROP PROCEDURE IF EXISTS insert_into_users ;
delimiter //
CREATE PROCEDURE insert_into_users ()
BEGIN
	DECLARE i INT DEFAULT 1000000;
	DECLARE j INT DEFAULT 0;
	WHILE i > 0 DO
		INSERT INTO test_users(name, birthday_at) VALUES (CONCAT('user_', j), NOW());
		SET j = j + 1;
		SET i = i - 1;
	END WHILE;
END //
delimiter ;
--
CALL insert_into_users();


/*
    Практическое задание по теме “NoSQL”

    1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
*/

SADD ip '127.0.0.1' '127.0.0.3' '127.0.0.5'
-- список уникальных ip
SMEMBERS ip
-- кол-во адресов в коллекции
SCARD ip

/*
    Практическое задание по теме “NoSQL”

    2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот,
    поиск электронного адреса пользователя по его имени.
*/

set alex@web.de alex
set alex alex@web.de

get alex@web.de
get alex


/*
    Практическое задание по теме “NoSQL”

    3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
*/

db.products.insertMany([
	{"name": "INTEL DE-1", "description": "Процессор", "price": "200.00", "catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()},
	{"name": "INTEL DE-2", "description": "Процессор", "price": "350.00", "catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()}])

db.products.find().pretty()
db.products.find({name: "INTEL DE-1"}).pretty()
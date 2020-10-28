/*
Практическое задание по теме “Управление БД”
 */

/*
1. Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf,
задав в нем логин и пароль, который указывался при установке.
*/
[mysql]
user=db
password=db

/*
2. Создайте базу данных example, разместите в ней таблицу users,
состоящую из двух столбцов, числового id и строкового name.
 */

-- Создайте базу данных example
CREATE DATABASE IF NOT EXISTS example;

-- разместите в ней таблицу users, состоящую из двух столбцов,
-- числового id и строкового name
USE example;
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
);

/*
3. Создайте дамп базы данных example из предыдущего задания,
разверните содержимое дампа в новую базу данных sample.
 */
-- Создайте дамп базы данных example из предыдущего задания
mysqldump -u db -p example > example.sql
-- разверните содержимое дампа в новую базу данных sample
mysql -u db -p sample < example.sql

/*
4. (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump.
Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того,
чтобы дамп содержал только первые 100 строк таблицы.
 */
mysqldump --opt --where="1 limit 100" mysql help_keyword > mysql-help_keyword.sql
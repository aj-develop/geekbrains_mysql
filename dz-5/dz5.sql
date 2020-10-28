/*****
Уважаемый Кирилл,
доброго времени суток!
Вебинар номер 4 я просмотрел - спасибо!, но забыл отписаться.
Можно задним числом получить зачёт?
Заранее спасибо!
 */




-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”
/*
 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными.
 Заполните их текущими датой и временем.
*/
UPDATE users SET created_at = NOW(), updated_at = NOW();

/*
 2. Таблица users была неудачно спроектирована.
 Записи created_at и updated_at были заданы типом VARCHAR и
 в них долгое время помещались значения в формате "20.10.2017 8:10".
 Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
*/
-- created_at
UPDATE users SET created_at = STR_TO_DATE(created_at, "%d.%m.%Y %k:%i");
ALTER TABLE users MODIFY created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
-- updated_at
UPDATE users SET updated_at = STR_TO_DATE(updated_at, "%d.%m.%Y %k:%i");
ALTER TABLE users MODIFY updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

/*
  3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0,
  если товар закончился и выше нуля, если на складе имеются запасы.
  Необходимо отсортировать записи таким образом,
  чтобы они выводились в порядке увеличения значения value.
  Однако, нулевые запасы должны выводиться в конце, после всех записей.
*/
SELECT `value`
FROM storehouses_products
ORDER BY IF( `value` = 0, 1, 0 ), `value`;

/*
 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
 Месяцы заданы в виде списка английских названий ('may', 'august')
 */
SELECT name, birthday_at,
    CASE
        WHEN DATE_FORMAT(birthday_at, '%m') = 05 THEN 'may'
        WHEN DATE_FORMAT(birthday_at, '%m') = 08 THEN 'august'
    END AS month
FROM users
WHERE
    DATE_FORMAT(birthday_at, '%m') = 05 OR
    DATE_FORMAT(birthday_at, '%m') = 08;

 /*
 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
 SELECT * FROM catalogs WHERE id IN (5, 1, 2);
 Отсортируйте записи в порядке, заданном в списке IN.
  */
SELECT *
FROM catalogs
WHERE id IN (5, 1, 2)
ORDER BY
    CASE
        WHEN id = 5 THEN 0
        WHEN id = 1 THEN 1
        WHEN id = 2 THEN 2
    END;


-- Практическое задание теме “Агрегация данных”
/*
 1. Подсчитайте средний возраст пользователей в таблице users
 */
SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())), 0) AS avg_age
FROM users;

 /*
  2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
  Следует учесть, что необходимы дни недели текущего года, а не года рождения.
  */
SELECT
    DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday_at, 6, 10))) AS week_day,
    COUNT(*) AS count_of_birthday
FROM users
GROUP BY week_day
ORDER BY count_of_birthday DESC;

/*
  3. (по желанию) Подсчитайте произведение чисел в столбце таблицы
*/
SELECT ROUND(exp(SUM(ln(value))), 0)
FROM tbl;

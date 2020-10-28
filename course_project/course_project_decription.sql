/**
    1. Составить общее текстовое описание БД и решаемых ею задач

    Данная база данных описывает управление проектами по методике agile(по типу Jira или Trello).

*****/

/**
    2. минимальное количество таблиц - 10

    projects: - таблица проектов с описанием.
    tasks: задачи - основные составляющие, из которых состоят проекты.
    projects_tasks: конкретные задачи конкретных проектов.
    users: пользователи системы
    teams: таблица для соотнесения проектов и занятых в них команд.
    users_teams: таблица соотнесения пользователей и команд
    statuses: статус пользователя системы.
    users_statuses: таблица соотнесения пользователей и их статуса
    messages: таблица сообщений пользователей.

 *****/

/**
    3. скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами)

*****/

DROP DATABASE IF EXISTS course_project;
CREATE DATABASE course_project;
USE course_project;

DROP TABLE IF EXISTS projects;
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    title varchar(255) NOT NULL DEFAULT '',
    description text
);

DROP TABLE IF EXISTS tasks;
CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    title varchar(255) NOT NULL DEFAULT '',
    description text
);
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS projects_tasks;
CREATE TABLE projects_tasks (
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	project_id BIGINT UNSIGNED NOT NULL,
	task_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	start_data DATETIME DEFAULT NULL,
	finish_data DATETIME DEFAULT NULL,
	deadline DATETIME DEFAULT NULL,

    PRIMARY KEY (project_id, task_id, user_id),

	CONSTRAINT projects_tasks_projects_fk
		FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE RESTRICT,
	CONSTRAINT projects_tasks_tasks_fk
		FOREIGN KEY (task_id)  REFERENCES tasks (id) ON DELETE RESTRICT,
	CONSTRAINT projects_tasks_users_fk
		FOREIGN KEY (user_id)  REFERENCES users (id) ON DELETE RESTRICT
);

DROP TABLE IF EXISTS teams;
CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    title varchar(255) NOT NULL DEFAULT '',
    description text
);

DROP TABLE IF EXISTS users_teams;
CREATE TABLE users_teams (
    user_id BIGINT UNSIGNED NOT NULL,
    team_id BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (user_id, team_id),

    FOREIGN KEY (user_id)  REFERENCES users (id)  ON DELETE cascade,
    FOREIGN KEY (team_id)  REFERENCES teams (id)  ON DELETE cascade
);

DROP TABLE IF EXISTS statuses;
CREATE TABLE statuses (
    id SERIAL PRIMARY KEY,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    title varchar(255) NOT NULL DEFAULT '',
    description text
);

DROP TABLE IF EXISTS users_statuses;
CREATE TABLE users_statuses (
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    user_id BIGINT UNSIGNED NOT NULL,
    status_id BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (status_id)  REFERENCES statuses (id) ON DELETE cascade,
    FOREIGN KEY (user_id)  REFERENCES users (id) ON DELETE cascade
);

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
  id SERIAL PRIMARY KEY,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
  from_user_id BIGINT UNSIGNED NOT NULL,
  to_user_id BIGINT UNSIGNED NOT NULL,
  message_text text,

  CONSTRAINT messages_from_users_fk
		FOREIGN KEY (from_user_id)  REFERENCES users (id) ON DELETE CASCADE,
	CONSTRAINT messages_to_users_fk
		FOREIGN KEY (to_user_id)  REFERENCES users (id) ON DELETE CASCADE
);

/**
    4. создать ERDiagram для БД

    file: er_diagram.png

*****/

/**
    5. скрипты наполнения БД данными

*****/

INSERT INTO `projects` (`id`,`created_at`, `updated_at`,`title`, `description`) VALUES
(1, '2020-10-28 17:52:48', '2020-10-29 17:52:48', 'dolorem dsd', 'Necessitatibus et sunt ex qui nam. Quod porro cupiditate blanditiis eaque molestias.'),
(2, '2019-11-28 17:52:48', '2020-10-29 17:52:48', 'est xer', 'Quod deserunt autem cum quo quos. Dolor omnis quas totam eligendi mollitia quae.'),
(3, '2017-03-28 17:52:48', '2020-10-29 17:52:48', 'itaque sddsds', 'Quis ipsa iusto aspernatur aut. Repellat quo ex aut harum.'),
(4, '2018-05-18 17:52:48', '2020-10-29 17:52:48', 'quam sdsd ', 'Et praesentium non beatae labore porro quisquam deleniti.'),
(5, '2013-10-28 17:52:48', '2020-10-29 17:52:48', 'adipisci wedsds', 'Nobis praesentium consequatur accusantium est quidem.'),
(6, '2012-10-28 17:52:48', '2020-10-29 17:52:48', 'dolorem', 'Officia ab quos qui et ab assumenda. Sunt itaque minus modi impedit totam voluptatem dolores.'),
(7, '2019-07-28 17:52:48', '2020-10-29 17:52:48', 'aut', 'Ut consequuntur praesentium ipsum minima dolores sapiente.'),
(8, '2018-04-28 17:52:48', '2020-10-29 17:52:48', 'auter dsd', 'Aut minus soluta reprehenderit voluptates. Non magnam dicta exercitationem vel.'),
(9, '2019-10-22 17:52:48', '2020-10-29 17:52:48', 'est', 'Veritatis illum odio assumenda cupiditate voluptatem id omnis.'),
(10, '2019-04-24 17:52:48', '2020-10-29 17:52:48', 'facilis', 'Exercitationem earum vero sint dolorem assumenda provident.');

INSERT INTO `tasks` (`id`,`created_at`, `updated_at`,`title`, `description`) VALUES
(1, '2019-10-28 17:52:48', '2020-10-29 17:52:48', 'Necessitatibus', 'Necessitatibus et sunt ex qui nam. Quod porro cupiditate blanditiis eaque molestias.'),
(2, '2019-12-28 17:52:48', '2020-10-29 17:52:48', 'praesentium', 'Quod deserunt autem cum quo quos. Dolor omnis quas totam eligendi mollitia quae.'),
(3, '2017-03-08 17:52:48', '2020-10-29 17:52:48', 'Aut minus', 'Quis ipsa iusto aspernatur aut. Repellat quo ex aut harum.'),
(4, '2019-05-18 17:52:48', '2020-10-29 17:52:48', 'quam sdsd ', 'Et Necessitatibus non beatae labore porro quisquam deleniti.'),
(5, '2013-11-28 17:52:48', '2020-10-29 17:52:48', 'aconsequuntur', 'Nobis praesentium consequatur accusantium est quidem.'),
(6, '2012-10-12 17:52:48', '2020-10-29 17:52:48', 'dolorem', 'Officia ab quos qui et ab assumenda. Sunt itaque minus modi impedit totam voluptatem dolores.'),
(7, '2019-07-23 17:52:48', '2020-10-29 17:52:48', 'Sunt itaque', 'Ut consequuntur praesentium ipsum minima dolores sapiente.'),
(8, '2017-04-28 17:52:48', '2020-10-29 17:52:48', 'auter dsd', 'Aut minus soluta reprehenderit voluptates. Non magnam dicta exercitationem vel.'),
(9, '2019-03-22 17:52:48', '2020-10-29 17:52:48', 'est', 'Veritatis illum odio assumenda cupiditate voluptatem id omnis.'),
(10, '2019-05-13 17:52:48', '2020-10-29 17:52:48', 'Quod deserunt', 'Exercitationem earum vero sint dolorem assumenda provident.');

INSERT INTO `users` (`id`, `created_at`, `updated_at`,`first_name`, `last_name`, `phone`) VALUES
(1, '2020-10-28 17:52:48', '2020-10-29 17:52:48', 'Ladarius', 'Romaguera', '(079)985-4692'),
(2, '2019-11-28 17:52:48', '2020-10-29 17:52:48', 'Lydia', 'DuBuque', '1-936-465-3488'),
(3, '2017-03-28 17:52:48', '2020-10-29 17:52:48', 'Josiane', 'Ebert', '353.903.0540'),
(4, '2018-05-18 17:52:48', '2020-10-29 17:52:48', 'Holly', 'Robel', '129.367.8997'),
(5, '2013-10-28 17:52:48', '2020-10-29 17:52:48', 'Candida', 'Price', '(658)922-8102x439'),
(6, '2012-10-28 17:52:48', '2020-10-29 17:52:48', 'Tess', 'Franecki', '788-967-9616'),
(7, '2019-07-28 17:52:48', '2020-10-29 17:52:48', 'Cole', 'Nader', '196-993-2740'),
(8, '2018-04-28 17:52:48', '2020-10-29 17:52:48', 'Zane', 'Bednar', '02831347208'),
(9, '2019-10-22 17:52:48', '2020-10-29 17:52:48', 'Jacynthe', 'Legros', '(480)645-5938x35715'),
(10, '2019-04-24 17:52:48', '2020-10-29 17:52:48', 'Roxane', 'Pfeffer', '626-113-8275');

INSERT INTO `projects_tasks` (`created_at`, `updated_at`, `project_id`, `task_id`, `user_id`, `start_data`, `finish_data`, `deadline`) VALUES
('2020-10-28 17:52:48', '2020-10-29 17:52:48', 7, 3, 3, '2015-04-21 21:47:14', '1999-10-21 11:12:11', '2012-09-07 06:40:16'),
('2020-10-28 17:52:48', '2020-10-29 17:52:48', 2, 8, 3, '2015-04-21 21:47:14', '1999-10-21 11:12:11', '2012-09-07 06:40:16'),
('2020-10-28 17:52:48', '2020-10-29 17:52:48', 2, 5, 3, '2015-04-21 21:47:14', '1999-10-21 11:12:11', '2012-09-07 06:40:16'),
('2020-10-28 17:52:48', '2020-10-29 17:52:48', 2, 10, 3, '2015-04-21 21:47:14', '1999-10-21 11:12:11', '2012-09-07 06:40:16'),
('2019-11-28 17:52:48', '2020-10-29 17:52:48', 3, 8, 2, '1994-10-06 12:12:49', '1992-05-21 15:37:21', '2003-10-14 22:54:44'),
('2017-03-28 17:52:48', '2020-10-29 17:52:48', 7, 6, 1, '1998-03-04 16:26:32', '1990-05-09 19:50:58', '1977-07-10 11:02:22'),
('2018-05-18 17:52:48', '2020-10-29 17:52:48', 1, 4, 4, '1976-03-06 18:51:49', '1986-08-19 18:32:19', '1996-02-16 15:18:57'),
('2013-10-28 17:52:48', '2020-10-29 17:52:48', 6, 2, 6, '1971-06-13 23:28:11', '2009-05-08 20:53:49', '2017-04-28 22:54:39'),
('2012-10-28 17:52:48', '2020-10-29 17:52:48', 9, 1, 5, '1975-11-18 14:14:36', '1989-08-20 07:21:01', '2009-01-19 16:25:51'),
('2019-07-28 17:52:48', '2020-10-29 17:52:48', 4, 3, 7, '1989-10-28 06:12:24', '1981-01-12 02:30:55', '1976-05-13 08:26:55'),
('2018-04-28 17:52:48', '2020-10-29 17:52:48', 8, 5, 9, '2008-04-19 19:51:50', '2017-04-14 05:21:09', '1995-07-19 00:30:35'),
('2019-10-22 17:52:48', '2020-10-29 17:52:48', 5, 7, 10, '1995-06-07 11:21:23', '1985-07-29 00:45:25', '2012-09-20 11:42:08'),
('2019-04-24 17:52:48', '2020-10-29 17:52:48', 10, 9, 8, '1970-01-11 02:18:14', '2010-12-22 22:32:28', '2009-11-23 04:08:47');

INSERT INTO `teams` (`id`,`created_at`, `updated_at`,`title`, `description`) VALUES
(1, '2020-10-28 17:52:48', '2020-10-29 17:52:48', 'A', 'Necessitatibus et sunt ex qui nam. Quod porro cupiditate blanditiis eaque molestias.'),
(2, '2019-11-28 17:52:48', '2020-10-29 17:52:48', 'B', 'Quod deserunt autem cum quo quos. Dolor omnis quas totam eligendi mollitia quae.'),
(3, '2017-03-28 17:52:48', '2020-10-29 17:52:48', 'C', 'Quis ipsa iusto aspernatur aut. Repellat quo ex aut harum.'),
(4, '2018-05-18 17:52:48', '2020-10-29 17:52:48', 'D', 'Et praesentium non beatae labore porro quisquam deleniti.'),
(5, '2013-10-28 17:52:48', '2020-10-29 17:52:48', 'E', 'Nobis praesentium consequatur accusantium est quidem.'),
(6, '2012-10-28 17:52:48', '2020-10-29 17:52:48', 'I', 'Officia ab quos qui et ab assumenda. Sunt itaque minus modi impedit totam voluptatem dolores.'),
(7, '2019-07-28 17:52:48', '2020-10-29 17:52:48', 'F', 'Ut consequuntur praesentium ipsum minima dolores sapiente.'),
(8, '2018-04-28 17:52:48', '2020-10-29 17:52:48', 'G', 'Aut minus soluta reprehenderit voluptates. Non magnam dicta exercitationem vel.'),
(9, '2019-10-22 17:52:48', '2020-10-29 17:52:48', 'K', 'Veritatis illum odio assumenda cupiditate voluptatem id omnis.'),
(10, '2019-04-24 17:52:48', '2020-10-29 17:52:48', 'L', 'Exercitationem earum vero sint dolorem assumenda provident.');

INSERT INTO `users_teams` (`user_id`,`team_id`) VALUES
(1,2),
(3,2),
(6,2),
(3,4),
(6,4),
(9,4),
(8,8),
(7,8),
(3,5),
(1,5);

INSERT INTO `statuses` (`id`, `created_at`, `updated_at`, `title`, `description`) VALUES 
(1, '2020-10-28 17:52:48', '2020-10-29 17:52:48', 'Owner', 'Owner of project, employer'),
(2, '2019-11-28 17:52:48', '2020-10-29 17:52:48', 'Project manager', 'Project manager, person, who create team, tasks and accept completed tasks'),
(3, '2017-03-28 17:52:48', '2020-10-29 17:52:48', 'Employee', 'Employee, who can to do some tasks'),
(4, '2018-05-18 17:52:48', '2020-10-29 17:52:48', 'Guest', 'Corrupti itaque dolorem adipisci necessitatibus voluptas vel magni.'),
(5, '2013-10-28 17:52:48', '2020-10-29 17:52:48', 'Developer', 'Ut qui nihil pariatur dolor labore omnis ut.');

INSERT INTO `users_statuses` (`created_at`, `updated_at`, `user_id`, `status_id`) VALUES
('2020-10-28 17:52:48', '2020-10-29 17:52:48', 1,2),
('2019-11-28 17:52:48', '2020-10-29 17:52:48', 2,1),
('2017-03-28 17:52:48', '2020-10-29 17:52:48', 3,4),
('2018-05-18 17:52:48', '2020-10-29 17:52:48', 4,3),
('2013-10-28 17:52:48', '2020-10-29 17:52:48', 5,2),
('2020-10-28 17:52:48', '2020-10-29 17:52:48', 6,5),
('2019-11-28 17:52:48', '2020-10-29 17:52:48', 7,4),
('2017-03-28 17:52:48', '2020-10-29 17:52:48', 8,2),
('2018-05-18 17:52:48', '2020-10-29 17:52:48', 10,1),
('2013-10-28 17:52:48', '2020-10-29 17:52:48', 9,3);

INSERT INTO `messages` (`id`, `created_at`, `updated_at`, `from_user_id`, `to_user_id`,`message_text`) VALUES
(1,'2020-10-28 17:52:48', '2020-10-29 17:52:48', 1,2,'utem est sunt vantium ea cupiditate ducimus est ut molestias.'),
(2,'2019-11-28 17:52:48', '2020-10-29 17:52:48', 2,1,'nt vel quam. Nesciunt laudantium ea cupiditate ducimus est ut molestias.'),
(3,'2017-03-28 17:52:48', '2020-10-29 17:52:48', 3,10,'Ipsa autem est m. Nesciunt laudantium ea cupiditate ducimus est ut molestias.'),
(4,'2018-05-18 17:52:48', '2020-10-29 17:52:48', 4,3,'Ipsa autem est sunt vel quam. Nescditate ducimus est ut molestias.'),
(5,'2013-10-28 17:52:48', '2020-10-29 17:52:48', 5,2,'est sunt vel quam. Nesciunt laudantium ea cupiditate ducimus est ut molestias.'),
(6,'2020-10-28 17:52:48', '2020-10-29 17:52:48', 6,9,'sa au vel quam. Nesciunt laudantium ea cupiditate ducimus est ut molestias.'),
(7,'2019-11-28 17:52:48', '2020-10-29 17:52:48', 7,4,'Ipsa autem est sunt vel quam. Nesciunt laudantium ea cupiditate ducimus est ut molestias.'),
(8,'2017-03-28 17:52:48', '2020-10-29 17:52:48', 8,7,'st sunt vel quam. Nesciunt laudantium ea cupiditate ducimus est ut molestias.'),
(9,'2018-05-18 17:52:48', '2020-10-29 17:52:48', 10,1,'Ipsa autem est sunt vel quam. Nesciunt laudantium ea cupiditate ducimus est ut molestias.'),
(10,'2013-10-28 17:52:48', '2020-10-29 17:52:48', 9,3,'ciunt laudantium ea cupiditate ducimus est ut molestias.');

/**
    6. скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы)

*****/

-- выборка 2-х проектов с максимальным количеством задач
SELECT project_id, (SELECT title FROM projects WHERE id = project_id) AS project_title, count(*) AS total_tasks
FROM projects_tasks
GROUP by project_id
ORDER BY total_tasks DESC
LIMIT 2;

/**
    7. представления

*****/

-- выборка заданий для всех пользователей с указанием дедлайна.
CREATE OR REPLACE VIEW user_tasks AS
    SELECT users.first_name AS first_name,  users.last_name AS last_name, tasks.title AS task_name, projects_tasks.deadline
    FROM projects_tasks
	LEFT JOIN users ON (users.id = projects_tasks.user_id)
	LEFT JOIN tasks ON (projects_tasks.task_id = tasks.id)
	ORDER BY last_name, start_data;

SELECT * FROM user_tasks;

/**
    8. хранимые процедуры / триггеры

*****/

-- процедура: проекты с большим количеством заданий
DROP PROCEDURE IF EXISTS big_project;
DELIMITER //
CREATE PROCEDURE big_project ()
BEGIN
    SELECT *
    FROM (
        SELECT projects.id, projects.title, count(*) as total
        FROM projects
            JOIN projects_tasks ON (projects_tasks.project_id = projects.id)
            JOIN tasks ON (tasks.id = projects_tasks.task_id)
            GROUP BY projects.id
            ORDER BY total DESC
    ) AS users
    WHERE total >= 2;
END//
CALL big_project()//
DELIMITER ;




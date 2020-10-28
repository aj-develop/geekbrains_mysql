DROP TABLE IF EXISTS pages;
CREATE TABLE pages (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    hidden smallint(5) UNSIGNED NOT NULL DEFAULT 0,
    sorting int(11) NOT NULL DEFAULT 0,
    title varchar(255) NOT NULL DEFAULT '',

    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS content;
CREATE TABLE content (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    page_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    hidden smallint(5) UNSIGNED NOT NULL DEFAULT 0,
    sorting int(11) NOT NULL DEFAULT 0,
    title varchar(255) NOT NULL DEFAULT '',
    body text,
    media_id BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (page_id) REFERENCES pages(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS user_groups;
CREATE TABLE user_groups (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    hidden smallint(5) UNSIGNED NOT NULL DEFAULT 0,
    title varchar(255) NOT NULL DEFAULT '',
    description text
);

ALTER TABLE users
ADD `group_id` BIGINT unsigned NOT NULL;

ALTER TABLE users
ADD CONSTRAINT user_fk_1
FOREIGN KEY (group_id) REFERENCES user_groups(id);
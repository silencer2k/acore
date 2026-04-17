DROP USER IF EXISTS 'acore'@'localhost';

CREATE USER 'acore'@'localhost' IDENTIFIED BY 'acore';
GRANT ALL PRIVILEGES ON `acore\_%`.* TO 'acore'@'localhost' WITH GRANT OPTION;

CREATE DATABASE IF NOT EXISTS acore_playerbots;

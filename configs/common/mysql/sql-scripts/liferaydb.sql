CREATE USER 'liferay' IDENTIFIED  WITH mysql_native_password BY 'liferay';
create database liferaymysql character set utf8;
GRANT ALL PRIVILEGES ON liferaymysql.* TO 'liferay'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

create database myLearning;
create database MTechLearning;

SHOW DATABASES;
USE  myLearning;
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);
INSERT INTO users (name, email) VALUES ('Somnath Sharma','somnath1690@gmail.com');
-- single line comment example
-- DROP DATABASE mydatabase;

/*
  This is a multi-line comment.
  It can span multiple lines.
*/

# This is another single-line comment

Select * from users
INSERT INTO `mylearning`.`users`
(`id`,
`name`,
`email`)
VALUES
(12,
'Test',
'test@gmail.com');


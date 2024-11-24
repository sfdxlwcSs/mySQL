create database cascadeSession7;
use cascadeSession7;
CREATE TABLE parent_table (
    parent_id INT PRIMARY KEY,
    parent_name VARCHAR(50)
);
CREATE TABLE child_table (
    child_id INT PRIMARY KEY,
    parent_id INT,
    child_name VARCHAR(50),
    CONSTRAINT fk_parent_id FOREIGN KEY (parent_id) REFERENCES parent_table(parent_id)
);
INSERT INTO parent_table (parent_id, parent_name)
VALUES
(1, 'Parent One'),
(2, 'Parent Two');
INSERT INTO child_table (child_id, parent_id, child_name)
VALUES
(1, 1, 'Child of Parent One'),
(2, 2, 'Child of Parent Two');
select * from parent_Table;
select * from child_Table;

DELETE FROM parent_table WHERE parent_id = 1;
# Error Code: 1451. Cannot delete or update a parent row: 
# a foreign key constraint fails (`cascadesession7`.`child_table`, 
# CONSTRAINT `fk_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `parent_table` (`parent_id`))

UPDATE parent_table SET parent_id = 3 WHERE parent_id = 2;
# Error Code: 1451. Cannot delete or update a parent row: 
# a foreign key constraint fails (`cascadesession7`.`child_table`, CONSTRAINT `fk_parent_id` 
# FOREIGN KEY (`parent_id`) REFERENCES `parent_table` (`parent_id`))


-- learn to use cascade 
DROP TABLE child_table;
DROP TABLE parent_table;

CREATE TABLE parent_table (
    parent_id INT PRIMARY KEY,
    parent_name VARCHAR(50)
);

# child table cascade is placed on table which has foreign key
# to check if a child has multiple foreign keys what happens if i delete one parent not the other what happens
CREATE TABLE child_table (
    child_id INT PRIMARY KEY,
    parent_id INT,
    child_name VARCHAR(50),
    CONSTRAINT fk_parent_id FOREIGN KEY (parent_id) REFERENCES parent_table(parent_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
INSERT INTO parent_table (parent_id, parent_name)
VALUES
(1, 'Parent One'),
(2, 'Parent Two');
INSERT INTO child_table (child_id, parent_id, child_name)
VALUES
(1, 1, 'Child of Parent One'),
(2, 2, 'Child of Parent Two');
DELETE FROM parent_table WHERE parent_id = 1;
select * from parent_Table;
select * from child_Table;
UPDATE parent_table SET parent_id = 3 WHERE parent_id = 2;
SELECT * FROM child_table WHERE parent_id = 1; -- no data
SELECT * FROM child_table WHERE parent_id = 3;

SELECT * FROM child_table WHERE parent_id = 1; -- no data

Select * From contractortodelink;

SHOW VARIABLES LIKE 'read_only';
ALTER TABLE contractortodelink
ADD PRIMARY KEY (id(255));  -- 255 characters for indexing
/*
In SQL, the SET keyword is only used once, and multiple columns 
should be updated within the same SET clause, separated by commas.
After modifying the column, if you want to make id the primary key or use it in indexes, you can do so with an additional command:
*/
ALTER TABLE contractortodelink
ADD PRIMARY KEY (id);


UPDATE contractortodelink 
SET Username = REPLACE(Username, '.hr', ''),
FederationIdentifier = REPLACE(FederationIdentifier, 'Inactive', '');		

#SHOW KEYS FROM table_name;
SHOW KEYS FROM contractortodelink;
DESCRIBE contractortodelink;

ALTER TABLE contractortodelink
MODIFY id INT NOT NULL;
/* Explanation:
ALTER TABLE contractortodelink: This command modifies the existing table contractortodelink.
MODIFY id INT NOT NULL: Changes the id column's data type to INT (Integer) and sets it to NOT NULL (ensuring it cannot contain NULL values). 
*/

#If the column is an integer and you want it to automatically increment with each new record, you can use the AUTO_INCREMENT keyword:
ALTER TABLE contractortodelink
MODIFY id INT NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY (id);

# You can turn off safe update mode for the current session by running the following command:
# This mode is designed to prevent accidental updates or deletes of rows without specifying a WHERE clause that uses a key (such as a primary key).
SET SQL_SAFE_UPDATES = 0;
#After that, you can re-enable safe update mode (if needed) by running:
SET SQL_SAFE_UPDATES = 1;









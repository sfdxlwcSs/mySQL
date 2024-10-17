SELECT student_id,sname,marks FROM student where sex='M';
SELECT student_id,sname,marks FROM student where marks=94;

# The issue with your query is that the two SELECT statements in the UNION operation are selecting different 
# columns in different orders, which can cause confusion and unintended duplicates.
SELECT student_id,sname,marks FROM student where sex='M' UNION
SELECT student_id,marks,sex FROM student where marks=94;

# correct query
SELECT student_id,sname,marks FROM student where sex='M' UNION
SELECT student_id,sname,marks FROM student where marks=94;

# To return duplicate results also
SELECT student_id,sname,marks FROM student where sex='M' UNION ALL
SELECT student_id,sname,marks FROM student where marks=94;

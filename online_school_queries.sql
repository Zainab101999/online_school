-- Selecting unique list of DISTINCT states from students table --
SELECT DISTINCT state
FROM students;

-- Getting names of students with last_names starting with k --

SELECT *
FROM students 
WHERE last_name REGEXP '^k';

-- Getting names of students with first_names ending with a --

SELECT * 
FROM students
WHERE first_name REGEXP 'a$'; 


-- Getting enrollment of each student in descending order along with their names --

SELECT s.student_id, CONCAT(first_name,' ',last_name) as name ,COUNT(*) AS number_of_courses_enrolled
FROM enrollments e
JOIN students s
USING (student_id)
GROUP BY s.student_id, name
ORDER BY number_of_courses_enrolled DESC;


-- Categorising students' membership level into gold, silver and bronze according to the number of courses they are enrolled in --

SELECT s.student_id, first_name, last_name, COUNT(*) AS number_of_courses_enrolled, 'Gold' AS Membership_level FROM enrollments e
JOIN students s
USING (student_id)
GROUP BY s.student_id
HAVING number_of_courses_enrolled >= 3

UNION
SELECT s.student_id, first_name, last_name, COUNT(*) AS number_of_courses_enrolled, 'Silver' AS Membership_level FROM enrollments e
JOIN students s
USING (student_id)
GROUP BY s.student_id
HAVING 3 > number_of_courses_enrolled >= 2

UNION
SELECT s.student_id, first_name, last_name, COUNT(*) AS number_of_courses_enrolled, 'Bronze' AS Membership_level FROM enrollments e
JOIN students s
USING (student_id)
GROUP BY s.student_id
HAVING 2 > number_of_courses_enrolled >= 1












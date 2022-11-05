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


-- Creating a stored procedure for the number of enrollment of each student in descending order along with their names --
DELIMITER |
CREATE PROCEDURE get_enrollments()
BEGIN
SELECT s.student_id, CONCAT(first_name,' ',last_name) as name ,COUNT(*) AS number_of_courses_enrolled
FROM enrollments e
JOIN students s
USING (student_id)
GROUP BY s.student_id, name
ORDER BY number_of_courses_enrolled DESC;
END;
|


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
HAVING 2 > number_of_courses_enrolled >= 1;

-- Getting student id and name of students who have not enrolled in a course yet --

SELECT student_id, CONCAT(first_name, ' ',last_name) AS name
FROM students s
WHERE student_id NOT IN(
SELECT DISTINCT student_id
FROM enrollments);

-- Geting the names and student ids of students who have enrolled in Mastering React --


SELECT student_id, CONCAT(first_name,' ',last_name) AS name
FROM students s
JOIN enrollments e 
USING (student_id)
JOIN courses
USING (course_id)
WHERE title = 'Mastering React';

-- Getting amount of discount each student got while enrolling in a course --
SELECT student_id, course_id, (SELECT price FROM courses where e.course_id = course_id) AS original_price, price AS price_paid_after_discount, (SELECT original_price) - e.price AS discount
FROM enrollments e;

-- Creating a stored procedure for updating price of course by using parameter validation so that no negative value can be added --
DELIMITER |
CREATE PROCEDURE get_pay(course_id INT, price INT)
BEGIN
UPDATE courses c
SET price = c.price
WHERE course_id = c.course_id;
IF price <= 0 THEN
SIGNAL SQLSTATE '22003'
SET MESSAGE_TEXT = 'Invalid price';
END IF;
END;

-- Creating a function to calculate the discount for each student_id --
CREATE DEFINER=`root`@`localhost` FUNCTION `get_discount`(student_id INT) RETURNS decimal(9,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE discount DECIMAL(9, 2);
DECLARE price_paid DECIMAL(5, 2);
DECLARE original_price DECIMAL(5, 2);
SELECT sum(c.price), sum(e.price)
INTO original_price, price_paid
FROM enrollments e
JOIN courses c
USING (course_id)
WHERE e.student_id = student_id;
SET discount = original_price - price_paid;
RETURN discount;
END














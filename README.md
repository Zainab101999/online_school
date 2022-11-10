# online_school

Step 1: Building a database

Building a database for a website that offers online courses is the basis of this data modelling assignment. The website is for selling online courses such that people can sign up and enroll in one or more courses. Instructors record these classes and post them to the website. One or more tags, such as front-end or back-end, may be added to a course. To build the database, I first developed a conceptual model with two entities—students and courses—and then, based on that, I developed a logical model to which I added a third entity, enrolment.
By using normalisation to eliminate data duplication, I created a physical model on MySQLWorkbench based on the logical model. 
I used forward engineering to build the database after building the model and choosing the primary keys for each table.

Step 2: Inserting data into tables

Step 3: Data Anlysis
Analysis of data by sql queries:

1) Selecting unique list of DISTINCT states from students table.
2) Getting names of students with last_names starting with k.
3) Getting names of students with first_names ending with a.
4) Creating a stored procedure for the number of enrollment of each student in descending order along with their names.
5) Categorising students' membership level into gold, silver and bronze according to the number of courses they are enrolled in.
6) Getting student id and name of students who have not enrolled in a course yet.
7) Geting the names and student ids of students who have enrolled in Mastering React. 
8) Getting amount of discount each student got while enrolling in a course.
9) Creating a stored procedure for updating price of course by using parameter validation so that no negative value can be added.
10) Creating a function to calculate the discount for each student_id.


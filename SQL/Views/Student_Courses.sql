CREATE VIEW Student_Courses AS

SELECT 
  d.dep_name AS Department,
  c.course_code AS Course_Code,
  c.course_name AS Course_Name

FROM Course c

JOIN Enrollment e 
    ON e.course_id = c.course_id

JOIN Student s 
    ON e.student_id = s.student_id

JOIN Department d 
    ON c.dep_id = d.dep_id

WHERE s.student_reg_no = '';
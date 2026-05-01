CREATE VIEW Student_Courses AS

SELECT 
    c.course_code AS Course_Code,
    c.course_name AS Course_Name

FROM Course c

JOIN  enrollment e
    ON e.course_id=c.course_id

JOIN Student s
 ON e.student_id=s.student_id;

WHERE s.student_reg_no = 'TG/2020/001';


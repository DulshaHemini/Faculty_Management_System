CREATE VIEW Student_Courses AS

SELECT 
    c.course_code AS Course_Code,
    c.course_name AS Course_Name

FROM Course c

JOIN  lec_enrollment e
    ON e.course_id=c.course_id

JOIN Batch b 
    ON e.batch_id=b.batch_id

JOIN Department d
    ON c.dep_id=d.dep_id

WHERE b.batch_id= 1
GROUP BY d.dep_name;


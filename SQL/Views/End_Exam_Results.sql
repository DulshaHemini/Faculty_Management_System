CREATE VIEW End_Exam_Results AS
SELECT
    s.student_id,
    s.student_reg_no,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,

    c.course_code,
    c.course_name,

    er.ca_result,
    er.end_exam_result,
    er.total_result,
    er.grade

FROM Exam_Results er

JOIN Student s
    ON er.student_id = s.student_id

JOIN Course c
    ON er.course_id = c.course_id;
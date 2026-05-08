CREATE VIEW End_Exam_Eligibility AS
SELECT
    s.student_id,
    s.student_reg_no,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_code,
    c.course_name,
    e.attendance_percentage,
    e.status
FROM Eligible e
JOIN Student s
    ON e.student_id = s.student_id
JOIN Course c
    ON e.course_id = c.course_id
WHERE e.attendance_percentage >= 80;
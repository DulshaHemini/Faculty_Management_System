CREATE VIEW Student_Attendance AS
SELECT s.student_id, s.student_reg_no,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_code,
    c.course_name,
    COUNT(ar.record_id) AS total_sessions,
    SUM(
        CASE
            WHEN ar.attendance = 'Present'
            THEN 1
            ELSE 0
        END
    ) AS present_count,
    ROUND(
        (
            SUM(
                CASE
                    WHEN ar.attendance = 'Present'
                    THEN 1
                    ELSE 0
                END
            ) / COUNT(ar.record_id)
        ) * 100,
        2
    ) AS attendance_percentage
FROM Attendance_Record ar
JOIN Student s ON ar.student_id = s.student_id
JOIN Course_Session cs ON ar.session_id = cs.session_id
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Course c ON e.course_id = c.course_id
GROUP BY s.student_id, c.course_id;
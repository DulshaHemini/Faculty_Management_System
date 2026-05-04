
DELIMITER $$

CREATE PROCEDURE Update_Student_GPA(IN p_student_id INT)
BEGIN

    DECLARE v_sgpa DECIMAL(4,2);
    DECLARE v_cgpa DECIMAL(4,2);

    SELECT
        ROUND(SUM(CASE er.grade
                    WHEN 'A+' THEN 4.0
                    WHEN 'A'  THEN 4.0
                    WHEN 'A-' THEN 3.7
                    WHEN 'B+' THEN 3.3
                    WHEN 'B'  THEN 3.0
                    WHEN 'B-' THEN 2.7
                    WHEN 'C+' THEN 2.3
                    WHEN 'C'  THEN 2.0
                    WHEN 'D+' THEN 1.3
                    WHEN 'D'  THEN 1.0
                    ELSE 0.0
                END * c.credits) / SUM(c.credits),2)

    INTO v_sgpa

    FROM Exam_Results er

    JOIN Course c ON er.course_id = c.course_id
    WHERE er.student_id = p_student_id
    AND c.semester = 1;

    SELECT ROUND( SUM( CASE er.grade
                    WHEN 'A+' THEN 4.0
                    WHEN 'A'  THEN 4.0
                    WHEN 'A-' THEN 3.7
                    WHEN 'B+' THEN 3.3
                    WHEN 'B'  THEN 3.0
                    WHEN 'B-' THEN 2.7
                    WHEN 'C+' THEN 2.3
                    WHEN 'C'  THEN 2.0
                    WHEN 'D+' THEN 1.3
                    WHEN 'D'  THEN 1.0
                    ELSE 0.0
                END * c.credits) / SUM(c.credits),2)

    INTO v_cgpa

    FROM Exam_Results er

    JOIN Course c
        ON er.course_id = c.course_id

    WHERE er.student_id = p_student_id;

    UPDATE Student

    SET
        sgpa = v_sgpa,
        cgpa = v_cgpa

    WHERE student_id = p_student_id;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE Check_Exam_Eligibility(
    IN p_student_id INT,
    IN p_course_id INT
)

BEGIN

    DECLARE v_total_sessions INT;
    DECLARE v_present_sessions INT;
    DECLARE v_attendance_percentage DECIMAL(5,2);

    SELECT COUNT(*)

    INTO v_total_sessions

    FROM Course_Session

    WHERE course_id = p_course_id;

    SELECT COUNT(*)

    INTO v_present_sessions

    FROM Attendance_Record ar

    JOIN Course_Session cs ON ar.session_id = cs.session_id

    WHERE ar.student_id = p_student_id
        AND cs.course_id = p_course_id
        AND ar.attendance = 'Present';

    SET v_attendance_percentage = (v_present_sessions / v_total_sessions) * 100;

    DELETE FROM Eligible

    WHERE student_id = p_student_id
        AND course_id = p_course_id;

    INSERT INTO Eligible(student_id, course_id, attendance_percentage, `status`)

    VALUES(p_student_id, p_course_id, ROUND(v_attendance_percentage),

        CASE
            WHEN v_attendance_percentage >= 80
                THEN 'Eligible'
            ELSE 'Not Eligible'

        END
    );

END $$

DELIMITER ;

CALL Check_Exam_Eligibility(1,2);
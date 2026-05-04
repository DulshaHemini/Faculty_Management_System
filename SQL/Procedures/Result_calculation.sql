
DELIMITER $$

CREATE PROCEDURE Calculate_Final_Result(IN p_result_id INT)
BEGIN
    DECLARE v_quiz_total DECIMAL(5,2);
    DECLARE v_ca_result DECIMAL(5,2);
    DECLARE v_end_exam_result DECIMAL(5,2);
    DECLARE v_total_result DECIMAL(5,2);
    DECLARE v_theory DECIMAL(5,2);
    DECLARE v_practical DECIMAL(5,2);
    DECLARE v_course_type VARCHAR(20);

    SELECT c.course_type, er.end_exam_theory_marks, er.end_exam_practical_marks
    INTO v_course_type, v_theory, v_practical

    FROM Exam_Results er
    JOIN Course c ON er.course_id = c.course_id

    WHERE er.result_id = p_result_id;

    SELECT
        ((quiz01_marks + quiz02_marks + quiz03_marks) - LEAST(quiz01_marks,quiz02_marks, quiz03_marks)) / 2
    INTO v_quiz_total

    FROM Exam_Results
    WHERE result_id = p_result_id;

    UPDATE Exam_Results
    SET ca_result =
    ((v_quiz_total * 0.15) + (assignment01_marks * 0.15) +(assignment02_marks * 0.15) + (( mid_exam_theory_marks + mid_exam_practical_marks) / 2) * 0.55)

    WHERE result_id = p_result_id;

    SELECT ca_result
    INTO v_ca_result
    FROM Exam_Results
    WHERE result_id = p_result_id;

    IF v_course_type = 'Both' THEN
        SET v_end_exam_result = (v_theory * 0.60) + (v_practical * 0.40);
    ELSEIF v_course_type = 'Theory' THEN
        SET v_end_exam_result = v_theory;
    ELSEIF v_course_type = 'Practical' THEN
        SET v_end_exam_result = v_practical;
    END IF;

    SET v_total_result = (v_ca_result * 0.40) + (v_end_exam_result * 0.60);

    UPDATE Exam_Results

    SET
        end_exam_result = ROUND(v_end_exam_result,2),
        total_result = ROUND(v_total_result,2),
        grade =
        CASE
            WHEN v_total_result >= 85 THEN 'A+'
            WHEN v_total_result >= 75 THEN 'A'
            WHEN v_total_result >= 70 THEN 'A-'
            WHEN v_total_result >= 65 THEN 'B+'
            WHEN v_total_result >= 60 THEN 'B'
            WHEN v_total_result >= 55 THEN 'B-'
            WHEN v_total_result >= 50 THEN 'C+'
            WHEN v_total_result >= 45 THEN 'C'
            WHEN v_total_result >= 40 THEN 'D'
            ELSE 'F'
        END
    WHERE result_id = p_result_id;
END $$

DELIMITER ;

CALL Calculate_Final_Result(1);
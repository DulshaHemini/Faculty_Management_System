-- Admin
CREATE USER 'admin_user'@'localhost'
IDENTIFIED BY 'Admin@123';

-- Dean
CREATE USER 'dean_user'@'localhost'
IDENTIFIED BY 'Dean@123';

-- Lecturer
CREATE USER 'lecturer_user'@'localhost'
IDENTIFIED BY 'Lecturer@123';

-- Technical Officer
CREATE USER 'to_user'@'localhost'
IDENTIFIED BY 'TO@123';

-- Student
CREATE USER 'student_user'@'localhost'
IDENTIFIED BY 'Student@123';

GRANT ALL PRIVILEGES
ON Faculty_Management_System.*
TO 'admin_user'@'localhost'
WITH GRANT OPTION;

GRANT ALL PRIVILEGES
ON Faculty_Management_System.*
TO 'dean_user'@'localhost';

GRANT ALL PRIVILEGES
ON Faculty_Management_System.*
TO 'lecturer_user'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON Faculty_Management_System.attendance_record
TO 'to_user'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON Faculty_Management_System.course_session
TO 'to_user'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON Faculty_Management_System.medical_request
TO 'to_user'@'localhost';


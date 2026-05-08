-- Admin
CREATE USER 'admin'@'localhost'
IDENTIFIED BY 'Admin@123';

-- Dean
CREATE USER 'dean'@'localhost'
IDENTIFIED BY 'Dean@123';

-- Lecturer
CREATE USER 'lecturer'@'localhost'
IDENTIFIED BY 'Lecturer@123';

-- Technical Officer
CREATE USER 'technical_officer'@'localhost'
IDENTIFIED BY 'TO@123';

-- Student
CREATE USER 'student'@'localhost'
IDENTIFIED BY 'Student@123';

GRANT ALL PRIVILEGES
ON Faculty_Management_System.*
TO 'admin'@'localhost'
WITH GRANT OPTION;

GRANT ALL PRIVILEGES
ON Faculty_Management_System.*
TO 'dean'@'localhost';

GRANT ALL PRIVILEGES
ON Faculty_Management_System.*
TO 'lecturer'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON Faculty_Management_System.attendance_record
TO 'technical_officer'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON Faculty_Management_System.course_session
TO 'technical_officer'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON Faculty_Management_System.medical_request
TO 'technical_officer'@'localhost';


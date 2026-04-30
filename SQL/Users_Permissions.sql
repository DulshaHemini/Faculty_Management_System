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
ON faculty_management_system.*
TO 'admin_user'@'localhost'
WITH GRANT OPTION;

GRANT ALL PRIVILEGES
ON faculty_management_system.*
TO 'dean_user'@'localhost';

GRANT ALL PRIVILEGES
ON faculty_management_system.*
TO 'lecturer_user'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON faculty_management_system.attendance
TO 'to_user'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON faculty_management_system.attendance_sessions
TO 'to_user'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON faculty_management_system.medical_records
TO 'to_user'@'localhost';


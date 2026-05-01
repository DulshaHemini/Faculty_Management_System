
CREATE DATABASE Student_Management_System;

USE Student_Management_System;

CREATE TABLE User(
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_first_name VARCHAR(20) NOT NULL,
    user_last_name VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    dob DATE,
    user_type ENUM('Admin','Dean','Lecturer','Technical_Officer','Student') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Technical_Officer(
    officer_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    nic VARCHAR(12) NOT NULL,
    dob DATE,
    email VARCHAR(50) NOT NULL,
    contact_no VARCHAR(10) NOT NULL,
    home_no VARCHAR(10) NOT NULL,
    street VARCHAR(50) NOT NULL,
    town VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

CREATE TABLE Department(
    dep_id INT PRIMARY KEY AUTO_INCREMENT,
    dep_name VARCHAR(100) NOT NULL,
    status VARCHAR(15) NOT NULL
);

CREATE TABLE Batch(
    batch_id INT PRIMARY KEY AUTO_INCREMENT,
    batch_name VARCHAR(20) NOT NULL,
    status VARCHAR(15) NOT NULL
);

CREATE TABLE Level_Semester(
    level_id INT,
    level_name VARCHAR(20) NOT NULL,
    sem_id INT,
    sem_name VARCHAR(20) NOT NULL,
    batch_id INT,
    sem_period INT NOT NULL,
    PRIMARY KEY(level_id, sem_id),
    FOREIGN KEY (batch_id) REFERENCES Batch(batch_id) ON DELETE CASCADE
);

CREATE TABLE Course(
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(10) NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    course_credits INT,
    dep_id INT,
    level_id INT,
    sem_id INT,
    course_type ENUM('Theory','Practical') NOT NULL,
    FOREIGN KEY (dep_id) REFERENCES Department(dep_id) ON DELETE CASCADE,
    FOREIGN KEY (level_id, sem_id) REFERENCES Level_Semester(level_id, sem_id) ON DELETE CASCADE
);

CREATE TABLE Lecture(
    lec_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    dep_id INT,
    lec_reg_no VARCHAR(12) NOT NULL,
    lec_name VARCHAR(100) NOT NULL,
    lec_nic VARCHAR(20) NOT NULL,
    lec_dob DATE,
    contact_no VARCHAR(10) NOT NULL,
    home_no VARCHAR(10) NOT NULL,
    street VARCHAR(50) NOT NULL,
    town VARCHAR(50) NOT NULL,
    lec_position VARCHAR(50) NOT NULL,
    gender ENUM('Male','Female') NOT NULL,
    email VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (dep_id) REFERENCES Department(dep_id) ON DELETE CASCADE
);

CREATE TABLE Student(
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    student_reg_no VARCHAR(12) NOT NULL,
    nic VARCHAR(12) NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    sgpa DECIMAL(4,2),
    cgpa DECIMAL(4,2),
    gender ENUM('Male','Female') NOT NULL,
    dob DATE,
    email VARCHAR(50) NOT NULL,
    contact_no VARCHAR(10) NOT NULL,
    home_no VARCHAR(10) NOT NULL,
    street VARCHAR(50) NOT NULL,
    town VARCHAR(50) NOT NULL,
    student_type ENUM('Regular','Suspend','Repeat','Resigned') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

CREATE TABLE Enrollment(
    enroll_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT NULL,
    FOREIGN KEY (student_id) REFERENCES Student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Course(course_id) ON DELETE CASCADE
);

CREATE TABLE Lec_Enrollment(
    lec_enroll_id INT PRIMARY KEY AUTO_INCREMENT,
    lecture_id INT,
    course_id INT,
    batch_id INT,
    FOREIGN KEY (lecture_id) REFERENCES Lecture(lec_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Course(course_id) ON DELETE CASCADE,
    FOREIGN KEY (batch_id) REFERENCES Batch(batch_id) ON DELETE CASCADE
);

CREATE TABLE Course_Session(
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    session_type ENUM('Theory','Practical') NOT NULL,
    session_time_duration INT,
    week_no INT
);

CREATE TABLE Medical_Request(
    medical_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    reason TEXT,
    date_from DATE,
    date_to DATE,
    remarks TEXT,
    document_ref_no VARCHAR(20) NOT NULL,
    submitted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    approved ENUM('Approved','Pending') NOT NULL,
    approved_date DATE,
    approved_by ENUM('Technical_Officer','Admin','Dean') DEFAULT 'Technical_Officer',
    FOREIGN KEY (student_id) REFERENCES Student(student_id) ON DELETE CASCADE
);

CREATE TABLE Attendance_Record(
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    session_id INT,
    medical_id INT,
    attendance ENUM('Present','Absent') NOT NULL,
    FOREIGN KEY (session_id) REFERENCES Course_Session(session_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES Student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (medical_id) REFERENCES Medical_Request(medical_id) ON DELETE CASCADE
);

CREATE TABLE Exam_Results(
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    quiz01_marks DECIMAL(4,2),
    quiz02_marks DECIMAL(4,2),
    quiz03_marks DECIMAL(4,2),
    assignment01_marks DECIMAL(4,2),
    assignment02_marks DECIMAL(4,2),
    mid_exam_theory_marks DECIMAL(4,2),
    mid_exam_practical_marks DECIMAL(4,2),
    ca_result DECIMAL(4,2),
    end_exam_theory_marks DECIMAL(4,2),
    end_exam_practical_marks DECIMAL(4,2),
    end_exam_result DECIMAL(4,2),
    total_result DECIMAL(4,2),
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES Student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Course(course_id) ON DELETE CASCADE
);

CREATE TABLE Eligible(
    student_id INT,
    course_id INT,
    attendance_percentage INT,
    status VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES Student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Course(course_id) ON DELETE CASCADE
);



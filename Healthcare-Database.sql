CREATE DATABASE healthcare_db;
USE healthcare_db;
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(15),
    email VARCHAR(100),
    address TEXT
);
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialty VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100)
);
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    diagnosis TEXT,
    prescription TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);
INSERT INTO patients (first_name, last_name, dob, gender, phone, email, address)
VALUES 
('John', 'Kim', '1990-05-14', 'Male', '139-649-1876', 'johnkim@email.com', '627 Main St, City'),
('Jane', 'Smith', '1985-11-22', 'Female', '537-873-6387', 'janesmith@email.com', '637 Elm St, City');
INSERT INTO doctors (first_name, last_name, specialty, phone, email)
VALUES 
('Dr. Alice', 'Brown', 'Cardiology', '633-227-3780', 'alice.brown@jkf.com'),
('Dr. Bob', 'Johnson', 'Neurology', '536-482-2827', 'bob.johnson@jkf.com');
INSERT INTO appointments (patient_id, doctor_id, appointment_date, diagnosis, prescription)
VALUES 
(1, 1, '2025-03-20 10:30:00', 'High Blood Pressure', 'Medication A'),
(2, 2, '2025-03-21 14:00:00', 'Migraine', 'Painkillers');
SELECT * FROM patients;
SELECT a.appointment_id, p.first_name AS patient_name, d.first_name AS doctor_name, 
       a.appointment_date, a.diagnosis, a.prescription
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;
SELECT d.first_name AS doctor, COUNT(a.appointment_id) AS total_appointments
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id;


CREATE DATABASE hospital_analytics;
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address TEXT,
    INDEX idx_patient_name (first_name, last_name)
);
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialty VARCHAR(100),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    diagnosis TEXT,
    prescription TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE
);
INSERT INTO patients (first_name, last_name, dob, gender, phone, email, address)
VALUES 
('Alice', 'Johnson', '1990-02-14', 'Female', '123-456-7890', 'alice@email.com', '12 Baker St, NY'),
('Mark', 'Smith', '1985-08-30', 'Male', '234-567-8901', 'mark@email.com', '45 Park Ave, NY');
INSERT INTO doctors (first_name, last_name, specialty, phone, email)
VALUES 
('Dr. Sarah', 'Lee', 'Cardiology', '555-111-2222', 'sarah.lee@hospital.com'),
('Dr. Robert', 'White', 'Neurology', '555-333-4444', 'robert.white@hospital.com');
INSERT INTO appointments (patient_id, doctor_id, appointment_date, diagnosis, prescription)
VALUES 
(1, 1, '2025-04-01 09:00:00', 'High Blood Pressure', 'Medication A'),
(2, 2, '2025-04-02 10:30:00', 'Migraine', 'Painkillers');
DELIMITER //
CREATE PROCEDURE GetPatientAppointments(IN patientID INT)
BEGIN
    SELECT a.appointment_id, a.appointment_date, d.first_name AS doctor, a.diagnosis, a.prescription
    FROM appointments a
    JOIN doctors d ON a.doctor_id = d.doctor_id
    WHERE a.patient_id = patientID;
END //
DELIMITER ;
CALL GetPatientAppointments(1);
CREATE TABLE appointment_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    log_message TEXT,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER after_appointment_insert
AFTER INSERT ON appointments
FOR EACH ROW
BEGIN
    INSERT INTO appointment_logs (appointment_id, log_message)
    VALUES (NEW.appointment_id, CONCAT('New appointment added for Patient ID: ', NEW.patient_id));
END //
DELIMITER ;
CREATE VIEW PatientAppointments AS
SELECT p.first_name AS patient, d.first_name AS doctor, a.appointment_date, a.diagnosis
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;
SELECT * FROM PatientAppointments;

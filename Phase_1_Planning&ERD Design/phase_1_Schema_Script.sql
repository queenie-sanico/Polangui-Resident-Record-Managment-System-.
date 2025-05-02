CREATE DATABASE PolanguiResidentDB;
USE PolanguiResidentDB;

CREATE TABLE Barangay (
    barangay_id INT AUTO_INCREMENT PRIMARY KEY,
    barangay_name VARCHAR(100) NOT NULL,
    barangay_classification ENUM('Poblacion', 'Rinconada', 'Upland', 'Railroad') NOT NULL
);

CREATE TABLE Address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    house_no VARCHAR(20),
    street VARCHAR(100),
    purok VARCHAR(50),
    barangay_id INT,
    FOREIGN KEY (barangay_id) REFERENCES Barangay(barangay_id)
);

CREATE TABLE Resident (
    resident_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    suffix VARCHAR(10),
    birth_date DATE NOT NULL,
    age INT NOT NULL,
    gender ENUM('Male', 'Female'),
    civil_status ENUM('Single', 'Married', 'Widowed', 'Divorced'),
    occupation VARCHAR(100),
    contact_number VARCHAR(15),
    household_size INT NOT NULL,
    barangay_id INT,
    address_id INT,
    FOREIGN KEY (barangay_id) REFERENCES Barangay(barangay_id),
    FOREIGN KEY (address_id) REFERENCES Address(address_id),
    INDEX (birth_date),
    INDEX (age)
);

CREATE TABLE ResidencyStatus (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    resident_id INT,
    status ENUM('Active', 'Deceased', 'Moved Out', 'Transferred') NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (resident_id) REFERENCES Resident(resident_id)
);
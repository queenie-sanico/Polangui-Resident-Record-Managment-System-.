-- Create Database
CREATE DATABASE PolanguiResidentStarDB;
USE PolanguiResidentStarDB;

-- Dimension Table: Barangay
CREATE TABLE DimBarangay (
    barangay_key INT AUTO_INCREMENT PRIMARY KEY,
    barangay_name VARCHAR(100) NOT NULL,
    barangay_classification ENUM('Poblacion', 'Rinconada', 'Upland', 'Railroad') NOT NULL
);

-- Dimension Table: Address
CREATE TABLE DimAddress (
    address_key INT AUTO_INCREMENT PRIMARY KEY,
    house_no VARCHAR(20),
    street VARCHAR(100),
    purok VARCHAR(50),
    barangay_key INT,
    FOREIGN KEY (barangay_key) REFERENCES DimBarangay(barangay_key)
);

-- Dimension Table: Resident
CREATE TABLE DimResident (
    resident_key INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    suffix VARCHAR(10),
    birth_date DATE NOT NULL,
    gender ENUM('Male', 'Female'),
    civil_status ENUM('Single', 'Married', 'Widowed', 'Divorced'),
    occupation VARCHAR(100),
    contact_number VARCHAR(15)
);

-- Dimension Table: Residency Status
CREATE TABLE DimResidencyStatus (
    status_key INT AUTO_INCREMENT PRIMARY KEY,
    status ENUM('Active', 'Deceased', 'Moved Out', 'Transferred') NOT NULL
);

-- Fact Table: Resident Information
CREATE TABLE FactResident (
    fact_id INT AUTO_INCREMENT PRIMARY KEY,
    resident_key INT,
    address_key INT,
    barangay_key INT,
    status_key INT,
    age INT NOT NULL,
    household_size INT NOT NULL,
    status_updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (resident_key) REFERENCES DimResident(resident_key),
    FOREIGN KEY (address_key) REFERENCES DimAddress(address_key),
    FOREIGN KEY (barangay_key) REFERENCES DimBarangay(barangay_key),
    FOREIGN KEY (status_key) REFERENCES DimResidencyStatus(status_key),
    INDEX (age),
    INDEX (status_updated_at)
);





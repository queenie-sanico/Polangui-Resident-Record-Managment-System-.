CREATE DATABASE PolanguiResidentDB;
USE PolanguiResidentDB;

CREATE TABLE Address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    barangay VARCHAR(100) NOT NULL,
    town VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL,
    zip_code VARCHAR(10) NOT NULL
);
    
    CREATE TABLE Barangay (
    barangay_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    town VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL
);

CREATE TABLE Resident (
    resident_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    contact_number VARCHAR(15),
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES Address(address_id) ON DELETE SET NULL
);

CREATE TABLE Located_In (
    barangay_id INT,
    address_id INT,
    PRIMARY KEY (barangay_id, address_id),
    FOREIGN KEY (barangay_id) REFERENCES Barangay(barangay_id) ON DELETE CASCADE,
    FOREIGN KEY (address_id) REFERENCES Address(address_id) ON DELETE CASCADE
);

CREATE TABLE Resides_In (
    resident_id INT,
    barangay_id INT,
    PRIMARY KEY (resident_id, barangay_id),
    FOREIGN KEY (resident_id) REFERENCES Resident(resident_id) ON DELETE CASCADE,
    FOREIGN KEY (barangay_id) REFERENCES Barangay(barangay_id) ON DELETE CASCADE
);

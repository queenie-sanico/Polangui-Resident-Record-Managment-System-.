CREATE DATABASE PolanguiResidentDB;
USE PolanguiResidentDB;

-- Address Table
CREATE TABLE Address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    barangay VARCHAR(100) NOT NULL,
    town VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL,
    zip_code VARCHAR(10) NOT NULL
);

-- Barangay Table
CREATE TABLE Barangay (
    barangay_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    town VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL
);

-- Resident Table
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

-- Located_In Table
CREATE TABLE Located_In (
    barangay_id INT,
    address_id INT,
    PRIMARY KEY (barangay_id, address_id),
    FOREIGN KEY (barangay_id) REFERENCES Barangay(barangay_id) ON DELETE CASCADE,
    FOREIGN KEY (address_id) REFERENCES Address(address_id) ON DELETE CASCADE
);

-- Resides_In Table
CREATE TABLE Resides_In (
    resident_id INT,
    barangay_id INT,
    PRIMARY KEY (resident_id, barangay_id),
    FOREIGN KEY (resident_id) REFERENCES Resident(resident_id) ON DELETE CASCADE,
    FOREIGN KEY (barangay_id) REFERENCES Barangay(barangay_id) ON DELETE CASCADE
);

DELIMITER $$

CREATE PROCEDURE GenerateData()
BEGIN
    DECLARE i INT DEFAULT 1;

    -- Generate 100,000 Address records
    WHILE i <= 100000 DO
        INSERT INTO Address (barangay, town, province, zip_code)
        VALUES (
            CONCAT('Barangay', i),
            'Polangui',
            'Albay',
            LPAD(FLOOR(RAND() * 10000), 4, '0')
        );
        SET i = i + 1;
    END WHILE;

    SET i = 1;
    -- Generate 100,000 Barangay records
    WHILE i <= 100000 DO
        INSERT INTO Barangay (name, town, province)
        VALUES (
            CONCAT('Barangay', i),
            'Polangui',
            'Albay'
        );
        SET i = i + 1;
    END WHILE;

    SET i = 1;
    -- Generate 100,000 Resident records
    WHILE i <= 100000 DO
        INSERT INTO Resident (first_name, last_name, birth_date, gender, contact_number, address_id)
        VALUES (
            CONCAT('First', i),
            CONCAT('Last', i),
            DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 80 + 18) YEAR),
            CASE FLOOR(RAND() * 3) 
                WHEN 0 THEN 'Male'
                WHEN 1 THEN 'Female'
                ELSE 'Other'
            END,
            CONCAT('09', LPAD(FLOOR(RAND() * 1000000000), 9, '0')),
            i
        );
        SET i = i + 1;
    END WHILE;

    SET i = 1;
    -- Generate 100,000 Located_In records
    WHILE i <= 100000 DO
        INSERT INTO Located_In (barangay_id, address_id)
        VALUES (i, i);
        SET i = i + 1;
    END WHILE;

    SET i = 1;
    -- Generate 100,000 Resides_In records
    WHILE i <= 100000 DO
        INSERT INTO Resides_In (resident_id, barangay_id)
        VALUES (i, i);
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

CALL GenerateData();

-- Check row counts
SELECT 'Address' AS table_name, COUNT(*) AS total_rows FROM Address
UNION ALL
SELECT 'Barangay', COUNT(*) AS total_rows FROM Barangay
UNION ALL
SELECT 'Resident', COUNT(*) AS total_rows FROM Resident
UNION ALL
SELECT 'Located_In', COUNT(*) AS total_rows FROM Located_In
UNION ALL
SELECT 'Resides_In', COUNT(*) AS total_rows FROM Resides_In;

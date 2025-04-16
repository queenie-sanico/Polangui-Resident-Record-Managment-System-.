CREATE DATABASE PolanguiResidentDB;
USE PolanguiResidentDB;

-- Temp table for real barangay names
CREATE TABLE BarangayNames (
    barangay_id INT AUTO_INCREMENT PRIMARY KEY,
    barangay_name VARCHAR(100) NOT NULL
);

-- Insert real barangay names from Polangui
INSERT INTO BarangayNames (barangay_name) VALUES
('Agos'), ('Alnay'), ('Alomon'), ('Amoguis'), ('Anopol'), ('Apad'),
('Balaba'), ('Balangibang'), ('Balinad'), ('Basud'), ('Binagbangan (Pintor)'),
('Buyo'), ('Centro Occidental (Pob.)'), ('Centro Oriental (Pob.)'), ('Cepres'),
('Cotmon'), ('Cotnogan'), ('Danao'), ('Gabon'), ('Gamot'), ('Itaran'), ('Kinale'),
('Kinuartilan'), ('La Medalla'), ('La Purisima'), ('Lanigay'), ('Lidong'),
('Lourdes'), ('Magpanambo'), ('Magurang'), ('Matacon'), ('Maynaga'), ('Maysua'),
('Mendez'), ('Napo'), ('Pinagdapugan'), ('Ponso'), ('Salvacion'), ('San Roque'),
('Santa Cruz'), ('Santa Teresita'), ('Santicon'), ('Sugcad'), ('Ubaliw');

-- Main tables
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

-- Insert real barangays into Barangay table
INSERT INTO Barangay (name, town, province)
SELECT barangay_name, 'Polangui', 'Albay'
FROM BarangayNames;

-- Insert real barangays into Address table with zip_code = '4506'
INSERT INTO Address (barangay, town, province, zip_code)
SELECT barangay_name, 'Polangui', 'Albay', '4506'
FROM BarangayNames;

-- Drop BarangayNames as it's no longer needed
DROP TABLE BarangayNames;

-- Procedure to generate 100k records (starting after real entries)
DELIMITER $$

CREATE PROCEDURE GenerateData()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE offset INT;
    DECLARE max_barangay_id INT;
    DECLARE rand_barangay_id INT;

    -- Get current count of Barangay (from real inserts)
    SELECT COUNT(*) INTO offset FROM Barangay;

    -- Get max for random pick
    SET max_barangay_id = offset;

    -- Generate 100,000 Address records with zip_code = '4506'
    WHILE i <= 100000 DO
        SET rand_barangay_id = FLOOR(1 + RAND() * max_barangay_id);

        INSERT INTO Address (barangay, town, province, zip_code)
        SELECT name, 'Polangui', 'Albay', '4506'
        FROM Barangay
        WHERE barangay_id = rand_barangay_id;

        SET i = i + 1;
    END WHILE;

    SET i = 1;

    -- Generate 100,000 Barangay records
    WHILE i <= 100000 DO
        SET rand_barangay_id = FLOOR(1 + RAND() * max_barangay_id);

        INSERT INTO Barangay (name, town, province)
        SELECT name, 'Polangui', 'Albay'
        FROM Barangay
        WHERE barangay_id = rand_barangay_id;

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
            offset + i
        );
        SET i = i + 1;
    END WHILE;

    SET i = 1;

    -- Generate Located_In records
    WHILE i <= 100000 DO
        INSERT INTO Located_In (barangay_id, address_id)
        VALUES (offset + i, offset + i);
        SET i = i + 1;
    END WHILE;

    SET i = 1;

    -- Generate Resides_In records
    WHILE i <= 100000 DO
        INSERT INTO Resides_In (resident_id, barangay_id)
        VALUES (i, offset + i);
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- Call the procedure
CALL GenerateData();

-- Summary
SELECT 'Address' AS table_name, COUNT(*) AS total_rows FROM Address
UNION ALL
SELECT 'Barangay', COUNT(*) AS total_rows FROM Barangay
UNION ALL
SELECT 'Resident', COUNT(*) AS total_rows FROM Resident
UNION ALL
SELECT 'Located_In', COUNT(*) AS total_rows FROM Located_In
UNION ALL
SELECT 'Resides_In', COUNT(*) AS total_rows FROM Resides_In;

SELECT * FROM Address;
SELECT * FROM Barangay;


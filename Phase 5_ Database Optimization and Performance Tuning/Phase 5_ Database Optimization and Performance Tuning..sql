CREATE DATABASE PolanguiResidentDB;
USE PolanguiResidentDB;

CREATE TABLE Barangay (
    barangay_id INT AUTO_INCREMENT PRIMARY KEY,
    barangay_name VARCHAR(100) NOT NULL,
    barangay_classification ENUM('Poblacion', 'Rinconada', 'Upland', 'Railroad') NOT NULL
);

INSERT INTO Barangay (barangay_name, barangay_classification) VALUES
('Agos', 'Rinconada'), ('Alnay', 'Poblacion'), ('Alomon', 'Poblacion'), ('Amoguis', 'Upland'),
('Anopol', 'Upland'), ('Apad', 'Rinconada'), ('Balaba', 'Upland'), ('Balangibang', 'Poblacion'),
('Balinad', 'Upland'), ('Basud', 'Poblacion'), ('Binagbangan (Pintor)', 'Rinconada'), ('Buyo', 'Upland'),
('Centro Occidental', 'Poblacion'), ('Centro Oriental', 'Poblacion'), ('Cepres', 'Upland'), ('Cotmon', 'Upland'),
('Cotnogan', 'Upland'), ('Danao', 'Upland'), ('Gabon', 'Upland'), ('Gamot', 'Upland'),
('Itaran', 'Upland'), ('Kinale', 'Upland'), ('Kinuartilan', 'Upland'), ('La Medalla', 'Rinconada'),
('La Purisima', 'Rinconada'), ('Lanigay', 'Rinconada'), ('Lidong', 'Upland'), ('Lourdes', 'Upland'),
('Magpanambo', 'Upland'), ('Magurang', 'Upland'), ('Matacon', 'Rinconada'), ('Maynaga', 'Upland'),
('Maysua', 'Rinconada'), ('Mendez', 'Upland'), ('Napo', 'Upland'), ('Pinagdapugan', 'Upland'),
('Ponso', 'Rinconada'), ('Salvacion', 'Upland'), ('San Roque', 'Rinconada'), ('Santicon', 'Rinconada'),
('Santa Cruz', 'Upland'), ('Santa Teresita', 'Rinconada'), ('Sugcad', 'Poblacion'), ('Ubaliw', 'Poblacion');

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

DELIMITER $$

CREATE TRIGGER set_resident_age_on_insert
BEFORE INSERT ON Resident
FOR EACH ROW
BEGIN
    SET NEW.age = TIMESTAMPDIFF(YEAR, NEW.birth_date, CURDATE());
END$$

CREATE TRIGGER update_resident_age_on_change
BEFORE UPDATE ON Resident
FOR EACH ROW
BEGIN
    IF NEW.birth_date != OLD.birth_date THEN
        SET NEW.age = TIMESTAMPDIFF(YEAR, NEW.birth_date, CURDATE());
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE UpdateAllAges()
BEGIN
    UPDATE Resident
    SET age = TIMESTAMPDIFF(YEAR, birth_date, CURDATE());
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE GenerateResidents(IN num_residents INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE random_barangay INT;
    DECLARE inserted_address_id INT;
    DECLARE resident_birthdate DATE;
    DECLARE resident_age INT;
    DECLARE household_size INT;

    WHILE i <= num_residents DO
        SET random_barangay = FLOOR(1 + (RAND() * 44));
        SET resident_birthdate = DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 80 + 18) YEAR);
        SET resident_age = TIMESTAMPDIFF(YEAR, resident_birthdate, CURDATE());
        SET household_size = FLOOR(RAND() * 8) + 1;

       
        INSERT INTO Address (house_no, street, purok, barangay_id)
        VALUES (
            CONCAT('H', LPAD(FLOOR(RAND() * 1000), 3, '0')),
            ELT(FLOOR(1 + (RAND() * 10)), 'Rizal St.', 'Bonifacio Ave.', 'Mabini St.', 'Quezon Blvd.', 'Aguinaldo St.', 'Del Pilar St.', 'Lapu-Lapu Ave.', 'Magallanes St.', 'Kalayaan Rd.', 'Narra St.'),
            CONCAT('Purok ', FLOOR(1 + (RAND() * 10))),
            random_barangay
        );
        SET inserted_address_id = LAST_INSERT_ID();

       
        INSERT INTO Resident (
            first_name, middle_name, last_name, suffix,
            birth_date, age, gender, civil_status, occupation,
            contact_number, household_size, barangay_id, address_id
        )
        VALUES (
            ELT(FLOOR(1 + (RAND() * 10)), 'Juan', 'Jose', 'Pedro', 'Andres', 'Luis', 'Antonio', 'Manuel', 'Francisco', 'Josefa', 'Maria'),
            ELT(FLOOR(1 + (RAND() * 10)), 'Cruz', 'Reyes', 'Luna', 'Gomez', 'Torres', 'Dela Cruz', 'Bautista', 'Rivera', 'Santos', 'Alvarez'),
            ELT(FLOOR(1 + (RAND() * 10)), 'Garcia', 'Martinez', 'Rodriguez', 'Lopez', 'Diaz', 'Reyes', 'Santos', 'Guerrero', 'Alvarez', 'Fernandez'),
            ELT(FLOOR(1 + (RAND() * 5)), 'Jr.', 'Sr.', 'III', 'IV', NULL),
            resident_birthdate,
            resident_age,
            ELT(FLOOR(1 + (RAND() * 2)), 'Male', 'Female'),
            ELT(FLOOR(1 + (RAND() * 4)), 'Single', 'Married', 'Widowed', 'Divorced'),
            ELT(FLOOR(1 + (RAND() * 10)), 'Farmer', 'Teacher', 'Engineer', 'Nurse', 'Fisherman', 'Driver', 'Vendor', 'Technician', 'Student', 'Unemployed'),
            CONCAT('09', LPAD(FLOOR(RAND() * 1000000000), 9, '0')),
            household_size,
            random_barangay,
            inserted_address_id
        );

        
        INSERT INTO ResidencyStatus (resident_id, status)
        VALUES (
            LAST_INSERT_ID(),
            ELT(FLOOR(1 + (RAND() * 4)), 'Active', 'Deceased', 'Moved Out', 'Transferred')
        );

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

CALL GenerateResidents(100000);


CREATE INDEX idx_resident_barangay_id ON Resident(barangay_id);
CREATE INDEX idx_status_resident_id ON ResidencyStatus(resident_id);
CREATE INDEX idx_barangay_name ON Barangay(barangay_name);
CREATE INDEX idx_resident_name ON Resident(last_name, first_name);



CREATE OR REPLACE VIEW ResidentDetailedInfo AS
SELECT 
    r.resident_id,
    CONCAT(r.first_name, ' ', IFNULL(r.middle_name, ''), ' ', r.last_name, IFNULL(CONCAT(' ', r.suffix), '')) AS full_name,
    r.birth_date,
    r.age,
    r.gender,
    r.civil_status,
    r.occupation,
    r.contact_number,
    r.household_size,
    rs.status AS residency_status,
    rs.updated_at AS status_last_updated,
    b.barangay_name,
    b.barangay_classification,
    CONCAT(a.house_no, ' ', a.street, ', Purok ', a.purok, ', ', b.barangay_name) AS full_address
FROM 
    Resident r
JOIN 
    Address a ON r.address_id = a.address_id
JOIN 
    Barangay b ON r.barangay_id = b.barangay_id
JOIN 
    ResidencyStatus rs ON r.resident_id = rs.resident_id;

SELECT 
    resident_id AS 'ID',
    full_name AS 'Name',
    birth_date AS 'Birth Date',
    age AS 'Age',
    gender AS 'Gender',
    residency_status AS 'Status',
    household_size AS 'Household Size',
    barangay_name AS 'Barangay'
FROM 
    ResidentDetailedInfo
ORDER BY 
    barangay_name, full_name
LIMIT 100;

SELECT 'Barangay' AS table_name, COUNT(*) AS total_rows FROM Barangay
UNION ALL
SELECT 'Address', COUNT(*) FROM Address
UNION ALL
SELECT 'Resident', COUNT(*) FROM Resident
UNION ALL
SELECT 'ResidencyStatus', COUNT(*) FROM ResidencyStatus;

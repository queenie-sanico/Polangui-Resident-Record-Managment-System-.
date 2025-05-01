CREATE DATABASE PolanguiResidentDB;
USE PolanguiResidentDB;

-- Create the Barangay Table
CREATE TABLE Barangay (
    barangay_id INT AUTO_INCREMENT PRIMARY KEY,
    barangay_name VARCHAR(100) NOT NULL,
    town VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL
);

-- Create the Address Table (linked to Barangay using barangay_id)
CREATE TABLE Address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    barangay_id INT NOT NULL,  -- Link to Barangay using barangay_id
    barangay_name VARCHAR(100) NOT NULL, -- Add barangay_name in Address table
    town VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    CONSTRAINT fk_address_barangay FOREIGN KEY (barangay_id) REFERENCES Barangay(barangay_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Create the Resident Table (linked to Address)
CREATE TABLE Resident (
    resident_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NULL,
    last_name VARCHAR(100) NULL, -- Ensure this is NOT NULL
    birth_date DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    contact_number VARCHAR(15),
    address_id INT,
    CONSTRAINT fk_resident_address FOREIGN KEY (address_id) REFERENCES Address(address_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Create the Located_In Table (Barangay <-> Address)
CREATE TABLE Located_In (
    barangay_id INT NOT NULL,
    address_id INT NOT NULL,
    PRIMARY KEY (barangay_id, address_id),
    CONSTRAINT fk_locatedin_barangay FOREIGN KEY (barangay_id) REFERENCES Barangay(barangay_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_locatedin_address FOREIGN KEY (address_id) REFERENCES Address(address_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Create the Resides_In Table (Resident <-> Barangay)
CREATE TABLE Resides_In (
    resident_id INT NOT NULL,
    barangay_id INT NOT NULL,
    PRIMARY KEY (resident_id, barangay_id),
    CONSTRAINT fk_residesin_resident FOREIGN KEY (resident_id) REFERENCES Resident(resident_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_residesin_barangay FOREIGN KEY (barangay_id) REFERENCES Barangay(barangay_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Insert the 44 Real Barangays
INSERT INTO Barangay (barangay_name, town, province) VALUES
('Agos', 'Polangui', 'Albay'), ('Alnay', 'Polangui', 'Albay'), ('Alomon', 'Polangui', 'Albay'),
('Amoguis', 'Polangui', 'Albay'), ('Anopol', 'Polangui', 'Albay'), ('Apad', 'Polangui', 'Albay'),
('Balaba', 'Polangui', 'Albay'), ('Balangibang', 'Polangui', 'Albay'), ('Balinad', 'Polangui', 'Albay'),
('Basud', 'Polangui', 'Albay'), ('Binagbangan (Pintor)', 'Polangui', 'Albay'), ('Buyo', 'Polangui', 'Albay'),
('Centro Occidental (Pob.)', 'Polangui', 'Albay'), ('Centro Oriental (Pob.)', 'Polangui', 'Albay'),
('Cepres', 'Polangui', 'Albay'), ('Cotmon', 'Polangui', 'Albay'), ('Cotnogan', 'Polangui', 'Albay'),
('Danao', 'Polangui', 'Albay'), ('Gabon', 'Polangui', 'Albay'), ('Gamot', 'Polangui', 'Albay'),
('Itaran', 'Polangui', 'Albay'), ('Kinale', 'Polangui', 'Albay'), ('Kinuartilan', 'Polangui', 'Albay'),
('La Medalla', 'Polangui', 'Albay'), ('La Purisima', 'Polangui', 'Albay'), ('Lanigay', 'Polangui', 'Albay'),
('Lidong', 'Polangui', 'Albay'), ('Lourdes', 'Polangui', 'Albay'), ('Magpanambo', 'Polangui', 'Albay'),
('Magurang', 'Polangui', 'Albay'), ('Matacon', 'Polangui', 'Albay'), ('Maynaga', 'Polangui', 'Albay'),
('Maysua', 'Polangui', 'Albay'), ('Mendez', 'Polangui', 'Albay'), ('Napo', 'Polangui', 'Albay'),
('Pinagdapugan', 'Polangui', 'Albay'), ('Ponso', 'Polangui', 'Albay'), ('Salvacion', 'Polangui', 'Albay'),
('San Roque', 'Polangui', 'Albay'), ('Santa Cruz', 'Polangui', 'Albay'), ('Santa Teresita', 'Polangui', 'Albay'),
('Santicon', 'Polangui', 'Albay'), ('Sugcad', 'Polangui', 'Albay'), ('Ubaliw', 'Polangui', 'Albay');

-- Set DELIMITER for Procedure
DELIMITER $$

-- Procedure to Generate 100,000 Data with Filipino Random Names
CREATE PROCEDURE GenerateData()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE random_barangay INT;
    DECLARE random_first_name VARCHAR(100);
    DECLARE random_last_name VARCHAR(100);

    -- List of possible Filipino first names and last names
    DECLARE first_names VARCHAR(100) DEFAULT 'Juan,Jose,Pedro,Mariano,Andres,Luis,Antonio,Manuel,Francisco,Josefa';
    DECLARE last_names VARCHAR(100) DEFAULT 'Garcia,Martinez,Rodriguez,Luna,Lopez,Diaz,Reyes,Santos,Guerrero,Alvarez';

    WHILE i <= 100000 DO
        -- Pick random Barangay ID (1 to 44)
        SET random_barangay = FLOOR(1 + (RAND() * 44));

        -- Generate random first name and last name by selecting from the list
        SET random_first_name = ELT(FLOOR(1 + (RAND() * 10)), 'Juan', 'Jose', 'Pedro', 'Mariano', 'Andres', 'Luis', 'Antonio', 'Manuel', 'Francisco', 'Josefa');
        SET random_last_name = ELT(FLOOR(1 + (RAND() * 10)), 'Garcia', 'Martinez', 'Rodriguez', 'Luna', 'Lopez', 'Diaz', 'Reyes', 'Santos', 'Guerrero');

        -- Insert Address with barangay_id and barangay_name
        INSERT INTO Address (barangay_id, barangay_name, town, province, zip_code)
        VALUES (random_barangay, 
                (SELECT barangay_name FROM Barangay WHERE barangay_id = random_barangay),
                'Polangui', 'Albay', '4506');

        -- Insert Resident with random names
        INSERT INTO Resident (first_name, last_name, birth_date, gender, contact_number, address_id)
        VALUES (
            random_first_name,
            random_last_name,
            DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 60 + 18) YEAR),
            CASE FLOOR(RAND() * 3)
                WHEN 0 THEN 'Male'
                WHEN 1 THEN 'Female'
                ELSE 'Other'
            END,
            CONCAT('09', LPAD(FLOOR(RAND() * 1000000000), 9, '0')),
            i
        );

        -- Insert Located_In (Barangay <-> Address)
        INSERT INTO Located_In (barangay_id, address_id)
        VALUES (random_barangay, i);

        -- Insert Resides_In (Resident <-> Barangay)
        INSERT INTO Resides_In (resident_id, barangay_id)
        VALUES (i, random_barangay);

        -- Increment counter
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- Execute the Procedure
CALL GenerateData();

-- Check Counts
SELECT 'Barangay' AS table_name, COUNT(*) AS total_rows FROM Barangay
UNION ALL
SELECT 'Address', COUNT(*) FROM Address
UNION ALL
SELECT 'Resident', COUNT(*) FROM Resident
UNION ALL
SELECT 'Located_In', COUNT(*) FROM Located_In
UNION ALL
SELECT 'Resides_In', COUNT(*) FROM Resides_In;

-- See joined Address with barangay name
SELECT 
    a.address_id,
    b.barangay_id,
    a.barangay_name,  -- Corrected column reference
    a.town,
    a.province,
    a.zip_code
FROM Address a;

-- See Barangay
SELECT * FROM Barangay;
SELECT * FROM Address;
SELECT * FROM Resident;
SELECT * FROM Resides_In;
SELECT * FROM Located_In;
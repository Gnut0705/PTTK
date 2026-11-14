-- File: schema.sql (Khoi tao co so du lieu cho du an LibMan0)
CREATE DATABASE IF NOT EXISTS libman0 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE libman0;

-- 1. Bang tblMember0
CREATE TABLE IF NOT EXISTS tblMember0 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    phonenumber VARCHAR(20) UNIQUE,
    fullname VARCHAR(150),
    role VARCHAR(50)
);

-- 2. Bang tblReader0
CREATE TABLE IF NOT EXISTS tblReader0 (
    tblMember0id INT PRIMARY KEY,
    readerCode VARCHAR(50) UNIQUE,
    address VARCHAR(255),
    email VARCHAR(100) UNIQUE,
    FOREIGN KEY (tblMember0id) REFERENCES tblMember0(id) ON DELETE CASCADE
);

-- 3. Bang tblReaderCard0
CREATE TABLE IF NOT EXISTS tblReaderCard0 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cardCode VARCHAR(50) UNIQUE,
    cardIssuanceDate DATE,
    expiry DATE,
    tblReader0id INT,
    FOREIGN KEY (tblReader0id) REFERENCES tblReader0(tblMember0id) ON DELETE CASCADE
);

-- 4. Bang tblLibrarian0
CREATE TABLE IF NOT EXISTS tblLibrarian0 (
    tblMember0id INT PRIMARY KEY,
    librarianCode VARCHAR(50) UNIQUE,
    FOREIGN KEY (tblMember0id) REFERENCES tblMember0(id) ON DELETE CASCADE
);

-- 5. Bang tblManager0
CREATE TABLE IF NOT EXISTS tblManager0 (
    tblMember0id INT PRIMARY KEY,
    managerCode VARCHAR(50) UNIQUE,
    FOREIGN KEY (tblMember0id) REFERENCES tblMember0(id) ON DELETE CASCADE
);

-- 6. Bang tblDocument0
CREATE TABLE IF NOT EXISTS tblDocument0 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    documentCode VARCHAR(50) UNIQUE,
    name VARCHAR(255),
    author VARCHAR(150),
    publisher VARCHAR(150),
    yearOfPublication INT,
    quantity INT,
    typeOfDocument VARCHAR(100)
);

-- 7. Bang tblLoanSlip0
CREATE TABLE IF NOT EXISTS tblLoanSlip0 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    borrowingDate DATE,
    dueDate DATE,
    tblReader0id INT,
    tblLibrarian0id INT,
    FOREIGN KEY (tblReader0id) REFERENCES tblReader0(tblMember0id),
    FOREIGN KEY (tblLibrarian0id) REFERENCES tblLibrarian0(tblMember0id)
);

-- 8. Bang tblLoanSlipDetails0
CREATE TABLE IF NOT EXISTS tblLoanSlipDetails0 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(50),
    note VARCHAR(255),
    tblLoanSlip0id INT,
    tblDocument0id INT,
    FOREIGN KEY (tblLoanSlip0id) REFERENCES tblLoanSlip0(id) ON DELETE CASCADE,
    FOREIGN KEY (tblDocument0id) REFERENCES tblDocument0(id)
);

-- Drop procedures neu da ton tai
DROP PROCEDURE IF EXISTS getDocumentStats;
DROP PROCEDURE IF EXISTS getLoanSlipsByDoc;
DROP PROCEDURE IF EXISTS getLoanSlipDetails;

-- Stored Procedure 1: getDocumentStats (Thong ke tai lieu theo so lan muon)
DELIMITER //
CREATE PROCEDURE getDocumentStats(IN startDate DATE, IN endDate DATE)
BEGIN
    SELECT 
        d.id,
        d.documentCode,
        d.name,
        d.yearOfPublication,
        COUNT(lsd.id) AS numberOfTimesBorrowed
    FROM tblDocument0 d
    LEFT JOIN tblLoanSlipDetails0 lsd ON d.id = lsd.tblDocument0id
    LEFT JOIN tblLoanSlip0 ls ON lsd.tblLoanSlip0id = ls.id
        AND ls.borrowingDate >= startDate AND ls.borrowingDate <= endDate
    GROUP BY d.id, d.documentCode, d.name, d.yearOfPublication
    ORDER BY numberOfTimesBorrowed DESC;
END //

-- Stored Procedure 2: getLoanSlipsByDoc (Chi tiet cac lan tai lieu duoc muon)
CREATE PROCEDURE getLoanSlipsByDoc(IN idDoc INT, IN startDate DATE, IN endDate DATE)
BEGIN
    SELECT 
        ls.id,
        ls.borrowingDate,
        ls.dueDate,
        mReader.fullname AS readerName,
        mLibrarian.fullname AS librarianName
    FROM tblLoanSlip0 ls
    JOIN tblLoanSlipDetails0 lsd ON ls.id = lsd.tblLoanSlip0id
    JOIN tblMember0 mReader ON ls.tblReader0id = mReader.id
    JOIN tblMember0 mLibrarian ON ls.tblLibrarian0id = mLibrarian.id
    WHERE lsd.tblDocument0id = idDoc
      AND ls.borrowingDate >= startDate 
      AND ls.borrowingDate <= endDate;
END //

-- Stored Procedure 3: getLoanSlipDetails (Chi tiet phieu muon)
CREATE PROCEDURE getLoanSlipDetails(IN idLoanSlip INT)
BEGIN
    SELECT 
        lsd.id,
        lsd.status,
        lsd.note,
        d.id AS docId,
        d.documentCode,
        d.name AS docName,
        ls.borrowingDate,
        ls.dueDate,
        mReader.fullname AS readerName,
        mLibrarian.fullname AS librarianName
    FROM tblLoanSlipDetails0 lsd
    JOIN tblLoanSlip0 ls ON lsd.tblLoanSlip0id = ls.id
    JOIN tblDocument0 d ON lsd.tblDocument0id = d.id
    JOIN tblMember0 mReader ON ls.tblReader0id = mReader.id
    JOIN tblMember0 mLibrarian ON ls.tblLibrarian0id = mLibrarian.id
    WHERE ls.id = idLoanSlip;
END //
DELIMITER ;

-- Du lieu mau
INSERT INTO tblMember0 (id, username, password, phonenumber, fullname, role) VALUES 
(1, 'ql01', '123456', '0912345678', 'Nguyễn Văn Quản Lý', 'manager'),
(2, 'tt01', '123456', '0923456789', 'Trần Thị Thủ Thư', 'librarian'),
(3, 'bd01', '123456', '0934567890', 'Lê Bạn Đọc', 'reader')
ON DUPLICATE KEY UPDATE fullname=VALUES(fullname);

INSERT INTO tblManager0 (tblMember0id, managerCode) VALUES (1, 'MN001')
ON DUPLICATE KEY UPDATE managerCode=VALUES(managerCode);

INSERT INTO tblLibrarian0 (tblMember0id, librarianCode) VALUES (2, 'LB001')
ON DUPLICATE KEY UPDATE librarianCode=VALUES(librarianCode);

INSERT INTO tblReader0 (tblMember0id, readerCode, address, email) VALUES (3, 'RD001', 'Hà Nội', 'bandoc@gmail.com')
ON DUPLICATE KEY UPDATE address=VALUES(address);

INSERT INTO tblDocument0 (id, documentCode, name, author, publisher, yearOfPublication, quantity, typeOfDocument) VALUES 
(1, 'DOC001', 'Lập trình Java căn bản', 'Nguyễn Văn A', 'NXB Giáo Dục', 2022, 10, 'Sách'),
(2, 'DOC002', 'Phân tích thiết kế hệ thống', 'Trần Văn B', 'NXB Bưu Điện', 2023, 15, 'Giáo trình')
ON DUPLICATE KEY UPDATE name=VALUES(name);

INSERT INTO tblLoanSlip0 (id, borrowingDate, dueDate, tblReader0id, tblLibrarian0id) VALUES 
(1, '2026-10-01', '2026-10-15', 3, 2)
ON DUPLICATE KEY UPDATE borrowingDate=VALUES(borrowingDate);

INSERT INTO tblLoanSlipDetails0 (id, status, note, tblLoanSlip0id, tblDocument0id) VALUES 
(1, 'Đang mượn', 'Tài liệu còn mới', 1, 1),
(2, 'Đang mượn', '', 1, 2)
ON DUPLICATE KEY UPDATE status=VALUES(status);

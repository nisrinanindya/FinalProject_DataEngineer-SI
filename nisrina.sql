CREATE DATABASE db_mess;

USE db_mess;

----------------------------------------------------------------------
-- TABLE tbl_room

CREATE TABLE tbl_room
(
ID INT PRIMARY KEY,
room_number INT		NOT NULL,
room_occupancy INT	NOT NULL,
room_availability varchar(10) NOT NULL,
role_id INT
);


INSERT INTO tbl_room VALUES (116731, 11, 3, 'YES', 1112);
INSERT INTO tbl_room VALUES (173612, 12, 6, 'YES', 1111);
INSERT INTO tbl_room VALUES (182934, 13, 4, 'NO', NULL);
INSERT INTO tbl_room VALUES (127346, 14, 2, 'YES', 1124);
INSERT INTO tbl_room VALUES (193287, 15, 6, 'YES', 1122 );
INSERT INTO tbl_room VALUES (192292, 16, 8, 'YES', 1121);
INSERT INTO tbl_room VALUES (189213, 17, 3, 'NO', NULL);
INSERT INTO tbl_room VALUES (192183, 18, 4, 'YES', 1123);
INSERT INTO tbl_room VALUES (182937, 19, 2, 'NO', NULL);
INSERT INTO tbl_room VALUES (111361, 20, 1, 'NO', NULL);

SELECT * FROM tbl_room

DROP TABLE tbl_room

--------------------------------------------------------
-- TABLE tbl_permissions

CREATE TABLE tbl_permissions
(
ID INT PRIMARY KEY,
name varchar(100) NOT NULL
);

INSERT INTO tbl_permissions VALUES (7211, 'Employee');
INSERT INTO tbl_permissions VALUES (7212, 'Penjaga Mess');
INSERT INTO tbl_permissions VALUES (7213, 'Admin');
INSERT INTO tbl_permissions VALUES (7214, 'Super Admin');

SELECT * FROM tbl_permissions

DROP TABLE tbl_permissions

--------------------------------------------------
-- TABLE tbl_roles


CREATE TABLE tbl_roles
(
ID INT PRIMARY KEY,
name varchar(50) NOT NULL,
permission_id INT
);

INSERT INTO tbl_roles VALUES (1111, 'Staff', 7211);
INSERT INTO tbl_roles VALUES (1112, 'Senior Staff', 7211);
INSERT INTO tbl_roles VALUES (1121, 'Assistant Engineer', 7211);
INSERT INTO tbl_roles VALUES (1122, 'Engineer', 7211);
INSERT INTO tbl_roles VALUES (1123, 'Senior Engineer', 7211);
INSERT INTO tbl_roles VALUES (1124, 'Technique Leader', 7211);
INSERT INTO tbl_roles VALUES (1131, 'Manager', 7211);

SELECT * FROM tbl_roles

DROP TABLE	tbl_roles
--------------------------------------------------------
-- TABLE tbl_permissions

CREATE TABLE tbl_account_roles
(
ID INT PRIMARY KEY,
account_id INT,
role_id INT
);

SELECT * FROM tbl_account_roles

DROP TABLE tbl_account_roles
--------------------------------------------------------
-- TABLE tbl_accounts

CREATE TABLE tbl_accounts
(
ID INT PRIMARY KEY,
username varchar(25)	NOT NULL,
password varchar(255)	NOT NULL,
otp INT					NOT NULL,
);


SELECT * FROM tbl_accounts

DROP TABLE dbo.tbl_accounts;

--------------------------------------------------------
-- FOREIGN KEYS

-- Add foreign key to tbl_room
ALTER TABLE tbl_room
ADD CONSTRAINT FK_room_roles
FOREIGN KEY (role_id) REFERENCES tbl_roles(ID);

ALTER TABLE tbl_roles
ADD CONSTRAINT FK_roles_permission
FOREIGN KEY (permission_id) REFERENCES tbl_permissions(ID);







--------------------------------------------------------
-- DELETE FOREIGN KEYS

ALTER TABLE tbl_roles
DROP CONSTRAINT FK_roles_permission;

ALTER TABLE tbl_room
DROP CONSTRAINT FK_room_roles;

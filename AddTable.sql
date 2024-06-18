CREATE DATABASE db_mess;

USE db_mess;

---------------------------------------------------------------------
-- CREATE TABLE & CONSTRAINT

CREATE TABLE tbl_employees
(
    id INT IDENTITY(100,1) PRIMARY KEY,
    first_name VARCHAR(25),
	last_name VARCHAR(25),
    gender VARCHAR(6),
    email VARCHAR(255),
    phone VARCHAR(14),
    hire_date DATE,
    manager INT,
    job INT,
    department INT,
    FOREIGN KEY (manager) REFERENCES tbl_employees(id),
    FOREIGN KEY (job) REFERENCES tbl_jobs(id),
    FOREIGN KEY (department) REFERENCES tbl_departments(id)
);


CREATE TABLE tbl_departments
(
    id INT IDENTITY(11000,1) PRIMARY KEY,
    name_department VARCHAR(30),
    location INT,
    FOREIGN KEY (location) REFERENCES tbl_locations(id)
);


CREATE TABLE tbl_jobs(
    id INT IDENTITY(1000,1) PRIMARY KEY,
    title VARCHAR(255)
);

DROP TABLE tbl_jobs;
DROP TABLE tbl_employees;
DROP TABLE tbl_departments;



CREATE TABLE tbl_regions(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	name_region varchar(25)
);


CREATE TABLE tbl_locations(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	street_address varchar(40),
	postal_code varchar(12),
	city varchar(30),
	state_province varchar(25),
	country char(3),
	FOREIGN KEY (country) REFERENCES tbl_countries(id)
);


CREATE TABLE tbl_countries(
    ID char(3) PRIMARY KEY,
    country_name VARCHAR(50),
	region INT,
	FOREIGN KEY (region) REFERENCES tbl_regions(id)
);


CREATE TABLE tbl_permission(
	ID INT IDENTITY(10000,1) PRIMARY KEY,
	permission_name varchar(100) NOT NULL,
	table_name varchar(100) NOT NULL
);


CREATE TABLE tbl_roles(
	ID INT IDENTITY(10000,1) PRIMARY KEY,
	name varchar(50) NOT NULL,
	permission INT,
	FOREIGN KEY (permission) REFERENCES tbl_permission(ID)
);


CREATE TABLE tbl_room(
	ID INT IDENTITY(1000,1) PRIMARY KEY,
	room_number INT					NOT NULL,
	room_occupancy INT				NOT NULL,
	room_availability varchar(10)	NOT NULL,
	role INT,
	FOREIGN KEY (role) REFERENCES tbl_roles(ID)
);


CREATE TABLE tbl_accounts(
	ID INT PRIMARY KEY,
	username varchar(255)	NOT NULL,
	email varchar(255)		NOT NULL,
	password varchar(255)	NOT NULL,
	otp INT					NOT NULL,
);

DROP TABLE tbl_accounts










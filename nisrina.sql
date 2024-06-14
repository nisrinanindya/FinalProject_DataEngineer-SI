CREATE DATABASE db_mess;

USE db_mess;

CREATE TABLE tbl_room
(
ID INT PRIMARY KEY,
room_number INT,
room_occupancy INT,
room_availability varchar(10),
)


CREATE TABLE tbl_permissions
(
ID INT PRIMARY KEY,
name varchar(100)
)


DROP TABLE dbo.tbl_permission


CREATE TABLE tbl_roles
(
ID INT PRIMARY KEY,
name varchar(50),
)


CREATE TABLE account_roles
(
ID INT PRIMARY KEY,
)


CREATE TABLE tbl_accounts
(
ID INT PRIMARY KEY,
username varchar(25),
password varchar(255),
otp INT,
)
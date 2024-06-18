--------------------------------------------------------
-- FUNCTION

-- Room
CREATE FUNCTION dbo.ValidateRoom(
    @room_number INT,
    @room_occupancy INT,
    @room_availability VARCHAR(10)
)
RETURNS BIT
AS
BEGIN
    DECLARE @isValid BIT;
    SET @isValid = 1; 

    IF @room_occupancy NOT BETWEEN 0 AND 9
    BEGIN
        SET @isValid = 0;
    END

    IF @room_availability NOT IN ('YES', 'NO')
    BEGIN
        SET @isValid = 0;
    END

    RETURN @isValid;
END;

DROP FUNCTION dbo.ValidateRoom



-- Role
CREATE FUNCTION dbo.ValidateRole(
    @name varchar(255)
)
RETURNS BIT
AS
BEGIN
    DECLARE @isValid BIT;
    SET @isValid = 1; 

	IF @name NOT IN ('Super Admin', 'Admin', 'Penjaga Mess', 'Employee')
    BEGIN
        SET @isValid = 0;
    END

    RETURN @isValid;
END;

DROP FUNCTION dbo.ValidateRole



-- Permission
CREATE FUNCTION dbo.ValidatePermission(
    @permission_name varchar(255),
	@table_name varchar(50)
)
RETURNS BIT
AS
BEGIN
    DECLARE @isValid BIT;
    SET @isValid = 1; 

	IF @permission_name NOT IN ('ADD', 'EDIT', 'VIEW')
    BEGIN
        SET @isValid = 0;
    END

	IF @table_name NOT IN ('EMPLOYEE', 'JOB', 'DEPARTMENT', 'LOCATION', 'COUNTRY', 'REGION', 'ROLE', 'PERMISSION')
    BEGIN
        SET @isValid = 0;
    END

    RETURN @isValid;
END;

DROP FUNCTION dbo.ValidatePermission


-- Email
CREATE FUNCTION dbo.ValidateEmail(
	@email VARCHAR(255)
)
RETURNS BIT
AS
BEGIN
    DECLARE @isValid BIT = 0

    DECLARE @emailPattern VARCHAR(255) = '^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,4})$'
    IF (@email NOT LIKE @emailPattern)
    BEGIN
        SET @isValid = 1
    END

    RETURN @isValid
END;

DROP FUNCTION dbo.ValidateEmail


-- password
CREATE FUNCTION dbo.ValidatePassword(
    @password VARCHAR(100)
)
RETURNS BIT
AS
BEGIN
    DECLARE @isValid BIT = 0;
    DECLARE @upperCount INT, @lowerCount INT, @digitCount INT, @symbolCount INT;

    SET @upperCount = 0;
    SET @lowerCount = 0;
    SET @digitCount = 0;
    SET @symbolCount = 0;

    IF LEN(@password) >= 8
    BEGIN
        SET @upperCount = LEN(@password) - LEN(REPLACE(@password, UPPER(@password), ''));
        SET @lowerCount = LEN(@password) - LEN(REPLACE(@password, LOWER(@password), ''));
        SET @digitCount = LEN(@password) - LEN(REPLACE(@password, '1234567890', ''));
        SET @symbolCount = LEN(@password) - LEN(REPLACE(@password, '!@#$%^&*()-_=+[]{};:,.<>?/\\|`~"', ''));

        IF @upperCount >= 1 AND @lowerCount >= 1 AND @digitCount >= 1 AND @symbolCount >= 1
        BEGIN
            SET @isValid = 1;
        END
    END

    RETURN @isValid;
END;

DROP FUNCTION dbo.ValidatePassword


-- Job
CREATE FUNCTION ValidateJob(
    @title varchar(255)
)
RETURNS BIT
AS
BEGIN
    DECLARE @isValid BIT;
    SET @isValid = 1; 

	IF @title LIKE ('%[^A-Za-z ]%')
    BEGIN
        SET @isValid = 0;
    END

    RETURN @isValid;
END;

DROP FUNCTION ValidateJob





-- Employee
CREATE FUNCTION Func_Employee(
    @first_name varchar(255),
	@last_name varchar(255),
	@gender varchar(6),
	@phone varchar(14),
	@hire_date DATE
)
RETURNS BIT
AS
BEGIN
    DECLARE @isValid BIT;
    SET @isValid = 1; 

	IF @first_name NOT LIKE ('%[^A-Za-z ]%')
    BEGIN
        SET @isValid = 0;
    END

	IF @last_name NOT LIKE ('%[^A-Za-z ]%')
    BEGIN
        SET @isValid = 0;
    END

	IF @gender NOT IN ('MALE', 'FEMALE')
    BEGIN
        SET @isValid = 0;
    END

	IF @phone NOT LIKE '%[^0-9]%'
	BEGIN
        SET @isValid = 0;
    END

    BEGIN
        DECLARE @ParsedDate DATE = CAST(@hire_date AS DATE);
        BEGIN
            SET @isValid = 0;
        END
    END
	
    RETURN @isValid;
END;



SELECT *
FROM sys.objects
WHERE name = 'ValidateEmployee';




DROP FUNCTION dbo.Func_Employee
--------------------------------------------------------
-- STORED PROCEDURE ADD

-- Country
CREATE PROCEDURE AddCountries
    @ID CHAR(3),
    @country_name VARCHAR(50),
    @Region INT
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(255);

    -- Validasi ID: harus 3 karakter dan hanya huruf kapital
    IF LEN(@ID) <> 3 OR @ID LIKE '%[^A-Z]%'
    BEGIN
        SET @ErrorMessage = 'Country id Should in the Correct Format!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Validasi CountryName: tidak boleh memuat angka atau karakter
    IF @country_name = '%[^A-Za-z ]%'
    BEGIN
        SET @ErrorMessage = 'Country Name Should in the Correct Format!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Validasi untuk Region: region id harus ada di tabel tbl_regions
    IF NOT EXISTS (SELECT 1 FROM tbl_regions WHERE id = @Region)
    BEGIN
        SET @ErrorMessage = 'Region id not found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Jika semua data valid, masukkan data ke tabel tbl_countries
    INSERT INTO tbl_countries (ID, country_name, region)
    VALUES (@ID, @country_name, @Region);

    RETURN 1;
END;


-- Location
CREATE PROCEDURE AddLocations
    @street_address varchar(40),
	@postal_code varchar(12),
	@city varchar(30),
	@state_province varchar(25),
	@country char(3)
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(255);

    -- Validasi Postal code: hanya memuat angka
    IF @postal_code LIKE '%[^0-9]%'
    BEGIN
        SET @ErrorMessage = 'Postal Code Cannot Contain Text!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

	-- Validasi City: tidak boleh memuat angka dan karakter
    IF @city = '%[^A-Za-z ]%'
    BEGIN
        SET @ErrorMessage = 'City Name Should in the Correct Format!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

	-- Validasi State Province: tidak boleh memuat angka dan karakter
    IF @state_province = '%[^A-Za-z ]%'
    BEGIN
        SET @ErrorMessage = 'State Province Should in the Correct Format!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Validasi Country: country id harus ada di tabel tbl_countries
    IF NOT EXISTS (SELECT 1 FROM tbl_countries WHERE id = @country)
    BEGIN
        SET @ErrorMessage = 'Country id not found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Jika semua data valid, masukkan data ke tabel tbl_locations
    INSERT INTO tbl_locations(street_address, postal_code, city, state_province, country)
    VALUES (@street_address, @postal_code, @city, @state_province, @country);

    RETURN 1;
END;


-- Region
CREATE PROCEDURE AddRegions(
    @name_region varchar(25)
	)
AS
BEGIN
    DECLARE @isValidname_region INT = 1;

	-- Check if region name contains characters or numbers
	IF PATINDEX('%[^a-zA-Z ]%', @name_region) > 0
	SET @isValidname_region = 0; 

	-- Insert only if region name is valid
	IF @isValidname_region = 1 
	BEGIN
    INSERT INTO [dbo].[tbl_regions] (name_region)
    VALUES (@name_region);
	END
	ELSE
	BEGIN

    -- Print error message
    PRINT 'Invalid input: Region Name Should in the Correct Format!.';
    END
END


-- Room
CREATE PROCEDURE AddRoom
    @room_number INT,
	@room_occupancy INT,
	@room_availability varchar(10)
AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(255);

	IF dbo.ValidateRoom(@room_number, @room_occupancy, @room_availability) = 0
    BEGIN
        SET @ErrorMessage = 'Invalid Room Input!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    BEGIN
        INSERT INTO tbl_room (room_number, room_occupancy, room_availability)
        VALUES (@room_number, @room_occupancy, @room_availability);
		RETURN 1;
 	END
	EXEC InsertRoom;
END;


-- Role
CREATE PROCEDURE AddRole
    @name varchar(255)
AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(255);

	IF dbo.ValidateRole(@name) = 0
    BEGIN
        SET @ErrorMessage = 'Invalid Role Input!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    BEGIN
        INSERT INTO tbl_roles (name)
        VALUES (@name);
		RETURN 1;
 	END
END;



-- Permission
CREATE PROCEDURE AddPermission
    @permission_name varchar(255),
	@table_name varchar(50)
AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(255);

	IF dbo.ValidatePermission(@permission_name, @table_name) = 0
    BEGIN
        SET @ErrorMessage = 'Invalid Permission Input!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    BEGIN
        INSERT INTO tbl_permission(permission_name, table_name)
        VALUES (@permission_name, @table_name);
		RETURN 1;
 	END
END;

DROP PROC AddPermission
EXEC AddPermission @permission_name = 'EDIT', @table_name= 'JOB';
SELECT * FROM tbl_permission


-- Login
CREATE PROCEDURE sp_Login
    @email VARCHAR(255),
    @password VARCHAR(255)
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(255);

    IF dbo.ValidateEmail (@email) = 0
	BEGIN
        SET @ErrorMessage = 'Invalid Input for Email!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

	IF dbo.ValidatePassword (@password) = 0
	BEGIN
        SET @ErrorMessage = 'Invalid Input for Password!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END    

    BEGIN
        INSERT INTO tbl_accounts(email, password)
        VALUES (@email, @password);
		RETURN 1;
 	END
END;

EXEC sp_Login @email = janedoe1@gmail, @password = JaneDoe1;

DROP PROCEDURE sp_Login

SELECT * FROM tbl_accounts

SELECT dbo.ValidatePassword('JaneDoe1!')



-- Job
CREATE PROCEDURE AddJob(
    @title VARCHAR(255)
)
AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(255);

	IF dbo.ValidateJob(@title) = 0
    BEGIN
        SET @ErrorMessage = 'Invalid Job Input!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    BEGIN
        INSERT INTO tbl_jobs (title)
        VALUES (@title);
		RETURN 1;
 	END
END;

SELECT dbo.ValidateJob('Manager')

EXEC AddJob @title = 'Manager';



-- Employee
CREATE PROCEDURE AddEmployee(
    @first_name varchar(255),
	@last_name varchar(255),
	@gender varchar(6),
	@phone varchar(14),
	@hire_date DATE
)
AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(255);

	IF dbo.Func_Employee(@first_name, @last_name, @gender, @phone, @hire_date) = 0
    BEGIN
        SET @ErrorMessage = 'Invalid Input!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END;


    BEGIN
        INSERT INTO tbl_employees (first_name, last_name, gender, phone, hire_date)
        VALUES (@first_name, @last_name, @gender, @phone, @hire_date);
		RETURN 1;
 	END
END;




EXEC AddEmployee @first_name = 'John', @last_name = 'Doe', @gender = 'MALE', @phone = '12345', @hire_date = '2023-12-12';

SELECT * FROM Func_Employee('John', 'Doe', 'MALE', '1234567890', '2023-06-18');


DROP PROCEDURE AddJob

EXEC AddRoom @room_number = 100, @room_occupancy = 9, @room_availability = 'YES';

DELETE FROM tbl_room




--------------------------------------------------------
-- STORED PROCEDURE EDIT


-- Country
CREATE PROCEDURE EditCountries
	@ID CHAR(3),
    @country_name VARCHAR(50),
    @Region INT
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(255);

-- Validasi ID: country id harus ada di tbl_countries
    IF NOT EXISTS (SELECT 1 FROM tbl_countries WHERE id = @ID)
    BEGIN
        SET @ErrorMessage = 'country id not found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Validasi New CountryName: tidak boleh memuat angka atau karakter
    IF @country_name = '%[^A-Za-z ]%'
    BEGIN
        SET @ErrorMessage = 'Country Name Should in the Correct Format!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Validasi New Region: region id harus ada di tabel tbl_regions
    IF NOT EXISTS (SELECT 1 FROM tbl_regions WHERE id = @Region)
    BEGIN
        SET @ErrorMessage = 'Region id not found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Jika semua data valid, ubah data di tabel tbl_locations
	UPDATE tbl_countries
    SET country_name = @country_name, region = @Region
    WHERE id = @ID;

    RETURN 1;
END;


-- Location
CREATE PROCEDURE EditLocations
	@ID INT,
    @street_address varchar(40),
	@postal_code varchar(12),
	@city varchar(30),
	@state_province varchar(25),
	@country char(3)
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(255);

	-- Validasi ID: Location id harus ada di tabel tbl_locations
    IF NOT EXISTS (SELECT 1 FROM tbl_locations WHERE id = @ID)
    BEGIN
        SET @ErrorMessage = 'Location id not found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Validasi New Postal code: hanya memuat angka
    IF @postal_code LIKE '%[^0-9]%'
    BEGIN
        SET @ErrorMessage = 'Postal Code Cannot Contain Text!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

	-- Validasi New City: tidak boleh memuat angka dan karakter
    IF @city = '%[^A-Za-z ]%'
    BEGIN
        SET @ErrorMessage = 'City Name Should in the Correct Format!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

	-- Validasi New State Province: tidak boleh memuat angka dan karakter
    IF @state_province = '%[^A-Za-z ]%'
    BEGIN
        SET @ErrorMessage = 'State Province Should in the Correct Format!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Validasi New Country: country id harus ada di tabel tbl_countries
    IF NOT EXISTS (SELECT 1 FROM tbl_countries WHERE id = @country)
    BEGIN
        SET @ErrorMessage = 'Country id not found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Jika semua data valid, ubah data di tabel tbl_locations
	UPDATE tbl_locations
    SET street_address = @street_address, postal_code = @postal_code, city = @city, state_province = @state_province, country = @country
    WHERE id = @ID;

    RETURN 1;
END;


-- Region
CREATE PROCEDURE EditRegions
	@ID INT,
    @name_region varchar(25)
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(255);

	-- Validasi ID: region id harus ada di tabel tbl_regions
    IF NOT EXISTS (SELECT 1 FROM tbl_regions WHERE id = @ID)
    BEGIN
        SET @ErrorMessage = 'Region id not Found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Validasi New RegionName: tidak boleh memuat angka atau karakter
    IF @name_region = '%[^A-Za-z ]%'
    BEGIN
        SET @ErrorMessage = 'Region Name Should in the Correct Format!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Jika semua data valid, ubah data di tabel tbl_countries
	UPDATE tbl_regions
    SET name_region = @name_region
    WHERE id = @ID;

    RETURN 1;
END;


-- Room
CREATE PROCEDURE EditRoom
	@ID INT,
	@room_number INT,
	@room_occupancy INT,
	@room_availability varchar(10)
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(255);

	-- Validasi ID
    IF NOT EXISTS (SELECT 1 FROM tbl_room WHERE ID = @ID)
    BEGIN
        SET @ErrorMessage = 'Room ID not Found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

	IF dbo.ValidateRoom(@room_number, @room_occupancy, @room_availability) = 0
    BEGIN
        SET @ErrorMessage = 'Invalid Room Input!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Jika semua data valid, ubah data di tabel tbl_room
	UPDATE tbl_room
    SET room_number = @room_number, room_occupancy = @room_occupancy, room_availability = @room_availability
    WHERE ID = @ID;
    RETURN 1;
END;



-- Role
CREATE PROCEDURE EditRole
	@ID INT,
	@name varchar(255)
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(255);

	-- Validasi ID
    IF NOT EXISTS (SELECT 1 FROM tbl_roles WHERE ID = @ID)
    BEGIN
        SET @ErrorMessage = 'Role ID not Found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

	IF dbo.ValidateRole(@name) = 0
    BEGIN
        SET @ErrorMessage = 'Invalid Role Input!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Jika semua data valid, ubah data di tabel tbl_roles
	UPDATE tbl_roles
    SET name = @name,
    WHERE ID = @ID;
    RETURN 1;
END;



-- Permission
CREATE PROCEDURE EditPermission
	@ID INT,
	@permission_name varchar(100),
	@table_name varchar (100)
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(255);

	-- Validasi ID
    IF NOT EXISTS (SELECT 1 FROM tbl_permission WHERE ID = @ID)
    BEGIN
        SET @ErrorMessage = 'Permission ID not Found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

	IF dbo.ValidatePermission(@permission_name, @table_name) = 0
    BEGIN
        SET @ErrorMessage = 'Invalid Permission Input!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Jika semua data valid, ubah data di tabel tbl_permission
	UPDATE tbl_permission
    SET permission_name = @permission_name, table_name = @table_name
    WHERE ID = @ID;
    RETURN 1;
END;




-- Job
CREATE PROCEDURE EditJob(
	@id INT,
	@title varchar(30)
)
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(255);

	-- Validasi ID
    IF NOT EXISTS (SELECT 1 FROM tbl_jobs WHERE id = @id)
    BEGIN
        SET @ErrorMessage = 'Job id not Found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

	IF dbo.ValidateJob(@title) = 0
    BEGIN
        SET @ErrorMessage = 'Invalid Permission Input!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Jika semua data valid, ubah data di tabel tbl_jobs
	UPDATE tbl_jobs
    SET title = @title
    WHERE id = @id;
    RETURN 1;
END;



-- Employee
CREATE PROCEDURE EditEmployee(
	@id INT,
    @first_name varchar(255),
	@last_name varchar(255),
	@gender varchar(6),
	@phone varchar(14),
	@hire_date DATE
)
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(255);

	-- Validasi ID
    IF NOT EXISTS (SELECT 1 FROM tbl_jobs WHERE id = @id)
    BEGIN
        SET @ErrorMessage = 'Employee id not Found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

	IF dbo.Func_Employee(@first_name, @last_name, @gender, @phone, @hire_date) = 0
    BEGIN
        SET @ErrorMessage = 'Invalid Permission Input!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
    END

    -- Jika semua data valid, ubah data di tabel tbl_jobs
	UPDATE tbl_employees
    SET @first_name = first_name, @last_name = last_name, @gender = gender, @phone = phone, @hire_date = hire_date
    WHERE id = @id;
    RETURN 1;
END;







DROP PROCEDURE EditPermission




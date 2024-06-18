--------------------------------------------------------
-- STORED PROCEDURE DELETE


-- Room
CREATE PROCEDURE sp_DeleteRoom
    @ID INT
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(255);

    IF NOT EXISTS (SELECT 1 FROM tbl_room WHERE ID = @ID)
    BEGIN
		SET @ErrorMessage = 'ID not found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
	END
	-- Jika ID valid, hapus data di tabel locations
    DELETE FROM tbl_room
    WHERE ID = @ID;
END;



-- Role
CREATE PROCEDURE sp_DeleteRole
    @ID INT
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(255);

    IF NOT EXISTS (SELECT 1 FROM tbl_roles WHERE ID = @ID)
    BEGIN
		SET @ErrorMessage = 'ID not found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
	END
	-- Jika ID valid, hapus data di tabel roles
    DELETE FROM tbl_roles
    WHERE ID = @ID;
END;


-- Permission
CREATE PROCEDURE sp_DeletePermission
    @ID INT
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(255);

    IF NOT EXISTS (SELECT 1 FROM tbl_permission WHERE ID = @ID)
    BEGIN
		SET @ErrorMessage = 'ID not found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
	END
	-- Jika ID valid, hapus data di tabel permission
    DELETE FROM tbl_permission
    WHERE ID = @ID;
END;



-- Job
CREATE PROCEDURE sp_DeleteJob
    @id INT
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(255);

    IF NOT EXISTS (SELECT 1 FROM tbl_jobs WHERE id = @id)
    BEGIN
		SET @ErrorMessage = 'ID not found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
	END
	-- Jika ID valid, hapus data di tabel permission
    DELETE FROM tbl_jobs
    WHERE id = @id;
END;



-- Employee
CREATE PROCEDURE sp_DeleteEmployee
    @id INT
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(255);

    IF NOT EXISTS (SELECT 1 FROM tbl_employees WHERE id = @id)
    BEGIN
		SET @ErrorMessage = 'ID not found!';
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN 0;
	END
	-- Jika ID valid, hapus data di tabel permission
    DELETE FROM tbl_employees
    WHERE id = @id;
END;



EXEC sp_DeleteRoom @ID = 1000

SELECT * FROM tbl_room

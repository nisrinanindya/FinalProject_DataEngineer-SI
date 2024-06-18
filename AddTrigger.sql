--------------------------------------------------------
-- TRIGGER

-- Add Room
CREATE TRIGGER InsertRoom ON tbl_room
	AFTER INSERT
AS
BEGIN
    PRINT 'Room added.';
END;

DROP TRIGGER InsertRoom


-- Add Role
CREATE TRIGGER InsertRole ON tbl_roles
	AFTER INSERT
AS
BEGIN
    PRINT 'Role added.';
END;

DROP TRIGGER InsertRole


-- Add Permission
CREATE TRIGGER InsertPermission ON tbl_permission
	AFTER INSERT
AS
BEGIN
    PRINT 'Permission added.';
END;

DROP TRIGGER InsertPermission


-- Delete Room
CREATE TRIGGER DeleteRoom ON tbl_room
	AFTER DELETE
AS
BEGIN
    PRINT 'Room Deleted.';
END;

DROP TRIGGER DeleteRoom


-- Delete Role
CREATE TRIGGER DeleteRole ON tbl_roles
	AFTER DELETE
AS
BEGIN
    PRINT 'Role deleted.';
END;

DROP TRIGGER DeleteRole


-- Delete Permission
CREATE TRIGGER DeletePermission ON tbl_permission
	AFTER DELETE
AS
BEGIN
    PRINT 'Permission deleted.';
END;

DROP TRIGGER DeletePermission


-- Update Room
CREATE TRIGGER UpdateRoom ON tbl_room
	AFTER UPDATE
AS
BEGIN
    PRINT 'Room Updated.';
END;

DROP TRIGGER UpdateRoom


-- Update Role
CREATE TRIGGER UpdateRole ON tbl_roles
	AFTER UPDATE
AS
BEGIN
    PRINT 'Role Updated.';
END;

DROP TRIGGER UpdateRole


-- Update Permission
CREATE TRIGGER UpdatePermission ON tbl_permission
	AFTER UPDATE
AS
BEGIN
    PRINT 'Room Updated.';
END;

DROP TRIGGER UpdatePermission


SELECT * FROM sys.triggers 






EXEC AddRoom @room_number = 111, @room_occupancy = 12, @room_availability = 'YES';

DROP TRIGGER InsertRoom

SELECT * FROM tbl_room

-- Add Role




-- Update Room




-- Update Role




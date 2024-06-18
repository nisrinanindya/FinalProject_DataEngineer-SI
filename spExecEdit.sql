--------------------------------------------------------
-- STORED PROCEDURE EXEC

-- Country
DECLARE @Result INT;

EXEC @Result = EditCountries @ID = IDN, @country_name = 'Indonesia', @Region = '2';

IF @Result = 1
    PRINT 'Data successfully changed';
ELSE
    PRINT 'Data failed to be changed';


-- Location
DECLARE @Result INT;

EXEC @Result = EditLocations @ID = 1, @street_address = 'Jl. Diponegoro No.22', @postal_code = '40115', @city = 'Bandung', @state_province = 'Jawa Barat', @country = 'IDN';

IF @Result = 1
    PRINT 'Data successfully changed';
ELSE
    PRINT 'Data failed to be changed';


-- Region
DECLARE @Result INT;

EXEC @Result = EditRegions @ID = 2, @name_region = 'Africa';

IF @Result = 1
    PRINT 'Data successfully changed';
ELSE
    PRINT 'Data failed to be changed';


-- Room
DECLARE @Result INT;

EXEC @Result = EditRoom @ID = 1005, @room_number = 101, @room_occupancy = 9, @room_availability = 'YES';

IF @Result = 1
    PRINT 'Data successfully changed';
ELSE
    PRINT 'Data failed to be changed';


-- Role
DECLARE @Result INT;

EXEC @Result = EditRole @ID = 1005, @name = 101;

IF @Result = 1
    PRINT 'Data successfully changed';
ELSE
    PRINT 'Data failed to be changed';


-- Permission
DECLARE @Result INT;

EXEC @Result = EditPermission @ID = 1005, @permission_name = 101, @table_name = 9;

IF @Result = 1
    PRINT 'Data successfully changed';
ELSE
    PRINT 'Data failed to be changed';


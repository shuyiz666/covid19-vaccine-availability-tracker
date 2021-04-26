-- StoreBrand --
GO
CREATE OR ALTER PROCEDURE Pro_insert_StoreBrand
    @StoreBrandName VARCHAR(32)
AS
BEGIN
    INSERT INTO StoreBrand (StoreBrandId,StoreBrandName)
    VALUES (NEXT VALUE FOR StoreBrand_Seq, @StoreBrandName)
END;

-- City --
GO
CREATE OR ALTER PROCEDURE Pro_insert_City
    @CityName VARCHAR(32)
AS
BEGIN
    INSERT INTO City (CityId,CityName)
    VALUES (NEXT VALUE FOR City_Seq, @CityName)
END;

-- State --
GO
CREATE OR ALTER PROCEDURE Pro_insert_State
    @StateName VARCHAR(32)
AS
BEGIN
    INSERT INTO State (StateId,StateName)
    VALUES (NEXT VALUE FOR State_Seq, @StateName)
END;

-- ZipCode --
GO
CREATE OR ALTER PROCEDURE Pro_insert_ZipCode
    @ZipCode VARCHAR(5),
    @StateId NUMERIC(10),
    @CityId NUMERIC(10)
AS
BEGIN
    INSERT INTO ZipCode (ZipCodeId, ZipCode, StateId, CityId)
    VALUES (NEXT VALUE FOR ZipCode_Seq, @ZipCode, @StateId, @CityId)
END;

-- Address --
GO
CREATE OR ALTER PROCEDURE Pro_insert_Address
    @AddressId VARCHAR(32),
    @Address   VARCHAR(80)
AS
BEGIN
    INSERT INTO Address (AddressId, Address)
    VALUES (@AddressId, @Address)
END;


-- Store --
GO
CREATE OR ALTER PROCEDURE Pro_insert_Store
    @StoreBrandId NUMERIC(10),
    @AddressId    VARCHAR(32),
    @ZipCodeId    NUMERIC(10)
AS
BEGIN
    INSERT INTO Store (StoreId, StoreBrandId, AddressId, ZipCodeId)
    VALUES (NEXT VALUE FOR Store_Seq, @StoreBrandId, @AddressId, @ZipCodeId)
END;

-- Status
GO
CREATE OR ALTER PROCEDURE Pro_insert_Status
    @StatusName   VARCHAR(32)
AS
BEGIN
    INSERT INTO Status (StatusId, StatusName)
    VALUES (NEXT VALUE FOR Status_Seq, @StatusName)
END;

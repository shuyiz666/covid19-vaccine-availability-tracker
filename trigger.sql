CREATE OR ALTER TRIGGER insert_trg
ON Raw
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @StoreId            NUMERIC(10),
            @StoreBrandId       NUMERIC(10),
            @StatusId           NUMERIC(10),
            @CityId             NUMERIC(10),
            @StateId            NUMERIC(10),
            @ZipCodeId          NUMERIC(10),

            @StoreBrandName     VARCHAR(32),
            @AddressId          VARCHAR(32),
            @Address            VARCHAR(80),
            @CityName           VARCHAR(32),
            @StateName          VARCHAR(32),
            @ZipCode            VARCHAR(5),
            @StatusName         VARCHAR(32)

    SET @StoreBrandName = (SELECT inserted.Store FROM inserted)
    SET @AddressId = (SELECT inserted.AddressId FROM inserted)
    SET @Address = (SELECT inserted.Address FROM inserted)
    SET @CityName = (SELECT inserted.City FROM inserted)
    SET @StateName = (SELECT inserted.State FROM inserted)
    SET @ZipCode = (SELECT inserted.ZipCode FROM inserted)
    SET @StatusName = (SELECT inserted.Availability FROM inserted)

    -- insert StoreBrand
    SET @StoreBrandId = (SELECT dbo.getStoreBrandId(@StoreBrandName))
    If @StoreBrandId IS NULL
        BEGIN
            EXEC Pro_insert_StoreBrand @StoreBrandName;
            SET @StoreBrandId = dbo.getStoreBrandId(@StoreBrandName);
        END;

    -- insert City
    SET @CityId = (SELECT dbo.getCityId(@CityName));
    If @CityId IS NULL
        BEGIN
            EXEC Pro_insert_City @CityName;
            SET @CityId = (SELECT dbo.getCityId(@CityName));
        END;

    -- insert State
    SET @StateId = (SELECT dbo.getStateId(@StateName));
    If @StateId IS NULL
        BEGIN
            EXEC Pro_insert_State @StateName;
            SET @StateId = (SELECT dbo.getStateId(@StateName));
        END;

    -- insert ZipCode
    SET @ZipCodeId = (SELECT dbo.getZipCodeId(@ZipCode, @StateId, @CityId));
    If @ZipCodeId IS NULL
        BEGIN
            EXEC Pro_insert_ZipCode @ZipCode, @StateId, @CityId;
            SET @ZipCodeId = (SELECT dbo.getZipCodeId(@ZipCode, @StateId, @CityId));
        END;

    -- insert Address
    If (SELECT AddressId FROM Address WHERE AddressId = @AddressId) IS NULL
        BEGIN
            EXEC Pro_insert_Address @AddressId, @Address;
        END;

    -- insert Store
    SET @StoreId = (SELECT dbo.getStoreId(@StoreBrandId, @AddressId, @ZipCodeId));
    If @StoreId IS NULL
        BEGIN
            EXEC Pro_insert_Store @StoreBrandId, @AddressId, @ZipCodeId;
            SET @StoreId = (SELECT dbo.getStoreId(@StoreBrandId, @AddressId, @ZipCodeId));
        END;

    -- insert Status
    SET @StatusId = (SELECT dbo.getStatusId(@StatusName))
    If @StatusId IS NULL
        BEGIN
            EXEC Pro_insert_Status @StatusName;
            SET @StatusId = (SELECT dbo.getStatusId(@StatusName));
        END;

    INSERT INTO History(HistoryId, CreateTime, StoreId, StatusId)
    VALUES (NEXT VALUE FOR History_Seq, GETDATE(), @StoreId, @StatusId)
END;
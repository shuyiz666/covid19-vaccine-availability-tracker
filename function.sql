-- get the StoreBrandId from StoreBrandName
GO
CREATE OR ALTER FUNCTION getStoreBrandId(
    @StoreBrandName VARCHAR(32)
)
RETURNS NUMERIC(10)
AS
BEGIN
    DECLARE @StoreBrandId NUMERIC(10)
    SET @StoreBrandId = (SELECT StoreBrandId FROM StoreBrand WHERE StoreBrandName = @StoreBrandName)
    RETURN @StoreBrandId
END;

-- get the CityId from CityName
GO
CREATE OR ALTER FUNCTION getCityId(
    @CityName VARCHAR(32)
)
RETURNS NUMERIC(10)
AS
BEGIN
    DECLARE @CityId NUMERIC(10)
    SET @CityId = (SELECT CityId FROM City WHERE CityName = @CityName)
    RETURN @CityId
END;

-- get the StateId from StateName
GO
CREATE OR ALTER FUNCTION getStateId(
    @StateName VARCHAR(32)
)
RETURNS NUMERIC(10)
AS
BEGIN
    DECLARE @StateId NUMERIC(10)
    SET @StateId = (SELECT StateId FROM State WHERE StateName = @StateName)
    RETURN @StateId
END;

-- get the ZipCodeId from ZipCode
GO
CREATE OR ALTER FUNCTION getZipCodeId(
    @ZipCode NUMERIC(5),
    @StateId NUMERIC(10),
    @CityId  NUMERIC(10)
)
RETURNS NUMERIC(10)
AS
BEGIN
    DECLARE @ZipCodeId NUMERIC(10)
    SET @ZipCodeId = (SELECT ZipCodeId FROM ZipCode WHERE ZipCode = @ZipCode AND StateId = @StateId AND CityId = @CityId)
    RETURN @ZipCodeId
END

-- get the ZipCodeId from ZipCode
GO
CREATE OR ALTER FUNCTION getZipCodeId(
    @ZipCode NUMERIC(5),
    @StateId NUMERIC(10),
    @CityId  NUMERIC(10)
)
RETURNS NUMERIC(10)
AS
BEGIN
    DECLARE @ZipCodeId NUMERIC(10)
    SET @ZipCodeId = (SELECT ZipCodeId FROM ZipCode WHERE ZipCode = @ZipCode AND StateId = @StateId AND CityId = @CityId)
    RETURN @ZipCodeId
END

-- get the StoreId from Store
GO
CREATE OR ALTER FUNCTION getStoreId(
    @StoreBrandId NUMERIC(10),
    @AddressId VARCHAR(32),
    @ZipCodeId NUMERIC(10)
)
RETURNS NUMERIC(10)
AS
BEGIN
    DECLARE @StoreId NUMERIC(10)
    SET @StoreId = (SELECT StoreId FROM Store WHERE AddressId = @AddressId AND ZipCodeId = @ZipCodeId)
    RETURN @StoreId
END;

-- get the StatusId from Status
GO
CREATE OR ALTER FUNCTION getStatusId(
    @StatusName VARCHAR(32)
)
RETURNS NUMERIC(10)
AS
BEGIN
    DECLARE @StatusId NUMERIC(10)
    SET @StatusId = (SELECT StatusId FROM Status WHERE StatusName = @StatusName)
    RETURN @StatusId
END;

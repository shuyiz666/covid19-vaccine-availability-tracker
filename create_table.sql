CREATE DATABASE Cov_vaccine;

CREATE TABLE City(
	CityId		numeric(10)	NOT NULL,
	CityName	varchar(32)	NOT NULL,
	CONSTRAINT City_CityId_PK PRIMARY KEY (CityId)
);

CREATE TABLE State(
	StateId		numeric(10)	NOT NULL,
	StateName	varchar(32)	NOT NULL,
	CONSTRAINT State_StateId_PK PRIMARY KEY (StateId)
);

CREATE TABLE ZipCode(
	ZipCodeId	numeric(10)	NOT NULL,
	ZipCode		varchar(5)	NOT NULL,
	StateId		numeric(10)  NOT NULL,
	CityId		numeric(10) NOT NULL,
	CONSTRAINT ZipCode_ZipCodeId_PK PRIMARY KEY (ZipCodeId),
	CONSTRAINT ZipCode_StateId_FK FOREIGN KEY (StateId) REFERENCES State(StateId),
	CONSTRAINT ZipCode_CityId_FK FOREIGN KEY (CityId) REFERENCES City(CityId)
);

CREATE TABLE StoreBrand(
	StoreBrandId		numeric(10) NOT NULL,
	StoreBrandName 		varchar(32) NOT NULL,
	CONSTRAINT StoreBrand_StoreBrandId_PK PRIMARY KEY (StoreBrandId)
);

CREATE TABLE Address(
	AddressId		varchar(32) NOT NULL,
	Address         varchar(80) NOT NULL,
	CONSTRAINT Address_AddressId_PK PRIMARY KEY (AddressId)
);

CREATE TABLE Store(
	StoreId			numeric(10) NOT NULL,
	StoreBrandId 	numeric(10) NOT NULL,
	AddressId 		varchar(32) NOT NULL,
	ZipCodeId       numeric(10) NOT NULL,
	CONSTRAINT Store_StoreId_PK PRIMARY KEY (StoreId),
	CONSTRAINT Store_StoreBrandId_FK FOREIGN KEY (StoreBrandId) REFERENCES StoreBrand(StoreBrandId),
	CONSTRAINT Store_ZipCodeId_FK FOREIGN KEY (ZipCodeId) REFERENCES ZipCode(ZipCodeId),
	CONSTRAINT Store_AddressId_FK FOREIGN KEY (AddressId) REFERENCES Address(AddressId)
);

CREATE TABLE Status(
	StatusId	numeric(10) NOT NULL,
	StatusName 	varchar(32) NOT NULL,
	CONSTRAINT Status_StatusId_PK PRIMARY KEY (StatusId)
);

CREATE TABLE History(
	HistoryId	numeric(10) NOT NULL,
	CreateTime 	DATETIME NOT NULL,
	StoreId     numeric(10) NOT NULL,
	StatusId    numeric(10) NOT NULL,
	CONSTRAINT History_HistoryId_PK PRIMARY KEY (HistoryId),
	CONSTRAINT History_StoreId_FK FOREIGN KEY (StoreId) REFERENCES Store(StoreId),
	CONSTRAINT History_StatusId_FK FOREIGN KEY (StatusId) REFERENCES Status(StatusId)
);

CREATE TABLE Raw(
    CreateTime   DATETIME,
    Store        varchar(32),
    AddressId    varchar(32),
    Address      varchar(80),
    City         varchar(32),
    State        varchar(32),
    ZipCode      varchar(32),
    Availability varchar(32)
);

CREATE TABLE BI(
    CreateTime     DATETIME,
    Store          varchar(32),
    State          varchar(32),
    City           varchar(32),
    Availability   varchar(32)
)
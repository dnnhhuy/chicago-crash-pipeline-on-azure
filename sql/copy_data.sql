CREATE TABLE FactCrash
WITH (
    CLUSTERED COLUMNSTORE INDEX,
    DISTRIBUTION = HASH([date_id])
)
AS
SELECT * FROM ExtFactCrash

CREATE TABLE DimTime
WITH (
    CLUSTERED INDEX (time_id),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtDimTime

CREATE TABLE DimDate
WITH (
    CLUSTERED INDEX (date_id),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtDimDate

CREATE TABLE DimLocation
WITH (
    CLUSTERED INDEX (location_id),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtDimLocation

CREATE TABLE RoadCondMiniDim
WITH (
    CLUSTERED INDEX (location_id, road_cond_key),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtRoadCondMiniDim

CREATE TABLE ControlDeviceCondMiniDim
WITH (
    CLUSTERED INDEX (location_id, device_cond_key),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtControlDeviceCondMiniDim

CREATE TABLE DimRoadCond
WITH (
    CLUSTERED INDEX (road_cond_key),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtDimRoadCond

CREATE TABLE DimControlDeviceCond
WITH (
    CLUSTERED INDEX (device_cond_key),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtDimControlDeviceCond

CREATE TABLE BridgeVehicleGroup
WITH (
    CLUSTERED INDEX (vehicle_group_key, vehicle_id),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtBridgeVehicleGroup

CREATE TABLE DimVehicle
WITH (
    CLUSTERED INDEX (vehicle_id),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtDimVehicle

CREATE TABLE DimCollision
WITH (
    CLUSTERED INDEX (collision_type_id),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtDimCollision

CREATE TABLE DimReportType
WITH (
    CLUSTERED INDEX (report_type_id),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtDimReportType

CREATE TABLE BridgePersonGroup
WITH (
    CLUSTERED INDEX (person_group_key, person_id),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtBridgePersonGroup

CREATE TABLE DimPerson
WITH (
    CLUSTERED INDEX (person_id),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtDimPerson

CREATE TABLE DimWeather
WITH (
    CLUSTERED INDEX (weather_id),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtDimWeather

CREATE TABLE DimJunk
WITH (
    CLUSTERED INDEX (junk_id),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtDimJunk

CREATE TABLE DimCause
WITH (
    CLUSTERED INDEX (cause_id),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtDimCause

CREATE TABLE DimCrashType
WITH (
    CLUSTERED INDEX (crash_type_id),
    DISTRIBUTION = REPLICATE
)
AS
SELECT * FROM ExtDimCrashType

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtFactCrash')
DROP EXTERNAL TABLE [ExtFactCrash];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtDimTime')
DROP EXTERNAL TABLE [ExtDimTime];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtDimDate')
DROP EXTERNAL TABLE [ExtDimDate];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtDimLocation')
DROP EXTERNAL TABLE [ExtDimLocation];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtRoadCondMiniDim')
DROP EXTERNAL TABLE [ExtRoadCondMiniDim];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtControlDeviceCondMiniDim')
DROP EXTERNAL TABLE [ExtControlDeviceCondMiniDim];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtDimRoadCond')
DROP EXTERNAL TABLE [ExtDimRoadCond];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtDimControlDeviceCond')
DROP EXTERNAL TABLE [ExtDimControlDeviceCond];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtBridgeVehicleGroup')
DROP EXTERNAL TABLE [ExtBridgeVehicleGroup];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtDimVehicle')
DROP EXTERNAL TABLE [ExtDimVehicle];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtDimCollision')
DROP EXTERNAL TABLE [ExtDimCollision];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtDimReportType')
DROP EXTERNAL TABLE [ExtDimReportType];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtBridgePersonGroup')
DROP EXTERNAL TABLE [ExtBridgePersonGroup];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtDimPerson')
DROP EXTERNAL TABLE [ExtDimPerson];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtDimWeather')
DROP EXTERNAL TABLE [ExtDimWeather];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtDimJunk')
DROP EXTERNAL TABLE [ExtDimJunk];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtDimCause')
DROP EXTERNAL TABLE [ExtDimCause];

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExtDimCrashType')
DROP EXTERNAL TABLE [ExtDimCrashType];


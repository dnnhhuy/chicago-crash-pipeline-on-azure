CREATE MASTER KEY ENCRYPTION BY PASSWORD = '';
GO

CREATE DATABASE SCOPED CREDENTIAL [ADLS_Credential]
WITH IDENTITY = 'SHARE ACCESS SIGNATURE'
SECRET = '';
GO

IF NOT EXISTS(SELECT * FROM sys.external_file_formats WHERE name = 'DeltaFormat')
    CREATE EXTERNAL FILE FORMAT [DeltaFormat]
    WITH (FORMAT_TYPE = DELTA)

IF NOT EXISTS(SELECT * FROM sys.external_file_formats WHERE name = 'DataSource')
    CREATE EXTERNAL DATA SOURCE [DataSource]
    WITH (
        LOCATION = '<INSERT abfss://  DATA SOURCE LOCATION>',
        CREDENTIAL = [ADLS_Credential]
    )

GO

CREATE EXTERNAL TABLE ExtDimTime
(   [time_id] VARCHAR(512),
    [hour] INT,
    [minute] INT,
    [second] INT)
WITH (
    LOCATION = '/serving/dim_time',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
);

CREATE EXTERNAL TABLE ExtDimDate
(   
    [date_id] VARCHAR(512),
    [day] INT,
    [dayOfWeek] INT,
    [week] INT,
    [month] INT,
    [year] INT,
    [quarter] INT)
WITH (
    LOCATION = '/serving/dim_date',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
);

CREATE EXTERNAL TABLE ExtDimLocation
(
    [location_id] VARCHAR(512),
    [street_no] VARCHAR(512),
    [street_direction] VARCHAR(512),
    [street_name] VARCHAR(512),
    [alignment] VARCHAR(512),
    [posted_speed_limit] VARCHAR(512),
    [trafficway_type] VARCHAR(512),
    [longtitude] VARCHAR(512),
    [latitude] VARCHAR(512)
)
WITH (
    LOCATION = 'serving/dim_location',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
);


CREATE EXTERNAL TABLE ExtDimRoadCond
(
    [road_cond_key] VARCHAR(512),
    [roadway_surface_cond] VARCHAR(512),
    [road_defect] VARCHAR(512)
)
WITH (
    LOCATION = 'serving/dim_road_cond',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
);

CREATE EXTERNAL TABLE ExtDimControlDeviceCond
(
    [device_cond_key] VARCHAR(512),
    [traffic_control_device] VARCHAR(512),
    [device_condition] VARCHAR(512)
)
WITH (
    LOCATION = 'serving/dim_control_device_cond',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
);

CREATE EXTERNAL TABLE ExtRoadCondMiniDim
(
    [location_id] VARCHAR(512),
    [road_cond_key] VARCHAR(512),
    [start_date] VARCHAR(512),
    [end_date] VARCHAR(512)
)
WITH (
    LOCATION = 'serving/road_cond_mini_dim',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
);

CREATE EXTERNAL TABLE ExtControlDeviceCondMiniDim
(
    [location_id] VARCHAR(512),
    [device_cond_key] VARCHAR(512),
    [start_date] VARCHAR(512),
    [end_date] VARCHAR(512)
)
WITH (
    LOCATION = 'serving/control_device_cond_mini_dim',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
);

CREATE EXTERNAL TABLE ExtBridgeVehicleGroup
(
    [vehicle_group_key] VARCHAR(512),
    [vehicle_id] VARCHAR(512)
)
WITH (
    LOCATION = 'serving/bridge_vehicle_group',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
);

CREATE EXTERNAL TABLE ExtDimVehicle
(
    [vehicle_id] VARCHAR(512),
    [num_passengers] VARCHAR(512),
    [make] VARCHAR(512),
    [model] VARCHAR(512),
    [lic_plate_state] VARCHAR(512),
    [vehicle_year] VARCHAR(512),
    [vehicle_defect] VARCHAR(512),
    [vehicle_type] VARCHAR(512),
    [vehicle_use] VARCHAR(512),
    [travel_direction] VARCHAR(512),
    [maneuver] VARCHAR(512),
    [towed_i] VARCHAR(512),
    [fire_i] VARCHAR(512),
    [occupant_cnt] VARCHAR(512),
    [towed_by] VARCHAR(512),
    [towed_to] VARCHAR(512),
    [first_contact_point] VARCHAR(512),
    [commercial_src] VARCHAR(512),
    [carrier_name] VARCHAR(512),
    [carrier_state] VARCHAR(512),
    [carrier_city] VARCHAR(512),
    [total_vehicle_length] VARCHAR(512),
    [axle_cnt] VARCHAR(512),
    [vehicle_config] VARCHAR(512),
    [cargo_body_type] VARCHAR(512),
    [load_type] VARCHAR(512)
)
WITH (
    LOCATION = 'serving/dim_vehicle',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
);


CREATE EXTERNAL TABLE ExtDimCollision
(
    [collision_type_id] VARCHAR(512),
    [collision_type] VARCHAR(512)
)
WITH (
    LOCATION = 'serving/dim_collision',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
);

CREATE EXTERNAL TABLE ExtDimReportType
(
    [report_type_id] VARCHAR(512),
    [report_type] VARCHAR(512)
)
WITH (
    LOCATION = 'serving/dim_report_type',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
);

CREATE EXTERNAL TABLE ExtBridgePersonGroup
(
    [person_group_key] VARCHAR(512),
    [person_id] VARCHAR(512)
)
WITH (
    LOCATION = 'serving/bridge_person_group',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
);
    

CREATE EXTERNAL TABLE ExtDimPerson
(
    [person_id] VARCHAR(512),
    [person_type] VARCHAR(512),
    [seat_no] VARCHAR(512),
    [city] VARCHAR(512),
    [state] VARCHAR(512),
    [zipcode] VARCHAR(512),
    [sex] VARCHAR(512), 
    [age] VARCHAR(512),
    [drivers_license_state] VARCHAR(512),
    [drivers_license_class] VARCHAR(512),
    [safety_equipment] VARCHAR(512),
    [airbag_deployed] VARCHAR(512),
    [ejection] VARCHAR(512),
    [injury_classification] VARCHAR(512),
    [hospital] VARCHAR(512),
    [driver_action] VARCHAR(512),
    [driver_vision] VARCHAR(512),
    [physical_condition] VARCHAR(512),
    [pedpedal_action] VARCHAR(512),
    [pedpedal_visibility] VARCHAR(512),
    [pedpedal_location] VARCHAR(512),
    [bac_result] VARCHAR(512)
)
WITH (
    LOCATION = 'serving/dim_person',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
);

CREATE EXTERNAL TABLE ExtDimWeather
(
    [weather_id] VARCHAR(512),
    [weather_condition] VARCHAR(512),
    [lighting_condition] VARCHAR(512)
)
WITH (
    LOCATION = 'serving/dim_weather',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
);

CREATE EXTERNAL TABLE ExtDimJunk
(
    [junk_id] VARCHAR(512),
    [intersection_related_i] VARCHAR(512),
    [hit_and_run_i] VARCHAR(512),
    [photos_taken_i] VARCHAR(512),
    [statements_taken_i] VARCHAR(512),
    [dooring_i] VARCHAR(512),
    [work_zone_i] VARCHAR(512),
    [workers_present_i] VARCHAR(512)
)
WITH (
    LOCATION = 'serving/dim_junk',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
);


CREATE EXTERNAL TABLE ExtDimCause
(
    [cause_id] VARCHAR(512),
    [prim_contributory_cause] VARCHAR(512),
    [sec_contributory_cause] VARCHAR(512)
)
WITH (
    LOCATION = 'serving/dim_cause',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
)


CREATE EXTERNAL TABLE ExtDimCrashType
(
    [crash_type_id] VARCHAR(512),
    [crash_type] VARCHAR(512)
)
WITH (
    LOCATION = 'serving/dim_crash_type',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
)

CREATE EXTERNAL TABLE ExtFactCrash
(
    [location_id] VARCHAR(512),
    [time_id] VARCHAR(512),
    [date_id] VARCHAR(512),
    [person_group_key] VARCHAR(512),
    [vehicle_group_key] VARCHAR(512),
    [weather_id] VARCHAR(512),
    [junk_id] VARCHAR(512),
    [cause_id] VARCHAR(512),
    [collision_type_id] VARCHAR(512),
    [report_type_id] VARCHAR(512),
    [crash_type_id] VARCHAR(512),
    [damage] VARCHAR(512),
    [num_units] VARCHAR(512),
    [injuries_total] VARCHAR(512),
    [injuries_fatal] VARCHAR(512),
    [injuries_incapacitating] VARCHAR(512),
    [injuries_non_incapacitating] VARCHAR(512),
    [injuries_reported_not_evident] VARCHAR(512),
    [injuries_no_indication] VARCHAR(512),
    [injuries_unknown] VARCHAR(512)
)
WITH (
    LOCATION = 'serving/fact_crash',
    DATA_SOURCE = [DataSource],
    FILE_FORMAT = [DeltaFormat]
);

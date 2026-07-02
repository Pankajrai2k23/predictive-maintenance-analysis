
select * from machine_data;
-- step1: To check for duplicates
-- step2:Check For Null Values
-- step3:Treating Null values
-- step4:Handling Negative values
-- step5:Fixing Inconsistent Date Formats & Invalid Dates
-- step6:Fixing Invalid Email Addresses
-- step7:Checking the datatype
SELECT COUNT(*) AS total_records
FROM machine_data;  
-- 10000
-- Check Total Number of Records
SELECT *
FROM machine_data
LIMIT 10;

-- Check for NULL Values
SELECT
COUNT(*) FILTER (WHERE product_id IS NULL) AS missing_product_id,
COUNT(*) FILTER (WHERE type IS NULL) AS missing_type,
COUNT(*) FILTER (WHERE air_temperature IS NULL) AS missing_air_temp,
COUNT(*) FILTER (WHERE process_temperature IS NULL) AS missing_process_temp,
COUNT(*) FILTER (WHERE rotational_speed IS NULL) AS missing_speed,
COUNT(*) FILTER (WHERE torque IS NULL) AS missing_torque,
COUNT(*) FILTER (WHERE tool_wear IS NULL) AS missing_tool_wear,
COUNT(*) FILTER (WHERE machine_failure IS NULL) AS missing_failure
FROM machine_data;

-- Check Duplicate Rows
SELECT *,
COUNT(*)
FROM machine_data
GROUP BY
"UDI",
product_id,
type,
air_temperature,
process_temperature,
rotational_speed,
torque,
tool_wear,
machine_failure,
twf,
hdf,
pwf,
osf,
rnf
HAVING COUNT(*) > 1;

-- Check Duplicate UIDs
SELECT "UDI",
COUNT(*)
FROM machine_data
GROUP BY "UDI"
HAVING COUNT(*) > 1;

-- Check Distinct Machine Types
SELECT DISTINCT type
FROM machine_data;

-- Check Invalid Machine Types
SELECT *
FROM machine_data
WHERE type NOT IN ('L','M','H');

-- Check Temperature Range
SELECT
MIN(air_temperature) AS min_air_temp,
MAX(air_temperature) AS max_air_temp,
MIN(process_temperature) AS min_process_temp,
MAX(process_temperature) AS max_process_temp
FROM machine_data;

-- Check Rotational Speed
SELECT
MIN(rotational_speed),
MAX(rotational_speed)
FROM machine_data;


-- Check Torque
SELECT
MIN(torque),
MAX(torque)
FROM machine_data;

-- Check Tool Wear
SELECT
MIN(tool_wear),
MAX(tool_wear)
FROM machine_data;


-- Find Invalid Sensor Values

SELECT *
FROM machine_data
WHERE
air_temperature <= 0
OR process_temperature <= 0
OR rotational_speed <= 0
OR torque < 0
OR tool_wear < 0;


-- Check Failure Distribution
SELECT
machine_failure,
COUNT(*) AS total
FROM machine_data
GROUP BY machine_failure;

-- Calculate Failure Rate
SELECT
ROUND(
100.0 * SUM(machine_failure) / COUNT(*),
2
) AS failure_rate
FROM machine_data;

-- Check Failure Modes
SELECT
SUM(twf) AS tool_wear_failure,
SUM(hdf) AS heat_dissipation_failure,
SUM(pwf) AS power_failure,
SUM(osf) AS overstrain_failure,
SUM(rnf) AS random_failure
FROM machine_data;

-- Check Product Type Distribution
SELECT
type,
COUNT(*) AS total_records
FROM machine_data
GROUP BY type;

-- Check Failure by Type
SELECT
type,
COUNT(*) AS total,
SUM(machine_failure) AS failures
FROM machine_data
GROUP BY type;




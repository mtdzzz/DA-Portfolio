SELECT 
	appointment_id,
	TRY_CAST(appointment_date AS DATE) AS appointment_date,
	appointment_time,
	CASE
		WHEN LOWER(appointment_status) IN ('completed', 'completd', 'complete') THEN 'Completed'
		WHEN LOWER(appointment_status) IN ('no-show','no show') THEN 'No-show'
		ELSE NULL 
	END AS appointment_status,
	CAST(created_at AS DATETIME) AS created_at,
	CAST(updated_at AS DATETIME) AS updated_at,
	patient_id,
	UPPER(patient_name) as patient_name,
	CASE
		WHEN LOWER(patient_gender) IN ('female', 'f') THEN 'Female'
		WHEN LOWER(patient_gender) IN ('male','m') THEN 'Male'
		WHEN LOWER(patient_gender) IN ('other','o') THEN 'Other'
		ELSE NULL 
	END AS patient_gender,
	CAST(patient_birth_date AS DATE) AS patient_birth_date,
	DATEDIFF(YEAR, TRY_CAST(patient_birth_date AS DATE), '2025-01-01') AS patient_age,
	patient_city,
	patient_email,
	patient_phone,
	doctor_id,
	UPPER(doctor_name) as doctor_name,
	doctor_specialty_id,
	doctor_specialty,
	doctor_license,
	consultation_duration,
	cost,
	diagnosis_code,
	prescription_id,
	medication_details,
	is_fulfilled,
	fulfilled_date,
	rating
INTO [Telemedicine].[dbo].[clean_telehealth_data]
FROM [Telemedicine].[dbo].[raw_telehealth_data]

-- Valid Flag - Missing value, Outliers, Illogical date (created_at > appointment_date)

ALTER TABLE [Telemedicine].[dbo].[clean_telehealth_data] ADD is_valid BIT;
UPDATE [Telemedicine].[dbo].[clean_telehealth_data] SET is_valid = 1;

-- MISSING VALUES
UPDATE [Telemedicine].[dbo].[clean_telehealth_data]
SET is_valid = 0
WHERE appointment_status IS NULL
	OR appointment_date IS NULL

-- OUTIERS: consultation_duration, cost
UPDATE [Telemedicine].[dbo].[clean_telehealth_data]
SET is_valid = 0
WHERE consultation_duration < 0 
	OR consultation_duration > 240

UPDATE [Telemedicine].[dbo].[clean_telehealth_data]
SET is_valid = 0
WHERE cost < 0 OR cost > 500

-- ILL-LOGICAL TIMESTAMPS (created_at > appointment_date)
UPDATE [Telemedicine].[dbo].[clean_telehealth_data]
SET is_valid = 0
WHERE created_at > appointment_date



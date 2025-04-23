-- dim_patients
CREATE TABLE [Telemedicine].[dbo].[dim_patients] (
	patient_id NVARCHAR(20) PRIMARY KEY,
	full_name NVARCHAR(100),
	gender VARCHAR(20),
	birth_date DATE,
	age INT,
	city VARCHAR(50),
	email NVARCHAR(100),
	phone VARCHAR(50)
);

INSERT INTO [Telemedicine].[dbo].[dim_patients] (
	patient_id,
	full_name,
	gender,
	birth_date,
	age,
	city,
	email,
	phone)
SELECT DISTINCT patient_id,
	patient_name,
	patient_gender,
	patient_birth_date,
	patient_age,
	patient_city,
	patient_email,
	patient_phone
FROM [Telemedicine].[dbo].[clean_telehealth_data]
WHERE is_valid = 1
AND patient_id IS NOT NULL;

-- dim_specialty
CREATE TABLE [Telemedicine].[dbo].[dim_specialty] (
    specialty_id VARCHAR(10),
    specialty_name NVARCHAR(100)
);
INSERT INTO [Telemedicine].[dbo].[dim_specialty] (specialty_id, specialty_name)
SELECT DISTINCT doctor_specialty_id, doctor_specialty
FROM [Telemedicine].[dbo].[clean_telehealth_data]


-- dim_doctors
CREATE TABLE [Telemedicine].[dbo].[dim_doctors] (
	doctor_id NVARCHAR(20) PRIMARY KEY,
	full_name NVARCHAR(100),
	specialty_id VARCHAR(10),
	license_number NVARCHAR(100),
);

INSERT INTO [Telemedicine].[dbo].[dim_doctors] (
	doctor_id,
	full_name,
	specialty_id,
	license_number
)
SELECT DISTINCT
	doctor_id,
	doctor_name,
	doctor_specialty_id,
	doctor_license
FROM [Telemedicine].[dbo].[clean_telehealth_data]

-- dim_prescriptions
CREATE TABLE [Telemedicine].[dbo].[dim_prescriptions] (
	prescription_id NVARCHAR(50) PRIMARY KEY,
	appointment_id NVARCHAR(50),
	doctor_id NVARCHAR(50),
	patient_id NVARCHAR(50),
	diagnosis_code NVARCHAR(50),
	is_fulfilled BIT,
	fulfilled_date DATE,
);
INSERT INTO [Telemedicine].[dbo].[dim_prescriptions](
	prescription_id,
	appointment_id,
	doctor_id,
	patient_id,
	diagnosis_code,
	is_fulfilled,
	fulfilled_date
)
SELECT DISTINCT
	prescription_id,
	appointment_id,
	doctor_id,
	patient_id,
	diagnosis_code,
	is_fulfilled,
	fulfilled_date
FROM [Telemedicine].[dbo].[clean_telehealth_data]
WHERE is_valid = 1
AND prescription_id IS NOT NULL

-- dim_prescription_items: export csv file to handle medication_details using Power query
SELECT DISTINCT 
	prescription_id,
	medication_details
FROM [Telemedicine].[dbo].[clean_telehealth_data]

CREATE TABLE [Telemedicine].[dbo].[dim_prescription_items] (
	prescription_items_id NVARCHAR(50) PRIMARY KEY,
	prescription_id NVARCHAR(50),
	medication_name NVARCHAR(200),
	dosage NVARCHAR(50),
	frequency NVARCHAR(50),
	duration_days INT
);

INSERT INTO [Telemedicine].[dbo].[dim_prescription_items] (
	prescription_items_id,
	prescription_id,
	medication_name,
	dosage,
	frequency,
	duration_days
)
SELECT 
	CONCAT(prescription_id, '-', RIGHT('00' + CAST(ROW_NUMBER() OVER (PARTITION BY prescription_id ORDER BY (SELECT NULL)) AS VARCHAR), 2)),
	prescription_id,
	medication_name,
	dosage,
	frequency,
	duration_days
FROM [Telemedicine].[dbo].[raw_prescription_items]

-- dim_date
CREATE TABLE [Telemedicine].[dbo].[dim_date] (
    date_id DATE PRIMARY KEY,
    day INT,
    month INT,
    month_name VARCHAR(20),
    quarter INT,
    year INT,
    day_of_week VARCHAR(10),
    is_weekend BIT,
    week_number INT
);

WITH DateSequence AS (
    SELECT CAST('2023-01-01' AS DATE) AS date_id
    UNION ALL
    SELECT DATEADD(DAY, 1, date_id)
    FROM DateSequence
    WHERE date_id < '2024-12-31'
)
INSERT INTO dim_date (
    date_id, day, month, month_name, quarter, year, 
    day_of_week, is_weekend, week_number
)
SELECT 
    date_id,
    DAY(date_id) AS day,
    MONTH(date_id) AS month,
    DATENAME(MONTH, date_id) AS month_name,
    DATEPART(QUARTER, date_id) AS quarter,
    YEAR(date_id) AS year,
    DATENAME(WEEKDAY, date_id) AS day_of_week,
    CASE WHEN DATENAME(WEEKDAY, date_id) IN ('Saturday', 'Sunday') THEN 1 ELSE 0 END AS is_weekend,
    DATEPART(WEEK, date_id) AS week_number
FROM DateSequence
OPTION (MAXRECURSION 730); 

-- fact_appointments
CREATE TABLE [Telemedicine].[dbo].[fact_appointments] (
    appointment_id NVARCHAR(50) PRIMARY KEY,
    patient_id NVARCHAR(20),
    doctor_id NVARCHAR(20),
    appointment_date DATE,
    appointment_time TIME,
    appointment_status VARCHAR(20),
    consultation_duration INT,
    diagnosis_code NVARCHAR(20),
    prescription_id NVARCHAR(50),
    cost DECIMAL(10, 2),
    rating INT,
    created_at DATETIME,
    updated_at DATETIME,

    FOREIGN KEY (patient_id) REFERENCES dim_patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES dim_doctors(doctor_id),
    FOREIGN KEY (prescription_id) REFERENCES dim_prescriptions (prescription_id),
    FOREIGN KEY (appointment_date) REFERENCES dim_date(date_id)
);

INSERT INTO [Telemedicine].[dbo].[fact_appointments] (
	appointment_id,
    patient_id,
    doctor_id,
    appointment_date,
    appointment_time,
    appointment_status,
    consultation_duration,
    diagnosis_code,
    prescription_id,
    cost,
    rating,
    created_at,
    updated_at
)
SELECT
	appointment_id,
    patient_id,
    doctor_id,
    appointment_date,
    appointment_time,
    appointment_status,
    consultation_duration,
    diagnosis_code,
    prescription_id,
    cost,
    rating,
    created_at,
    updated_at
FROM [Telemedicine].[dbo].[clean_telehealth_data]
WHERE is_valid = 1 

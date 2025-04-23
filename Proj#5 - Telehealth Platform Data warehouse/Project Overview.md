# Proj#5 - Telehealth Platform Data Warehouse Project
A simulated end-to-end data warehousing and business intelligence project in the healthtech domain. This project focuses on transforming messy raw telehealth data into a structured warehouse and delivering interactive dashboards to support data-driven decisions.

## 1.	Business Problem & Objectives:
This project simulates the work of a data analyst in a telehealth organization that manages virtual consultations, doctors, prescriptions, and patients. This project involves:
- **Data Architecture:** Designing a Modern Data Warehouse Using Medallion Architecture Bronze, Silver, and Gold layers.
- **ETL Pipelines:** Extracting, transforming, and loading data from source systems into the warehouse.
- **Data Modeling:** Developing fact and dimension tables optimized for analytical queries.
- **Analytics & Reporting:** Creating Power BI dashboards for actionable insights.

## 2. Objectives: 
- Transform raw CSV data into a structured star-schema model  
- Build a dimensional data warehouse using SQL  
- Ensure high data quality and consistency across entities  
- Define and calculate business-relevant KPIs  
- Deliver a Power BI dashboard to surface actionable insights 

## 3.	Data Overview:
This project uses a synthetic dataset of 100,000 telehealth appointments, doctors, patients, and prescriptions. Key cleaning tasks included:
- Resolving inconsistent date/time formats
- Handling missing or duplicate entries
- Splitting unstructured prescription data
- Normalizing categorical fields

## 4.	Tools & Technologies:
- **SQL**: For data cleaning, transformation, warehousing, KPI calculations  
- **Power BI**: For dashboard development & interactive visualization  
- **CSV/Excel**: For raw data input  
- **Dimensional Modeling**: Using star schema design  

## 5.	Data Architecture:
The data architecture for this project follows Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:
![raw data](https://github.com/user-attachments/assets/b6296c33-e74d-4484-917b-12f19c31e224)

1. **Bronze Layer**: Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics.

## 6.	Star Schema Diagram
![ERD](https://github.com/user-attachments/assets/913d2230-48f4-4b33-9325-f146e9760243)


## 7. Dashboard Previews
**Page 1: Executive Summary**
![Telehealth Operational Insights_page-0001](https://github.com/user-attachments/assets/9e76f947-f670-4406-bd5a-4fb1f2db1ac3)

**Page 2: Operational Timeline Insight**
![Telehealth Operational Insights_page-0002](https://github.com/user-attachments/assets/0c142885-68a2-4b4c-a1c6-8bb71b082e4d)

## 8. Business Insights & Impact:
The Power BI dashboard helped reveal:
- Top-performing doctors by appointment volume
- Most in-demand specialties (e.g., General Surgery, Renal Medicine)
- Patient load trends by day and hour
- Peak hours of consultation demand (heatmap)
- Consultation duration by time of day 
- No-show impact on operational efficiency

These insights support operations in optimizing scheduling, understanding patient behavior, and improving care delivery.






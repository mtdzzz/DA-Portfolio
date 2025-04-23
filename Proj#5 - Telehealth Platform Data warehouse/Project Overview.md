# Proj#5 - Telehealth Platform Data Warehouse Project
A simulated end-to-end data warehousing and business intelligence project in the healthtech domain. This project focuses on transforming messy raw telehealth data into a structured warehouse and delivering interactive dashboards to support data-driven decisions.

## 1.	Business Problem & Objectives:
This project simulates the work of a data analyst in a telehealth organization that manages virtual consultations, doctors, prescriptions, and patients. It demonstrates how to:
- Build a data warehouse from messy, flat healthcare data  
- Maintain data quality and model healthcare-specific entities  
- Enable business users to interactively explore operational KPIs through a Power BI dashboard  
---
## 🎯 Objectives: 
- Transform raw CSV data into a structured star-schema model  
- Build a dimensional data warehouse using SQL  
- Ensure high data quality and consistency across entities  
- Define and calculate business-relevant KPIs  
- Deliver a Power BI dashboard to surface actionable insights 

## 2.	Data Overview:
The dataset consists of five CSV files extracted from the CRM system:
1. **Sales Pipeline**: Information on sales opportunities (deal size, stages, dates)
2. **Sales Teams**: Sales agents and their managers
3. **Accounts**: Customer information (sector, revenue, employees)
4. **Products**: Product details and pricing

## 3.	Skill Demonstrated:
- **Data Transformation:** Cleaned and structured raw CRM data using Power Query.
- **Data Modeling**: Used DAX calculations for key performance metrics like Win Rate and Average Deal Size.
- **Dashboard Design:** Created an interactive Power BI dashboard with filters for real-time exploration

## 4.	Tools Used:
- Power BI
- DAX
- Power Query
## 5.	Report:
![Sale Performance Analysis](https://github.com/user-attachments/assets/a610438f-423f-4e25-aa92-5b3b2b14cbf2)

## 6.	Key Features & Insights
**Sales Performance Overview**
- Total Sales: $10M | Opportunities: 8.8K | Deals Closed: 4K
- Win Rate: 48.16%
**Sales by Region**
- Sales distribution across East (30.89%), Central (33.44%), and West (35.67%) regions.
- Identified high-performing regions to optimize sales strategy.
**Top-Performing Sales Agents**
- Ranked agents by total sales and opportunities won.
- Darcel Schlecht led with $1.2M in sales.
**Customer Segmentation**
- Sales breakdown by sector:
  - Retail: $1.9M
  - Technology: $1.5M
  - Medical: $1.4M
**Product Revenue Contribution**
- GTX Pro (35.09%) and GTX Plus Pro (26.28%) generated the highest revenue.
- Insights helped optimize product focus and pricing strategies.

## 7. Recommendations
- Focus on training sales agents with low win rates
- Develop targeted promotions for top-selling products
- Increase efforts in the Medical and Finance sectors
- Improve CRM data completeness to reduce missing values


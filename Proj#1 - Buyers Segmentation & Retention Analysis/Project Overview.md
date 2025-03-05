# Proj#1 - Buyers Segmentation & Retention Analysis 
## 1.	Business Problem & Objective:
Ensuring high-quality raw materials is critical for delivering premium products to customers. However, evaluating supplier performance based on multiple quality parameters like Outturn Rate, Defect Percentage, and Moisture Content can be challenging without a structured system.
This project aims to create a **Supplier Quality Scorecard** to:
- Identify top-performing suppliers
- Highlight suppliers needing improvement
- Provide data-driven insights to improve supplier selection and quality assurance processes

## 2.	Data Overview:
- **Dataset**: The dataset contains Cashew Truck Arrivals from various suppliers across 3 years.
- **Key variables**:
  + **Supplier**: Identification of the supplier delivering the cashew nuts.
  + **Net Weight**: Weight of each delivery.
  + **Defective**: Percentage of defective nuts in the delivery.
  + **Moisture**: Moisture content percentage, affecting nut quality.
  + **Outturn**: Edible kernel yield percentage, indicating the amount of usable product.
  + **Date**: Delivery date, used for time-based analysis.
## 3.	Skill Demonstrated:
- **Data Cleaning & Preparation**: Handling missing values, Converting data types, Grouping categorical data.
- **Data Analysis**: Calculating Key Performance Indicators (KPIs), Correlation Analysis between quality parameters.
- **Data Visualization**: Presenting insights through charts and graphs.
## 4.	Tools Used:
- Power BI, Power query
## 5.	Report:
![Cashew Supplier Quality Scorecard](https://github.com/user-attachments/assets/264b1304-6aa7-49a9-a2e0-547c66f3f18e)

## 6.	Key Findings:
### 6.1 Suppliers Overall Performance
- Only **a few suppliers consistently perform at high quality levels** with scores above **75**.
- The majority of suppliers deliver **average-quality products** with scores between 68 and 73.
- Suppliers with lower defect rates tend to achieve higher quality scores.
### 6.2 Quality Score Distribution
- The majority of suppliers fall into the **average performance range**, highlighting an opportunity to improve overall supplier quality.
- A small portion of suppliers consistently score **below 60**, indicating **poor-quality deliveries**.
- The distribution is **right-skewed**, showing that only a few suppliers achieve high-quality scores.
### 6.3 Top-Performing Suppliers (High Quality & Consistent Delivery)
- The top 5 suppliers have **zero defective rates** and consistently lower moisture content.
- Despite the good performance, only Supplier 11 contributed a high amount of volume. The remaining top-performing suppliers delivered **significantly lower volumes**, suggesting that high-quality suppliers need to be incentivized to increase their supply.
### 6.4 Suppliers Needing Improvement (Low Quality Score)
- The bottom 5 suppliers have **defective rates above 22%**.
- These suppliers show high moisture levels (13%–16%) and low outturn rates (~41%).
### 6.5 Impact of Defective rate on Outturn
- There is a **negative correlation** between Defective Rate and Outturn (-0.73), indicating that higher defect rates reduce the overall edible yield.
### 6.6 Defective vs Quality Score Trend
- An inverse relationship is observed: as the defective rate increases, the quality score decreases.
- The trend shows that **defective rates peaked in 2016**, leading to a decline in quality scores.

## 7. Recommendations
- **Prioritize contracts with Top Suppliers** to improve overall product quality.
- Engage in **quality improvement programs** with underperforming suppliers.
- Establish **bonus incentives** for suppliers who maintain moisture content below 10%.
- Use the **Scorecard for Quarterly Supplier Reviews** and negotiations.
- Partner with **high-volume suppliers who maintain consistent quality** to secure long-term contracts.


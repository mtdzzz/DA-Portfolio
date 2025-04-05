# Proj#4 - 
## 1.	Project Overview
This project aims to analyze sales performance by evaluating key performance indicators (KPIs) from the company's CRM system. The analysis highlights sales performance at different levels, including sales agents, products, customer sectors, and regions. The insights provided help improve decision-making and optimize sales strategies.

## 2.	Objectives
- Identify the correlation between discount rates and sales performance.
- Determine the optimal discount percentage for maximizing revenue.
- Analyze how discounting strategies affect profit margins.
- Provide data-driven recommendations for future 11.11 sales campaigns.

## 3.	Data Overview:
- **Source**: The dataset contains top-selling product data from the 11.11 sales campaign of an e-commerce platform, Daraz.
- **Key features**:
  + **Category & SubCategory**: Classification of products.
  + **Title**: Product name.
  + **Original Price & Discount Price**: Price before and during the sale.
  + **Discount (%)**: Discount offered by the seller.
  + **Seller Name**: Store selling the product.
  + **Seller Performance Metrics**: Ratings, response rate, delivery speed, etc.
  + **Delivery Type**: Free vs. standard delivery.
  + **No. of Products to be Sold**: Number of units needed to break even.

## 4.	Skill Demonstrated:
- 

## 5.	Tech Stack & Tools
- **Programming**: Python (Pandas, NumPy, Matplotlib, Seaborn, Statsmodels, Scikit-learn)  
- **Data Analysis**: Statistical Hypothesis Testing, Regression Analysis, ANOVA  
- **Visualization**: Power BI, Matplotlib, Seaborn 

## 6.	Project Workflow
### 6.1. Data Cleaning & Preprocessing
- Identified and handled missing values.
- Checked for and removed duplicate entries.
- Engineered new features:
  + Revenue before Discount: Estimated revenue if products were sold at original price.
  + Revenue after Discount: Actual revenue at discounted price.
  + Revenue Impact: % change in revenue due to discounts.
- Cleaned categorical variables: Converted "Yes/No" values (e.g., Flagship Store) into binary.
- One-hot encoded categorical features (e.g., Category, Delivery Type) for modeling.

### 6.2. Exploratory Data Analysis (EDA)
- Distribution of Discounts: Used a histogram with KDE to visualize the frequency distribution of discount percentages.
- Boxplot of Prices Before & After Discount: Compared the original and discounted prices using a boxplot to analyze price dispersion and potential outliers.
- Scatter Plot - Discount % vs. No. of Products to be Sold: Assessed the relationship between discount percentages and the break-even sales volume using a scatter plot.

### 6.3. Statistical Analysis & Modeling
**a. ANOVA: Does a Higher Discount Significantly Increase Sales?**
- Conducted a one-way ANOVA test to compare revenue across different discount tiers:
  + Low (≤20%)
  + Medium (21%-50%)
  + High (>50%)

**b. Multiple Regression Analysis**
- Performed Ordinary Least Squares (OLS) regression to model the relationship between discount percentage and multiple factors:
  + Seller Metrics: Number of ratings, positive seller ratings, chat response rate, on-time shipping.
  + Store Type: Flagship store or not.
  + Product & Delivery Type: One-hot encoded categorical variables.
 
  ### 6.4. Visualization
An interactive Power BI dashboard was developed to visualize key findings and enable dynamic exploration of discount effectiveness.

## 7. Visualization & Insights
### 7.1. Exploratory Data Analysis (EDA)
**Distribution of Discounts**
![image](https://github.com/user-attachments/assets/928f1ec4-bc61-41d9-a1f6-30fc10ea5862)
- The majority of products have discounts ranging from 20% to 60%.
- There are some extreme discounts (close to 90%), but they are less frequent.

**Price Distribution Before & After Discount**
![image](https://github.com/user-attachments/assets/5a49f5b9-f183-42ec-9c95-559b9c3f75bf)
- Original Prices have a wider range and higher values.
- Discounted Prices are significantly lower, showing a clear reduction across all categories.
- The median price drops notably after applying discounts.

**Discount % vs. Required Sales to Break-even**
![image](https://github.com/user-attachments/assets/a012e129-2385-461e-8ca5-ea82d752897a)
- As discount % increases, the number of products required to be sold also increases.
- This confirms that higher discounts require significantly higher sales volume to maintain revenue.

### 7.2. Statistical Analysis & Modeling
**ANOVA: Does a Higher Discount Significantly Increase Sales?**
**Hypotheses**:
- Null (H₀): No significant difference in sales across different discount levels.
- Alternative (H₁): A significant difference in sales across discount levels.
**Results**: F-statistic = 345.1327716762809, p-value = 3.368098835425772e-146
The extremely low p-value (< 0.05) indicates that the differences in average revenue across discount groups are **statistically significant**. This suggests that **discount level plays a crucial role in influencing sales revenue**.
**Insights**:
- While increasing discounts may boost sales, **the relationship is not linear**—beyond a certain threshold, deep discounts could hurt profitability.
- These findings serve as input for further analysis (e.g., regression modeling and dashboarding) to **pinpoint the optimal discount rate**.

**Multiple Regression Analysis: What Factors Drive Sales Revenue?**




# Project : [📂](https://github.com/AmitSaroj-hub/Kotak-Loan-Risk-Meter/blob/main/Kotak%20Loan%20Risk%20Meter%20BI.pbix) Kotak Mahindra Bank Credit Risk & Loan Portfolio Analytics
**Click On Folder Icon To Open Project File.**

## 🎯 Project Objective
This project engineered a dynamic credit risk performance dashboard using Power BI and SQL for a retail lending context. The objective was to transform raw fintech borrower transaction histories into an advanced analytics interface to isolate high-risk borrower behaviors, track Non-Performing Assets (NPAs), and protect bank capital from toxic exposure. The resulting system enables credit risk teams to evaluate applicants, monitor delinquency trends, and establish automated underwriting guardrails.

---

## 📊 Dataset Used
**Source:** Simulated Fintech Loan Risk Data  
**Period Covered:** Historical 12-Month Performance Window  
[🔗](https://github.com/AmitSaroj-hub/Kotak-Loan-Risk-Meter/blob/main/Kotak_Raw_Dataset.csv) Click on the link icon

**Key Columns:**
- `Customer_ID`, `Age`, `Gender`, `CIBIL_Score`, `Monthly_Income_INR`
- `Loan_Amount_INR`, `Avg_Account_Balance_INR`, `UPI_Txn_Count_30D`, `Late_EMI_Count_12M`, `Default_Status`
- Derived Analytics: `CIBIL_Bracket`, `Balance_Health_Status`, `Salary_Segment`, `UPI_Activity_Tier`

---

## 📈 Key Questions (KPIs)
1. Total Applicants Count  
2. Total Portfolio Volume under management  
3. Average Monthly Income of applicants  
4. Average CIBIL Score of the portfolio  
5. Portfolio Quality (Gross NPA Rate %)  
6. Financial Exposure (Total Capital Lost in INR)  
7. Liquidity Cushions (Average Account Balance vs Income)  
8. Behavioral Patterns based on CIBIL scores and repayment delays  
9. Digital Footprints (UPI Activity vs Risk Profile)  
10. Automated High-Risk Underwriting Blacklists  

---

## 🛠️ Project Process

### 1. Data Extraction & Compliance
*Disclaimer: This dataset consists entirely of mock/synthetic data generated via Python for academic and portfolio demonstration purposes. It does not utilize real Kotak Mahindra Bank customer data, nor is it intended to represent the actual financial health or operational performance of the institution.*

The base dataset was generated via a custom Python script to simulate realistic retail banking distributions across 10,000 unique borrower records.

### 2. SQL Exploratory Data Analysis (EDA)
Rather than executing visualizations immediately, initial data exploration was conducted within the database using SQL. This step verified data integrity, evaluated structural quality, and prototyped core underwriting logic prior to frontend modeling.

SQL Queries: [Link](https://github.com/AmitSaroj-hub/Kotak-Loan-Risk-Meter/blob/main/Business%20Queries.sql)

- **Credit Risk Tiering:** Calculated non-performing asset (NPA) rates across standard credit score brackets to establish core underwriting boundaries.
- **Alternative Data Testing:** Evaluated digital payment frequency against credit defaults to verify if active transaction volume signals lower credit risk.
- **Missed Repayment Trends:** Tracked default rates against the exact number of missed EMIs to evaluate how fast credit quality deteriorates.
- **Capital Loss Aggregation:** Mapped absolute financial losses against borrower salary segments to pinpoint where bank capital faces the highest exposure.
- **Early Warning Prototyping:** Filtered for high missed EMIs combined with depleted cash reserves to isolate high-probability default accounts.
- **Credit Inclusion Identification:** Uncovered a viable consumer segment with lower credit scores but pristine repayment histories and active digital footprints.
  
### 3. Power BI Data Import & Transformation
- Connected Power BI Desktop to the prepared SQL/CSV database layer.
- Conducted data cleaning and handled structural data type configurations for transaction values and unique keys in Power Query.

### 4. Data Engineering: Calculated Columns
Derived 4 analytical columns to slice, group, and segment risk behaviors row-by-row:
- **`CIBIL_Bracket`**: Grouped scores into operational risk categories (Excellent, Good, Fair, Poor).
- **`Balance_Health_Status`**: Flagged liquid cash runways dipping below 25% of declared monthly income.
- **`Salary_Segment`**: Stratified applicants into economic tiers (Tier 1 High, Tier 2 Middle, Tier 3 Mass Market).
- **`UPI_Activity_Tier`**: Measured digital transaction intensity to assess active user engagement.

### 5. Data Engineering: Dynamic Measures
Engineered 6 distinct aggregation metrics using DAX to power summary cards and responsive visuals:
- **`Total_Applicants_Count`**: Tracked total underwriting applications.
- **`Total_Portfolio_Volume`**: Evaluated total capital deployed in loans.
- **`Average_Monthly_Income`**: Assessed incoming cash baselines across data subsets.
- **`Average_CIBIL_Score`**: Monitored macro credit worthiness movements.
- **`Gross_NPA_Rate`**: Calculated the core portfolio risk percentage.
- **`Total_Capital_Lost`**: Quantified total financial defaults in INR.

---

## 💡 Project Insights & Outcomes

- **Size, Scope & Scale:** Successfully developed and deployed an end-to-end risk pipeline for a **₹1.25B+ portfolio** across **10,000 applicants** to analyze asset quality.
- **Technical Execution:** Investigated raw database patterns using complex SQL aggregations and engineered advanced DAX models to successfully isolate an industry-standard, realistic retail **9.80% Gross NPA Rate**.
- **Data-Driven Outcomes:** Isolated a critical underwriting vulnerability proving that lower digital payment frequency (<25 UPI txns/month) combined with low liquidity cushions causes segment default risk to spike to **14.20%**, despite a healthy macro portfolio baseline.
- **Key Learning:** Learned how to synthesize modern alternative transaction footprints with traditional credit scores to build automated early-warning risk filtering systems that actively shield bank capital from volatility.

### 6. Technical Implementation (Calculated Columns DAX)

1. Behavioral Risk Segmentation (CIBIL Brackets):
```dax
CIBIL_Bracket = 
IF(
    'Kotak_Loans_Dataset'[CIBIL_Score] >= 750, "Excellent (750-900)",
    IF(
        'Kotak_Loans_Dataset'[CIBIL_Score] >= 650, "Good (650-749)",
        IF(
            'Kotak_Loans_Dataset'[CIBIL_Score] >= 550, "Fair (550-649)",
            "Poor (<550)"
        )
    )
)
```
2. Liquid Asset Cushion Filter (Balance Health Status):
```dax
Balance_Health_Status = 
IF(
    Kotak_Loans_Dataset[Avg_Account_Balance_INR] < (Kotak_Loans_Dataset[Monthly_Income_INR] * 0.25),
    "Low Balance Danger",
    "Healthy Balance"
)
```
4. Income Stratification (Salary Segment):
```dax
Salary_Segment = 
IF(
    'Kotak_Loans_Dataset'[Monthly_Income_INR] >= 100000, "Tier 1 (High Income)",
    IF(
        'Kotak_Loans_Dataset'[Monthly_Income_INR] >= 50000, "Tier 2 (Middle Income)",
        "Tier 3 (Mass Market)"
    )
)
```
6. Digital Engagement Tracking (UPI Activity Tier):
```dax
UPI_Activity_Tier = 
IF(
    'Kotak_Loans_Dataset'[UPI_Txn_Count_30D] >= 50, "High Activity (>50 Txns/Month)",
    IF(
        'Kotak_Loans_Dataset'[UPI_Txn_Count_30D] >= 25, "Medium Activity (25-50 Txns/Month)",
        "Low Activity (<25 Txns/Month)"
    )
)
```

### 7. Technical Implementation (Dynamic Measures DAX)
```dax
1. Total_Applicants_Count = COUNT(Kotak_Loans_Dataset[Customer_ID])
```
```dax
2. Total_Portfolio_Volume = SUM(Kotak_Loans_Dataset[Loan_Amount_INR])
```
```dax
3. Average_Monthly_Income = AVERAGE(Kotak_Loans_Dataset[Monthly_Income_INR])
```
```dax
4. Average_CIBIL_Score = AVERAGE(Kotak_Loans_Dataset[CIBIL_Score])
```
```dax
5. Gross_NPA_Rate = 
DIVIDE(
    CALCULATE(COUNT(Kotak_Loans_Dataset[Customer_ID]), Kotak_Loans_Dataset[Default_Status] = 1),
    COUNT(Kotak_Loans_Dataset[Customer_ID]),
    0
)
```
```dax
6. Total_Capital_Lost = 
CALCULATE(
    SUM(Kotak_Loans_Dataset[Loan_Amount_INR]),
    Kotak_Loans_Dataset[Default_Status] = 1
)
```

## 💡 Project Insights
- **Macro Portfolio Health:** The overall loan portfolio stands at a total volume of **1,256.81M (₹1.25B+)** across **10K total applicants**, maintaining a macro portfolio average CIBIL score of **709.20** and an average applicant monthly income of **45.53K**.
  
- **The Portfolio Risk Baseline:** The core portfolio risk metric reveals a high **Gross NPA Rate of 40.40%**, indicating a massive concentration of toxic capital exposure requiring immediate underwriting interventions.
  
- **The Credit Score Paradox:** While a substantial **55.16% of all applicants** occupy the "Good" CIBIL score tier (650–749), cross-filtering highlights severe underlying risk. A "Good" credit score alone is an unreliable risk indicator when isolated from liquidity buffers.
  
- **The Digital Footprint Correlation:** Alternative transaction tracking confirms that alternative data is a critical leading risk indicator. Borrowers displaying low digital transaction volumes (<25 UPI txns/month) show an alarming default probability spike jumping to **44.44%**.
  
- **Missed Repayment Loss Mapping:** Tracking historical performance against capital loss shows that while accounts with 0 missed EMIs represent 279.4M in outstanding balance, customers crossing the threshold of **1 to 2 missed EMIs** are driving massive credit quality deterioration, leaking **130.7M and 65.6M respectively** in total capital lost.
  
- **The Operational Blacklist Impact:** SQL analysis and dashboard tables successfully isolated the high-risk "99% Critical Trap" segment. By targeting accounts with `Late_EMI_Count_12M > 2` and `average_account_balance` < `Low Balance Threshold` status, the bank can systematically auto-reject high-probability default accounts and protect capital.

---

## 📅 Dashboard Preview
[Dashboard](https://github.com/AmitSaroj-hub/Kotak-Loan-Risk-Meter/blob/main/Kotak%20Loan%20Risk%20Dashboard.pdf)





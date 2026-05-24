# Project : [📂](https://github.com/AmitSaroj-hub/Kotak-Loan-Risk-Meter/blob/main/Kotak%20Loan%20Risk%20Meter%20BI.pbix) Kotak Mahindra Bank Credit Risk & Loan Portfolio Analytics
**Click On Folder Icon To Open Project File.**

## 🎯 Project Objective
This project showcases a dynamic credit risk performance dashboard built using Power BI for Kotak Mahindra Bank. The goal was to transform raw fintech borrower transaction histories into an advanced analytics interface to isolate high-risk borrower behaviors, track Non-Performing Assets (NPAs), and protect the bank from toxic capital exposure. The dashboard enables credit risk teams to evaluate applicants, monitor delinquency trends, and activate automated underwriting guardrails.

---

##  Dashboard Preview
[Dashboard](https://github.com/AmitSaroj-hub/Amit-s-Portfolio/blob/main/Dashboard%20Preview.png)

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

### 1. Data Extraction:
First of all i would like to clarify that this data is a complete sample/mock data as i generated it by python,
so i am not using any Kotak Mahindra Bank's real data and have no intentions to defame their name by this data.
I asked gemini to write me a python code for generating the data.

### 2. SQL Exploratory Data Analysis (EDA)
First, I didn't just jump straight into Power BI. I started in the database with SQL to check our data quality and run a few queries to see where the defaults were actually happening. This allowed me to prototype my credit risk logic early on before shifting to the visualization stage.

SQL Queries:[Link](https://github.com/AmitSaroj-hub/Kotak-Loan-Risk-Meter/blob/main/Business%20Queries.sql)

- **1. Credit Risk Tiering:** Calculated non-performing asset (NPA) rates across standard credit score brackets to establish core underwriting boundaries.
- **2. Alternative Data Testing:** Evaluated digital payment frequency against credit defaults to verify if active transaction volume signals lower credit risk.
- **3. Missed Repayment Trends:** Tracked default rates against the exact number of missed EMIs to evaluate how fast credit quality deteriorates.
- **4. Capital Loss Aggregation:** Mapped absolute financial losses against borrower salary segments to pinpoint where bank capital faces the highest exposure.
- **5. Early Warning Prototyping:** Filtered for high missed EMIs combined with depleted cash reserves to isolate high-probability default accounts.
- **6. Credit Inclusion Identification:** Uncovered a viable consumer segment with lower credit scores but pristine repayment histories and active digital footprints.
  
### 3. Power BI Data Import & Transformation
- Connected Power BI Desktop to the prepared dataset.
- Handled structural type changes for transaction values and customer IDs.

### 4. Data Engineering: Calculated Columns
Derived 4 analytical columns to slice, group, and segment risk behaviors row-by-row:
- **`CIBIL_Bracket`**: Groups scores into operational risk categories (Excellent, Good, Fair, Poor).
- **`Balance_Health_Status`**: Flags liquid cash runways dipping below 25% of declared income.
- **`Salary_Segment`**: Stratifies applicants into economic tiers (Tier 1 High, Tier 2 Middle, Tier 3 Mass Market).
- **`UPI_Activity_Tier`**: Measures digital transaction intensity to assess active user engagement.

### 5. Data Engineering: Dynamic Measures
Engineered 6 distinct aggregation metrics to power summary cards and responsive visuals:
- **`Total_Applicants_Count`**: Tracks total underwriting applications.
- **`Total_Portfolio_Volume`**: Evaluates total capital deployed in loans.
- **`Average_Monthly_Income`**: Assesses incoming cash baselines across data subsets.
- **`Average_CIBIL_Score`**: Monitors macro credit worthiness movements.
- **`Gross_NPA_Rate`**: Calculates the core portfolio risk percentage.
- **`Total_Capital_Lost`**: Quantifies total financial defaults in INR.

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



# Project : [📂](https://github.com/AmitSaroj-hub/Kotak-Loan-Risk-Meter/blob/main/Kotak%20Loan%20Risk%20Meter%20BI.pbix) Kotak Mahindra Bank Credit Risk Intelligence Dashboard.
**Click On Folder Icon To Open Project File.**

## 🎯 Project Objective
This project showcases a dynamic credit risk performance dashboard built using Power BI for Kotak Mahindra Bank. The goal was to transform raw fintech borrower transaction histories into an advanced analytics interface to isolate high-risk borrower behaviors, track Non-Performing Assets (NPAs), and protect the bank from toxic capital exposure. The dashboard enables credit risk teams to evaluate applicants, monitor delinquency trends, and activate automated underwriting guardrails.

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

### 1. Data Import & Transformation
- Loaded raw fintech banking data into Power BI Desktop.
- Handled structural type changes for transaction values and customer IDs.

### 2. Data Engineering: Calculated Columns
Derived 4 analytical columns to slice, group, and segment risk behaviors row-by-row:
- **`CIBIL_Bracket`**: Groups scores into operational risk categories (Excellent, Good, Fair, Poor).
- **`Balance_Health_Status`**: Flags liquid cash runways dipping below 25% of declared income.
- **`Salary_Segment`**: Stratifies applicants into economic tiers (Tier 1 High, Tier 2 Middle, Tier 3 Mass Market).
- **`UPI_Activity_Tier`**: Measures digital transaction intensity to assess active user engagement.

### 3. Data Engineering: Dynamic Measures
Engineered 6 distinct aggregation metrics to power summary cards and responsive visuals:
- **`Total_Applicants_Count`**: Tracks total underwriting applications.
- **`Total_Portfolio_Volume`**: Evaluates total capital deployed in loans.
- **`Average_Monthly_Income`**: Assesses incoming cash baselines across data subsets.
- **`Average_CIBIL_Score`**: Monitors macro credit worthiness movements.
- **`Gross_NPA_Rate`**: Calculates the core portfolio risk percentage.
- **`Total_Capital_Lost`**: Quantifies total financial defaults in INR.

### 4. Technical Implementation (Calculated Columns DAX)
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

Balance_Health_Status = 
IF(
    Kotak_Loans_Dataset[Avg_Account_Balance_INR] < (Kotak_Loans_Dataset[Monthly_Income_INR] * 0.25),
    "Low Balance Danger",
    "Healthy Balance"
)

Salary_Segment = 
IF(
    'Kotak_Loans_Dataset'[Monthly_Income_INR] >= 100000, "Tier 1 (High Income)",
    IF(
        'Kotak_Loans_Dataset'[Monthly_Income_INR] >= 50000, "Tier 2 (Middle Income)",
        "Tier 3 (Mass Market)"
    )
)

UPI_Activity_Tier = 
IF(
    'Kotak_Loans_Dataset'[UPI_Txn_Count_30D] >= 50, "High Activity (>50 Txns/Month)",
    IF(
        'Kotak_Loans_Dataset'[UPI_Txn_Count_30D] >= 25, "Medium Activity (25-50 Txns/Month)",
        "Low Activity (<25 Txns/Month)"
    )
)

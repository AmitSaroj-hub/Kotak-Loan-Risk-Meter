# Kotak Mahindra Bank: Credit Risk & Loan Portfolio Analytics

---

## 🎯 Project Overview
This project was designed to simulate a real-world Fintech credit analytics environment for **Kotak Mahindra Bank**. The goal was to engineer an end-to-end business intelligence asset to analyze loan portfolio health, isolate high-risk borrower behaviors, and protect the bank from non-performing assets (NPAs).

By analyzing historical borrower trends, digital transaction footprints, and past repayment delays, this dashboard acts as an automated operational early warning system (EWS) for credit underwriters.

---

## 🛠️ Tech Stack & Skills Demonstrated
* **Business Intelligence:** Power BI Desktop (Advanced UI/UX, Dark-Theme Terminal Architecture)
* **Data Engineering & Logic:** Data Analysis Expressions (DAX)
* **Database Querying:** Structured Query Language (SQL) for initial data extraction and behavioral patterning
* **Core Metrics Engineered:** Gross NPA Rate %, Total Capital Lost, Risk Segmentation

---

## 🧠 Data Architecture & Analytical Formulae (DAX)

The complete engineering pipeline containing all calculated columns (for slicing) and dynamic measures (for KPI tracking) built across the dataset:

```dax
=============================================================================
1. CALCULATED COLUMNS (Row-Level Demographics & Risk Segments)
=============================================================================

// A. Behavioral Risk Segmentation (CIBIL Brackets)
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

// B. Liquid Asset Cushion Filter (Balance Health Status)
Balance_Health_Status = 
IF(
    Kotak_Loans_Dataset[Avg_Account_Balance_INR] < (Kotak_Loans_Dataset[Monthly_Income_INR] * 0.25),
    "Low Balance Danger",
    "Healthy Balance"
)

// C. Income Stratification (Salary Segment)
Salary_Segment = 
IF(
    'Kotak_Loans_Dataset'[Monthly_Income_INR] >= 100000, "Tier 1 (High Income)",
    IF(
        'Kotak_Loans_Dataset'[Monthly_Income_INR] >= 50000, "Tier 2 (Middle Income)",
        "Tier 3 (Mass Market)"
    )
)

// D. Digital Engagement Tracking (UPI Activity Tier)
UPI_Activity_Tier = 
IF(
    'Kotak_Loans_Dataset'[UPI_Txn_Count_30D] >= 50, "High Activity (>50 Txns/Month)",
    IF(
        'Kotak_Loans_Dataset'[UPI_Txn_Count_30D] >= 25, "Medium Activity (25-50 Txns/Month)",
        "Low Activity (<25 Txns/Month)"
    )
)



=============================================================================
2. DYNAMIC MEASURES (Core Portfolio KPIs & Performance Indicators)
=============================================================================

// A. Total Applicants Count
Total_Applicants_Count = COUNT(Kotak_Loans_Dataset[Customer_ID])

// B. Total Portfolio Volume
Total_Portfolio_Volume = SUM(Kotak_Loans_Dataset[Loan_Amount_INR])

// C. Average Monthly Income
Average_Monthly_Income = AVERAGE(Kotak_Loans_Dataset[Monthly_Income_INR])

// D. Average CIBIL Score
Average_CIBIL_Score = AVERAGE(Kotak_Loans_Dataset[CIBIL_Score])

// E. Risk Metric Calculation (Gross NPA Rate)
Gross_NPA_Rate = 
DIVIDE(
    CALCULATE(COUNT(Kotak_Loans_Dataset[Customer_ID]), Kotak_Loans_Dataset[Default_Status] = 1),
    COUNT(Kotak_Loans_Dataset[Customer_ID]),
    0
)

// F. Financial Exposure (Total Capital Lost)
Total_Capital_Lost = 
CALCULATE(
    SUM(Kotak_Loans_Dataset[Loan_Amount_INR]),
    Kotak_Loans_Dataset[Default_Status] = 1
)

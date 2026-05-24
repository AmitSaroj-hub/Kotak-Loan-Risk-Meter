# Kotak Mahindra Bank: Credit Risk & Loan Portfolio Analytics
![Kotak Loan Risk Dashboard]([dashboard_screenshot.jpg](https://github.com/AmitSaroj-hub/Kotak-Loan-Risk-Meter/blob/main/Kotak%20Dashboard%20Screenshot.png))

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

---

## 🔍 Key Business Insights Uncovered

* **The Repayment Delinquency Trap:** Borrowers who register more than **2 missed EMIs** within a 12-month window are responsible for the vast majority of defaults, creating over **₹100M+ in toxic capital exposure** across the portfolio. 
* **The Digital Footprint Anomaly:** Your line chart analysis revealed a critical risk threshold—borrowers presenting a combination of low digital transaction volumes (<25 txns/month) and depleted bank balances exhibit an alarming default probability of **40%+**. 
* **The CIBIL Scoring Paradox:** While a substantial portion (over 55%) of applicants occupy the "Good" CIBIL score tier (650–749), cross-referencing their liquid bank balances reveals severe paycheck-to-paycheck strain. A high credit score alone is an unreliable indicator if cash reserves are exhausted.

---

## ⚡ Actionable Operational Recommendations

1. **Automate the "99% Critical Trap" Blacklist:** Kotak's credit underwriting software should instantly auto-reject applicants exhibiting a combination of `Late_EMI_Count_12M > 2` and a `Low Balance Danger` flag.
2. **Dynamic Exposure Capping:** Restrict total credit assignment to 50% of standard eligibility limits for individuals in the "Good" CIBIL tier who display deteriorating digital account health.
3. **Proactive Portfolio Monitoring:** Trigger Early Warning System (EWS) notifications to risk managers the instant an active loan customer's average balance drops below 25% of their declared monthly income.

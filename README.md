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

All core calculated logic engineered to handle data transformations and risk metrics across the portfolio:

---
```dax
1. Risk Metric Calculation (Gross NPA Rate)
Gross_NPA_Rate = 
DIVIDE(
    CALCULATE(COUNT(Kotak_Loans_Dataset[Customer_ID]), Kotak_Loans_Dataset[Default_Status] = 1),
    COUNT(Kotak_Loans_Dataset[Customer_ID]),
    0
)

---

2. Behavioral Risk Segmentation (CIBIL Brackets)
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

---

3. Financial Exposure (Total Capital Lost)
Total_Capital_Lost = 
CALCULATE(
    SUM(Kotak_Loans_Dataset[Loan_Amount_INR]),
    Kotak_Loans_Dataset[Default_Status] = 1
)

---

4. Liquid Asset Cushion Filter (Balance Health Status)
Balance_Health_Status = 
IF(
    Kotak_Loans_Dataset[Avg_Account_Balance_INR] < (Kotak_Loans_Dataset[Monthly_Income_INR] * 0.25),
    "Low Balance Danger",
    "Healthy Balance"
)

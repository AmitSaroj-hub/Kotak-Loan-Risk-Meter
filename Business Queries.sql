SELECT * FROM Loan_Risk;

###-- 1. The Business Question: What is our absolute credit risk across different traditional tiers?
SELECT
CASE
    WHEN CIBIL_Score >= 750 THEN 'Excellent (Low Risk)'
    WHEN CIBIL_Score BETWEEN 700 AND 749 THEN 'Good (Morderate Risk)'
    WHEN CIBIL_Score BETWEEN 600 AND 699 THEN 'Fair (High Risk)'
    ELSE 'Poor (Critical Risk)'
END AS CIBIL_Risk_Segments,
COUNT(*) AS Total_Applicants,
SUM(Default_Status) AS Total_Defaulters,
ROUND((SUM(Default_Status) / COUNT(*)) * 100, 2) AS NPA_Default_Rate
FROM Loan_Risk
GROUP BY 1
ORDER BY NPA_Default_Rate;


-- 2. The Business Question: Does a customer's frequency of digital UPI payments actually make them a safer bet for a loan, regardless of their credit score?
SELECT
CASE
    WHEN UPI_Transactions_Count_3M >= 60 THEN 'High (Digital User)'
    WHEN UPI_Transactions_Count_3M BETWEEN 30 AND 59 THEN 'Medium (Digital User)'
    ELSE 'Low (Digital_User)'
END AS UPI_Transactions_Segments,
COUNT(*) AS Total_Applicants,
ROUND((SUM(Default_Status) / COUNT(*)) * 100,2) AS Default_Rate
FROM Loan_Risk
GROUP BY 1
ORDER BY  Default_Rate DESC;


-- 3. The Business Question: How dangerous is it for the bank to lend to someone who has missed EMIs in the past year?
SELECT 
Late_EMI_Count_12M,
COUNT(*) AS Total_Applicants,
SUM(default_status) AS Total_Defaulters,
ROUND((SUM(default_status) / COUNT(*)) * 100,2) AS Default_rate
FROM loan_risk
GROUP BY 1
ORDER BY 1 DESC;


-- 4. The Business Question: In which economic segment is the bank's money most heavily endangered?
SELECT
CASE 
	 WHEN Monthly_Income_INR >= 80000 THEN 'High Income'
     WHEN Monthly_Income_INR BETWEEN 35000 AND 80000 THEN 'Middle Income'
     ELSE 'Low Income'
END AS Salary_Segment,
SUM(CASE WHEN Default_Status = 1 THEN Loan_Amount_INR ELSE 0 END) AS Total_Capital_Lost_INR
FROM Loan_Risk
GROUP BY 1;


-- 5. The Business Question: Can we catch the absolute worst-performing loans by combining multiple warning signs?
SELECT 
COUNT(*) AS total_trapped_customers,
ROUND((SUM(Default_Status) / COUNT(*)) * 100, 2) AS trapped_default_rate_
FROM Loan_Risk
WHERE Late_EMI_Count_12M > 2
AND
Avg_Account_Balance_INR < (0.15 * Monthly_Income_INR);



-- 6. The Business Question: Can we find a hidden group of "safe" borrowers who have average/poor CIBIL scores but excellent modern transaction behavior,
-- whom the bank is currently rejecting?
SELECT
COUNT(*) AS Applicants,
ROUND((SUM(Default_Status) / COUNT(*)) * 100, 2) AS Default_Rate
FROM Loan_Risk
WHERE CIBIL_Score < 680 
AND
UPI_Transactions_Count_3M > 60
AND
Late_EMI_Count_12M = 0



SELECT * FROM hr_project.`hr-employee-attrition`;

--- CREATE A DUPLICATE TABLE FOR DATA CLEANING ---

CREATE TABLE hr_emp_attrition
LIKE `hr-employee-attrition`;

--- INSERT DATASETS INTO THE DUPLICATE TABLE ---

INSERT INTO hr_emp_attrition
SELECT *
FROM `hr-employee-attrition`;

--- CHEKING THE DISTINCT ROW ---

SELECT *,
ROW_NUMBER() OVER (
PARTITION BY ï»¿Age, Attrition, BusinessTravel, DailyRate, DailyRate, DistanceFromHome, Education,EducationField, EmployeeCount,
EmployeeNumber, EnvironmentSatisfaction, Gender, HourlyRate, JobInvolvement, JobLevel, JobRole, JobSatisfaction, MaritalStatus,
MaritalStatus, MonthlyIncome, MonthlyRate, NumCompaniesWorked, Over18, OverTime, PercentSalaryHike, PerformanceRating, RelationshipSatisfaction,
StandardHours, StockOptionLevel, TotalWorkingYears, TrainingTimesLastYear, WorkLifeBalance, YearsAtCompany, YearsInCurrentRole, YearsSinceLastPromotion,
YearsWithCurrManager ) AS Row_ID
FROM hr_emp_attrition;


WITH CTE_checking_dupli AS
(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY ï»¿Age, Attrition, BusinessTravel, DailyRate, DailyRate, DistanceFromHome, Education,EducationField, EmployeeCount,
EmployeeNumber, EnvironmentSatisfaction, Gender, HourlyRate, JobInvolvement, JobLevel, JobRole, JobSatisfaction, MaritalStatus,
MaritalStatus, MonthlyIncome, MonthlyRate, NumCompaniesWorked, Over18, OverTime, PercentSalaryHike, PerformanceRating, RelationshipSatisfaction,
StandardHours, StockOptionLevel, TotalWorkingYears, TrainingTimesLastYear, WorkLifeBalance, YearsAtCompany, YearsInCurrentRole, YearsSinceLastPromotion,
YearsWithCurrManager ) AS Row_ID
FROM hr_emp_attrition
)
SELECT *
FROM CTE_checking_dupli
WHERE Row_ID > 1;


--- RENAMING SOME COLUMNS NAME WITH ERRORS ---

ALTER TABLE hr_emp_attrition
RENAME COLUMN ï»¿Age TO Age;

ALTER TABLE hr_emp_attrition
RENAME COLUMN BusinessTravel TO Business_Travel;

ALTER TABLE hr_emp_attrition
RENAME COLUMN DailyRate TO Daily_Rate;

ALTER TABLE hr_emp_attrition
RENAME COLUMN Dis_From_Home TO Dist_From_Home;

ALTER TABLE hr_emp_attrition
RENAME COLUMN EducationField TO Education_Field;

ALTER TABLE hr_emp_attrition
RENAME COLUMN EmployeeCount TO Employee_Count;

ALTER TABLE hr_emp_attrition
RENAME COLUMN EmployeeNumber TO Emp_Num;

ALTER TABLE hr_emp_attrition
RENAME COLUMN EnvironmentSatisfaction TO Environ_Satisfaction;

ALTER TABLE hr_emp_attrition
RENAME COLUMN  HourlyRate TO Hourly_Rate;

ALTER TABLE hr_emp_attrition
RENAME COLUMN JobRole TO Job_Role;

ALTER TABLE hr_emp_attrition
RENAME COLUMN JobLevel TO Job_Level;

ALTER TABLE hr_emp_attrition
RENAME COLUMN JobSatisfaction TO Job_Satisfaction;

ALTER TABLE hr_emp_attrition
RENAME COLUMN MaritalStatus TO Marital_Status;

ALTER TABLE hr_emp_attrition
RENAME COLUMN MonthlyIncome TO Monthly_Income;

ALTER TABLE hr_emp_attrition
RENAME COLUMN MonthlyRate TO Monthly_Rate;

ALTER TABLE hr_emp_attrition
RENAME COLUMN NumCompaniesWorked TO Num_Companies_Worked;

ALTER TABLE hr_emp_attrition
RENAME COLUMN Over18 TO Over_18;

ALTER TABLE hr_emp_attrition
RENAME COLUMN OverTime TO Over_Time;

ALTER TABLE hr_emp_attrition
RENAME COLUMN PercentSalaryHike TO `%_Salary_Hike`;

ALTER TABLE hr_emp_attrition
RENAME COLUMN PerformanceRating TO Performance_Rating;

ALTER TABLE hr_emp_attrition
RENAME COLUMN RelationshipSatisfaction TO Relationship_Satisfaction;

ALTER TABLE hr_emp_attrition
RENAME COLUMN StandardHours TO Standard_Hours;

ALTER TABLE hr_emp_attrition
RENAME COLUMN StockOptionLevel TO Stock_Option_Level;

ALTER TABLE hr_emp_attrition
RENAME COLUMN TotalWorkingYears TO Total_Working_Years;

ALTER TABLE hr_emp_attrition
RENAME COLUMN TrainingTimesLastYear TO Training_Times_LastYear;

ALTER TABLE hr_emp_attrition
RENAME COLUMN WorkLifeBalance TO Work_Life_Balance;

ALTER TABLE hr_emp_attrition
RENAME COLUMN YearsAtCompany TO Years_At_Company;

ALTER TABLE hr_emp_attrition
RENAME COLUMN YearsSinceLastPromotion TO Years_Since_Last_Promotion;

ALTER TABLE hr_emp_attrition
RENAME COLUMN YearsInCurrentRole TO Years_In_Current_Role;

ALTER TABLE hr_emp_attrition
RENAME COLUMN YearsWithCurrManager TO Years_With_Current_Manager;

ALTER TABLE hr_emp_attrition
MODIFY COLUMN Job_Level VARCHAR(15);


--- CHECKING THE DISTINCT VALUES IN THE COLUMNS ---

SELECT DISTINCT(Business_Travel)
FROM hr_emp_attrition;

SELECT DISTINCT(Department)
FROM hr_emp_attrition;

SELECT DISTINCT(Education_Field)
FROM hr_emp_attrition;

SELECT DISTINCT(Job_Role)
FROM hr_emp_attrition;


--- UPDATING SOME VALUES ---

UPDATE hr_emp_attrition
SET Business_Travel = 'Travel Rarely'
WHERE Business_Travel = 'Travel_Rarely';

UPDATE hr_emp_attrition
SET Business_Travel = 'Travel Frequently'
WHERE Business_Travel = 'Travel_Frequently';

UPDATE hr_emp_attrition
SET Business_Travel = 'Non Travel'
WHERE Business_Travel = 'Non-Travel';

UPDATE hr_emp_attrition
SET Job_Level = 'Level 1'
WHERE Job_Level ='1';

UPDATE hr_emp_attrition
SET Job_Level = 'Level 5'
WHERE Job_Level ='5';

SELECT *
FROM hr_emp_attrition;



--- THE ATTRITION BY GENDER ---

SELECT Gender, COUNT(Attrition)
FROM hr_emp_attrition
WHERE Attrition = 'Yes'
GROUP BY Gender;

--- THE ATTRITION BY BUSINESS AND TRAVEL ---

SELECT Business_Travel, COUNT(Attrition)
FROM hr_emp_attrition
WHERE Attrition = 'Yes'
GROUP BY Business_Travel;

SELECT Department, COUNT(Attrition)
FROM hr_emp_attrition
WHERE Attrition = 'Yes'
GROUP BY Department;

--- ATTRITION BY EDUCATION_FIELD ---

SELECT Education_Field, COUNT(Attrition) AS Total_Att_By_Edu_Field
FROM hr_emp_attrition
WHERE Attrition = 'Yes'
GROUP BY Education_Field;


--- ATTRITION BY JOB ROLE ---

SELECT Job_Role, 
COUNT(Attrition) AS Total_Attrition_By_Job_Role
FROM hr_emp_attrition
WHERE Attrition = "Yes"
GROUP BY Job_Role;

--- ATTRITION BY MARITAL_STATUS ---

SELECT Marital_Status, 
COUNT(Attrition) AS Total_Attrition_By_Job_Role
FROM hr_emp_attrition
WHERE Attrition = "Yes"
GROUP BY Marital_Status;

---- THE MAX, MIN & AVERAGE DAILY_RATE ----

DELIMITER $$
CREATE PROCEDURE mman()
BEGIN
	SELECT MAX(Daily_Rate) AS Max_Daily_Rate
	FROM hr_emp_attrition
	ORDER BY Daily_Rate DESC;
    
    SELECT MIN(Daily_Rate) AS Min_Daily_Rate
    FROM hr_emp_attrition
    ORDER BY Daily_Rate DESC;
    
    SELECT AVG(Daily_Rate) AS Avg_Rate
    FROM hr_emp_attrition
    ORDER BY Daily_Rate DESC;
END $$
DELIMITER ;
    
  CALL mman(); 
  
  ---- THE MAX, MIN & AVERAGE MONTHLY_INCOME ----
  
DELIMITER $$
CREATE PROCEDURE mon()
BEGIN
	SELECT MAX(Monthly_Income) AS MaX_Monthly_Income
	FROM hr_emp_attrition
	ORDER BY Monthly_Income DESC;
    
    SELECT MIN(Monthly_Income) AS Min_Monthly_Income
    FROM hr_emp_attrition
    ORDER BY Monthly_Income DESC;
    
    SELECT AVG(Monthly_Income) AS Avg_Monthly_Income
    FROM hr_emp_attrition
    ORDER BY Monthly_Income DESC;
END $$
DELIMITER ;
    
  CALL mon(); 
  
  
  ---- THE MAX, MIN & AVERAGE HOURLY_RATE ----
  
DELIMITER $$
CREATE PROCEDURE hrl()
BEGIN
	SELECT MAX(Hourly_Rate) AS Max_Hourly_Rate
	FROM hr_emp_attrition
	ORDER BY Hourly_Rate DESC;
    
    SELECT MIN(Hourly_Rate) AS Min_Hourly_Rate
    FROM hr_emp_attrition
    ORDER BY Hourly_Rate DESC;
    
    SELECT AVG(Hourly_Rate) AS Avg_Hourly
    FROM hr_emp_attrition
    ORDER BY Hourly_Rate DESC;
END $$
DELIMITER ;
    
CALL hrl(); 
  
  --- RENAME A COLUMN ---
  
ALTER TABLE hr_emp_attrition
RENAME COLUMN Dist_From_Home TO Dist_From_Home_KM ;
 
 --- TOTAL NUMBER OF EMPLOYEESNB---
 
 SELECT COUNT(Employee_Count)
 FROM hr_emp_attrition ;
 
--- NUMBER OF EMPLOYEES LEFT ---

SELECT COUNT(Attrition)
FROM hr_emp_attrition
WHERE Attrition = 'Yes';

--- NUMBER OF GENDER WORKERS THAT LEFT ---

SELECT Gender, 
COUNT(Attrition) AS Total_Gender
FROM hr_emp_attrition
WHERE Attrition = 'Yes'
GROUP BY Gender;

--- NUMBER OF ATTRITRION BY BUSINESS TRAVEL ---

SELECT Business_Travel,
COUNT(Attrition) AS Att_By_Business_Travel
FROM hr_emp_attrition
WHERE Attrition = 'Yes'
GROUP BY Business_Travel;

--- NUMBER OF EMPLOYEES LEFT THEIR JOB IN EACH DEPARTMENT ---

SELECT Department,
COUNT(Attrition) AS Att_By_Dept
FROM hr_emp_attrition
WHERE Attrition = 'Yes'
GROUP BY Department
ORDER BY Att_By_Dept DESC;

--- ATTRITION BY EDUCATION_FIELD ---

SELECT Education_Field,
COUNT(Attrition) AS Att_By_Education_Field
FROM hr_emp_attrition
WHERE Attrition = 'Yes'
GROUP BY Education_Field
ORDER BY Att_By_Education_Field DESC;

--- ATTRITION BY JOB ROLE ----

SELECT Job_Role,
COUNT(Attrition) AS Att_By_Job_Role
FROM hr_emp_attrition
WHERE Attrition = 'Yes'
GROUP BY Job_Role
ORDER BY Att_By_Job_Role DESC;

--- ATTRITION BY JOB LEVEL ---

SELECT Job_Level,
COUNT(Attrition) AS Att_By_Job_Level
FROM hr_emp_attrition
WHERE Attrition = 'Yes'
GROUP BY Job_Level
ORDER BY Att_By_Job_Level DESC;

---- ATTRITION BY MARITAL STATUS ----

SELECT Marital_Status,
COUNT(Attrition) AS Att_By_Marital_Status
FROM hr_emp_attrition
WHERE Attrition = 'Yes'
GROUP BY Marital_Status
ORDER BY Att_By_Marital_Status DESC;


--- ATTRITION BY OVERTIME ----

SELECT Attrition, 
COUNT(Over_Time) AS Attrition_By_OverTime
FROM hr_emp_attrition
WHERE Over_Time = 'Yes'
GROUP BY Attrition ;


--- TOTAL NUMBER OF EMPLOYEE DOING OVERTIME ---

SELECT Over_Time, 
COUNT(Employee_Count) AS Atrr
FROM hr_emp_attrition
GROUP BY Over_Time;














 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    

    












SELECT *
FROM hr_emp_attrition;



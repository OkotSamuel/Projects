SELECT * FROM heart_new;
# Number of patients with heart failure
SELECT COUNT(*) as Patient_count, HeartDisease
FROM heart_new
WHERE HeartDisease = 'Heart Failure'; -- 508 records

# Number of patients who dont have heart failure
SELECT COUNT(*) as Patient_count, HeartDisease
FROM heart_new
WHERE HeartDisease <> 'Heart Failure';   -- 410 records

# Number of male patients that have heart failure
SELECT COUNT(*) as Patient_count, Sex
FROM heart_new
WHERE HeartDisease = 'Heart Failure' and Sex = 'Male'; -- 458 records

# Number of female patients with heart failure
SELECT COUNT(*) as Patient_count, Sex
FROM heart_new
WHERE HeartDisease = 'Heart Failure' and Sex = 'Female'; -- 50 records

# number of normal male patients
SELECT COUNT(*) as Patient_count, Sex
FROM heart_new
WHERE HeartDisease <>'Heart Failure' and Sex = 'Male'; -- 267 records

# Number of normal female patients
SELECT COUNT(*) as Patient_count, Sex
FROM heart_new
WHERE HeartDisease <> 'Heart Failure' and Sex = 'Female'; -- 143 records

# number of patients with RestingBp greater than 120 and have heart failure
SELECT COUNT(*) AS patient_count,HeartDisease
FROM heart_new
WHERE RestingBP > 120 AND HeartDisease = 'Heart Failure'; -- 365 records

# number of patients with RestingBp greater than 120 and dont have heart failure
SELECT COUNT(*) AS patient_count,HeartDisease
FROM heart_new
WHERE RestingBP > 120 AND HeartDisease = 'Normal'; -- 260 records

# Number of patients with ExerciseAngina and have heart failure.
SELECT COUNT(ExerciseAngina) AS count_ExerciseAngina
FROM heart_new
WHERE HeartDisease = 'Heart Failure' AND ExerciseAngina = 'Yes';-- 316 records

# Number of patients with ExerciseAngina and dont have heart failure
SELECT COUNT(ExerciseAngina) AS count_ExerciseAngina
FROM heart_new
WHERE HeartDisease <> 'Heart Failure' AND ExerciseAngina = 'Yes'; -- 55 records

# Number of patients with no ExerciseAngina and have heart failure
SELECT COUNT(ExerciseAngina) AS count_ExerciseAngina
FROM heart_new
WHERE HeartDisease = 'Heart Failure' AND ExerciseAngina = 'no'; -- 192 records

# Creating table for determine hearfailure risk factors

CREATE TABLE heart_failure_prediction AS (
SELECT 
ChestPainType,
RestingECG,
ST_Slope,
MaxHR,
HeartDisease,
	CASE
		WHEN Cholesterol < 200 THEN 'Ideal'
        WHEN Cholesterol BETWEEN 201 AND 239 THEN 'High'
        WHEN Cholesterol > 240 THEN 'Very high'
	END AS Cholesterol_level,
    
    CASE
		WHEN Oldpeak < 2 THEN 'Low'
        WHEN Oldpeak BETWEEN 1.5 AND 4.2 THEN 'Risk'
        WHEN Oldpeak > 2.55 THEN 'Terrible'
	END AS Oldpeak_level,
    
    CASE
		WHEN Age < 16 THEN 'Child'
        WHEN Age BETWEEN 17 AND 30 THEN 'Young Adult'
        WHEN Age BETWEEN 31 AND 45 THEN 'Middle_aged'
        WHEN Age > 45 THEN 'Old_aged Adults'
	END AS Age_group,
    
    CASE
		WHEN RestingBp < 120 THEN 'Normal'
        WHEN RestingBp BETWEEN 120 AND 139 THEN 'Prehypertension'
        WHEN RestingBp BETWEEN 140 AND 159 THEN 'Stage 1 Hypertension'
        WHEN RestingBp >= 160 THEN 'Stage 2 Hypertension'
	END AS Blood_pressure_level
    
    FROM heart_new);

SELECT *
FROM heart_failure_prediction;

# finding the relationship between age group and heart failure
SELECT COUNT(HeartDisease) AS Heart_failure, Age_group
FROM heart_failure_prediction
WHERE HeartDisease = 'Heart Failure'
GROUP BY Age_group;--  Old aged adults are at a higher risk of heart failure compared to middled aged 

# finding the relationship between cholesterol level and heart failure
SELECT COUNT(HeartDisease) AS Heart_failure, Cholesterol_level
FROM heart_failure_prediction
WHERE HeartDisease = 'Heart Failure'
GROUP BY Cholesterol_level; -- patients with high cholesterol levels are at risk of heart failure

# finding the relationship between ST- slope and heart failure
SELECT COUNT(HeartDisease) AS Heart_failure, ST_Slope
FROM heart_failure_prediction
WHERE HeartDisease = 'Heart Failure'
GROUP BY ST_Slope;-- Heart failure patients tend to have flat or down slope

# finding the relationship between Resting ECG and heart failure
SELECT COUNT(HeartDisease) AS Heart_failure, RestingECG
FROM heart_failure_prediction
WHERE HeartDisease = 'Heart Failure'
GROUP BY RestingECG; -- According to the results, Resting ECG is not a good indicator of heart failure.

# finding the relationship between chest pain type and heart failure
SELECT COUNT(HeartDisease) AS Heart_failure, ChestPainType
FROM heart_failure_prediction
WHERE HeartDisease = 'Heart Failure'
GROUP BY ChestPainType;-- Patients with asymptomatic chest pain are at risk of heart failure.

# Finding the realtionship between blood pressure and heart failure
SELECT COUNT(HeartDisease) AS Heart_failure, Blood_pressure_level
FROM heart_failure_prediction
WHERE HeartDisease = 'Heart Failure'
GROUP BY Blood_pressure_level; --  420 out 0f 508 heart failure patients have blood pressure. 
 #Therefore patients with blood pressure are at risk of heart failure.






		






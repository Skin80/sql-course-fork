/*
 * Tally Tables Exercise

 * The temporary table, #PatientAdmission, has values for dates between the 1st and 8th January inclusive
 * But not all dates are present
 */

DROP TABLE IF EXISTS #PatientAdmission;
CREATE TABLE #PatientAdmission (AdmittedDate DATE, NumAdmissions INT);
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-01', 5)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-02', 6)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-03', 4)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-05', 2)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-08', 2)
SELECT * FROM #PatientAdmission

/*
 * Exercise: create a resultset that has a row for all dates in that period 
 * of 8 days with NumAdmissions set to 0 for missing dates. 
 You may wish to use the SQL statements below to set the start and end dates
 */

DECLARE @StartDate DATE = DATEFROMPARTS(2024, 1, 1);
DECLARE @EndDate DATE = DATEFROMPARTS(2024, 1, 8);
DECLARE @NumDays INT = DATEDIFF(DAY, @StartDate, @EndDate) + 1;

WITH cte
AS (SELECT
    t.N
    ,DATEADD(DAY,t.N-1, @StartDate) as AdmittedDate
FROM
    TALLY t
WHERE t.N <=@NumDays)
SELECT cte.AdmittedDate
    ,ISNULL(pa.NumAdmissions,0) as NumAdmissions
 FROM cte
LEFT JOIN #PatientAdmission pa
ON cte.AdmittedDate = pa.AdmittedDate


;

/*
 * Exercise: list the dates that have no patient admissions
*/

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
SELECT @StartDate = DATEFROMPARTS(2024, 1, 1);
SELECT @EndDate = DATEFROMPARTS(2024, 1, 8);

-- write your answer here

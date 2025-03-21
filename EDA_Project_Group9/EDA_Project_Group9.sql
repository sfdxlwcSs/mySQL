create Database Group9;  -- create Database

Use  Group9; 

CREATE TABLE StudentDetails (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Gender ENUM('Male', 'Female', 'Other'),
    Address VARCHAR(255),
    SocioEconomicStatus ENUM('Low', 'Middle', 'High'),
    ScholarshipStatus ENUM('Yes', 'No'),
    Nationality VARCHAR(100)
);

CREATE TABLE PlacementData (
    StudentID INT PRIMARY KEY,
    CGPA DECIMAL(3,2),
    Internships INT,
    Projects INT,
    Workshops_Certifications INT,
    AptitudeTestScore DECIMAL(5,2),
    SoftSkillsRating DECIMAL(3,2),
    ExtracurricularActivities ENUM('Yes', 'No'),
    PlacementTraining ENUM('Yes', 'No'),
    SSC_Marks DECIMAL(5,2),
    HSC_Marks DECIMAL(5,2),
    PlacementStatus ENUM('Placed', 'Not Placed'),
    FOREIGN KEY (StudentID) REFERENCES StudentDetails(StudentID)
);


CREATE TABLE CompanyDetails (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(100),
    IndustryType VARCHAR(100),
    MinCGPARequirement DECIMAL(3,2),
    HiringStatus ENUM('Active', 'Inactive')
);

CREATE TABLE JobOffers (
    OfferID INT PRIMARY KEY,
    StudentID INT,
    CompanyID INT,
    SalaryPackage INT,
    JobRole VARCHAR(100),
    OfferStatus ENUM('Accepted', 'Rejected', 'Pending'),
    FOREIGN KEY (StudentID) REFERENCES StudentDetails(StudentID),
    FOREIGN KEY (CompanyID) REFERENCES CompanyDetails(CompanyID)
);

Alter Table joboffers
Modify column CompanyID INT NULL, -- Allowing NULLs in a foreign key column is a valid here so to demonstrate data cleaning
-- A student even though not place will have an entry in joboffers table
Modify column OfferStatus ENUM( 'Not Placed','Accepted', 'Rejected', 'Pending') NOT NULL;

ALTER TABLE PlacementData  
MODIFY StudentID INT NOT NULL;


Describe studentDetails;
SHOW COLUMNS FROM placementData;

ALTER TABLE placementData 
MODIFY COLUMN PlacementStatus ENUM('Placed', 'NotPlaced') NOT NULL; -- import was failing

--  basic statistics 
-- Count the Total Number of Students
SELECT COUNT(*) AS TotalStudents FROM studentdetails;

-- Count the Total Number of Placements
SELECT COUNT(*) AS TotalPlacements 
FROM placementdata 
WHERE PlacementStatus = 'Placed';

-- Find the  Average, Min, and Max of CGPA
SELECT 
    AVG(CGPA) AS AverageCGPA,
    MIN(CGPA) AS MinCGPA,
    MAX(CGPA) AS MaxCGPA
FROM placementdata;

-- Find the  Average, Min, and Max of SSC and HSC Marks

SELECT 
    AVG(SSC_Marks) AS AvgSSCMarks,
    MIN(SSC_Marks) AS MinSSCMarks,
    MAX(SSC_Marks) AS MaxSSCMarks,
    AVG(HSC_Marks) AS AvgHSCMarks,
    MIN(HSC_Marks) AS MinHSCMarks,
    MAX(HSC_Marks) AS MaxHSCMarks
FROM placementdata;

--  Find the  Average, Min, and Max of Salary Package in Job Offers
SELECT 
    
    AVG(SalaryPackage) AS AvgSalary,
    MIN(SalaryPackage) AS MinSalary,
    MAX(SalaryPackage) AS MaxSalary
FROM joboffers;

-- Count the Number of Students Who Got Multiple Job Offers

SELECT StudentID, COUNT(*) AS OfferCount
FROM joboffers
GROUP BY StudentID
HAVING COUNT(*) > 1;


-- Find the Minimum and Maximum Aptitude Test Score for placed students

SELECT 
    MIN(AptitudeTestScore) AS MinAptitudeScore,
    MAX(AptitudeTestScore) AS MaxAptitudeScore,
    AVG(AptitudeTestScore) AS AvgAptitudeScore
FROM placementdata where PlacementStatus='Placed';


ALTER TABLE placementdata
ADD DegreeAwarded  VARCHAR(100);

-- GET FCD HOLDERS  OFFERED STATUS

UPDATE placementdata
SET DegreeAwarded =
    CASE 
        WHEN CGPA > 9 THEN 'GOLD MEDALLIST'
        WHEN CGPA > 8 AND CGPA < 9 THEN 'FCD'
        WHEN CGPA >= 7.5 AND CGPA <=8  THEN 'FCD'
        WHEN CGPA >= 6 AND CGPA < 7.5 THEN 'FC'
        WHEN CGPA > 4 AND CGPA < 6 THEN 'SC'
        ELSE 'FAIL'
    END; 

Select * From joboffers
Where StudentId IN(
Select StudentId 
From placementdata
Where DegreeAwarded='FCD') 
AND OfferStatus IN('Pending','Not Placed');   -- There are FCD holders who have not got placed or have job offers pending

-- DATA CLEANSING NEXT
-- Placementdata table is the table tat holds the final information if a student has been placed or not
-- chances are data in joboffer table is not correct
-- a student who is not placed as per placement datatable may have been marked placed or offer pending in job offers table 
-- Lets clean that
Select * from joboffers
Where studentId IN(
Select studentId from placementdata
where PlacementStatus='NotPlaced'); -- We see 6389 rows of data in joboffers table which is not correct
-- Any inference drawn will not be correct if these data is not cleaned up.

Delete  FROM joboffers
Where studentId IN(
Select studentId from placementdata
where PlacementStatus='NotPlaced');
-- With the above operation being performed null values in companyid and SalaryPackage has been handled.

ALTER TABLE joboffers  
MODIFY StudentID INT NOT NULL;

-- Ensure data consistency make Foreing key not null 
ALTER TABLE joboffers  
MODIFY CompanyID INT NOT NULL,
MODIFY SalaryPackage INT NOT NULL;


-- Make company Name is UNIQUE in company Details 
Alter Table companydetails
ADD UNIQUE (CompanyName);

-- Add constraints
--  delete the rows from the child table automatically, when the rows from the parent table are deleted

ALTER TABLE PlacementData  
ADD CONSTRAINT fk_student FOREIGN KEY (StudentID)  
REFERENCES StudentDetails(StudentID)  
ON DELETE CASCADE;  -- Deletes placement record if student is removed

ALTER TABLE joboffers
ADD constraint   fk_StudentDelete foreign key(StudentID)
References StudentDetails(StudentID)  
ON DELETE CASCADE; -- Deletes joboffers record if student is removed

ALTER TABLE joboffers
ADD constraint   fk_CompanyDelete foreign key(CompanyID)
References companydetails(CompanyID)  
ON DELETE CASCADE; -- Deletes joboffers record if companyrecord is removed



-- GROUP BY QUERIES NEXT

-- Group Student on the basis Gender
 Select count(1),Gender 
 From studentdetails
 Group by Gender;
 
 -- Group By Scholarship Status
  Select count(1) ,ScholarshipStatus 
 From studentdetails
 Group by ScholarshipStatus;
 
 -- Group on the basis of degree
  Select count(1) ,DegreeAwarded 
 From placementdata
 Group by DegreeAwarded Order By DegreeAwarded Desc;

-- Group By Degree Awarded and Placement Status 
 Select DegreeAwarded ,PlacementStatus , COUNT(*) AS Count
 From placementdata
 Group by PlacementStatus,DegreeAwarded Order By DegreeAwarded Desc;
 
 --  Group by Internship Experience
 SELECT Internships, PlacementStatus, COUNT(*) AS Count
FROM placementdata
GROUP BY Internships, PlacementStatus
ORDER BY Internships DESC;

-- Group on the basis of job role

Select JobRole ,count(studentId) AS StudentCount
from joboffers
group by JobRole;

-- Group by Workshops/Certifications
SELECT Workshops_Certifications, PlacementStatus, COUNT(*) AS Count
FROM placementdata
GROUP BY Workshops_Certifications, PlacementStatus
ORDER BY Workshops_Certifications DESC;

-- Group on the basis of Compnay names

SELECT c.CompanyName, COUNT(j.StudentID) AS StudentCount
FROM joboffers j
JOIN companydetails c ON j.CompanyID = c.CompanyID
GROUP BY c.CompanyName
ORDER BY StudentCount DESC;

-- Group on the basis gender and display max and min Salary offered
SELECT s.Gender, 
       MAX(j.SalaryPackage) AS MaxSalary, 
       MIN(j.SalaryPackage) AS MinSalary
FROM joboffers j
JOIN studentdetails s ON j.StudentID = s.StudentID
GROUP BY s.Gender;

-- Similarly avg salary gender wise
SELECT s.Gender, 
       AVG(j.SalaryPackage) AS AvgSalary 
FROM joboffers j
JOIN studentdetails s ON j.StudentID = s.StudentID
GROUP BY s.Gender; -- Gender neutral salary

-- avg min and max salary Socio economic status wise
SELECT s.SocioEconomicStatus, 
       AVG(j.SalaryPackage) AS AvgSalary,
       MAX(j.SalaryPackage) AS MaxSalary, 
       MIN(j.SalaryPackage) AS MinSalary
FROM joboffers j
JOIN studentdetails s ON j.StudentID = s.StudentID
GROUP BY s.SocioEconomicStatus 
Order by AvgSalary desc; -- Gender neutral salary
-- grouping on basis of placement staus and infer students acpa and aptitude test score
SELECT placementStatus, 
       Count(StudentID) AS StudentCount,
       AVG(cgpa) AS AvgCGPA, 
       AVG(AptitudeTestScore) AS AvgAptitudeScore
FROM placementdata 
GROUP BY placementStatus;

SELECT 
    (COUNT(CASE WHEN PlacementStatus = 'Placed' THEN 1 END) * 100.0 / COUNT(StudentID)) AS PlacementPercentage
FROM placementdata;




-- Grouping Students on the basis of Social economic status ,degree awarded,job offers

SELECT 
    s.SocioEconomicStatus, 
    p.DegreeAwarded,
    COUNT(j.StudentID) AS OfferCount,  -- Count of job offers
    AVG(j.SalaryPackage) AS AvgSalary  -- Average salary for the group
FROM studentdetails s
JOIN placementdata p ON s.StudentID = p.StudentID
LEFT JOIN joboffers j ON s.StudentID = j.StudentID
GROUP BY s.SocioEconomicStatus, p.DegreeAwarded
ORDER BY OfferCount DESC; -- Sort to see the most offers first





--__________



 



-- ***SOMNATH ***---

*** SUMANTH---

-- Use window functions to perform calculations across a set of table rows related to the current row
-- Calculate the Average Salary for Each Company (Partition by Company)
SELECT 
    j.StudentID,
    c.CompanyName,
    j.SalaryPackage,
    AVG(j.SalaryPackage) OVER (PARTITION BY j.CompanyID) AS Avg_Salary
FROM 
    joboffers j
JOIN 
    companydetails c ON j.CompanyID = c.CompanyID;

 


    
        
    














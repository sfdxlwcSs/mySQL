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

ALTER TABLE PlacementData  
MODIFY StudentID INT NOT NULL;
-- Ensure Every Student Must Have a Placement Record

ALTER TABLE PlacementData  
ADD CONSTRAINT fk_student FOREIGN KEY (StudentID)  
REFERENCES StudentDetails(StudentID)  
ON DELETE CASCADE;  -- Deletes placement record if student is removed

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
    SUM(HSC_Marks) AS TotalHSCMarks,
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


-- Find the Minimum and Maximum Aptitude Test Score

SELECT 
    MIN(AptitudeTestScore) AS MinAptitudeScore,
    MAX(AptitudeTestScore) AS MaxAptitudeScore,
    AVG(AptitudeTestScore) AS AvgAptitudeScore
FROM placementdata;


ALTER TABLE placementdata
ADD DegreeAwarded  VARCHAR(100);

UPDATE placementdata
SET DegreeAwarded = 'FCD', City = 'Frankfurt'
WHERE CustomerID = 1; -- work in progress















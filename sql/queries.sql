#Database Management System, 2024

-- Scripts for queries:

-- Basic SQL queries 


-- selecting male member's name and country from athlete table who live in Bangladesh and India

SELECT name, country
FROM Athlete
WHERE gender = 'M'
AND country IN ('Bangladesh', 'India');

-- selecting name and gender from the table Team where number of athletes are betwee 20 to 25

SELECT name, gender
FROM Team
WHERE num_athletes BETWEEN 
      20 AND 25;
      
      
-- finding venues that have name with 'e' as the 2nd letter

SELECT * 
FROM Venue
WHERE name LIKE '_e%';

-- finding when supervisor_coachID is not null
SELECT coachID, name, supervisor_coachID
FROM Coaches
WHERE supervisor_coachID IS NOT NULL;

-- removing duplicates and NULL value of education from Athlete table
SELECT DISTINCT education
FROM Athlete
WHERE education IS NOT NULL;

-- finding the female coaches who are experienced from 3 to 6 years and trauncating to 1 decimal place
SELECT name, TRUNCATE(experience, 1) AS RoundedExperience
FROM Coaches
WHERE experience BETWEEN 3 AND 6
   AND gender ='F';
   
-- Using DATEDIFF and SYSDATE() function to find out the medals that were awarded between 70 and 72 days ago.
SELECT medalID, medalType, 
DATEDIFF(SYSDATE(), medalDate) AS daysSinceAwarded
FROM Medalists
WHERE DATEDIFF(SYSDATE(), medalDate) >= 70 
AND DATEDIFF(SYSDATE(), medalDate) <= 72;

-- Applying Theta join to find out medalists participating in an event where the event type is "combat"
SELECT medalID, medalType, Medalists.athleteID, Event.name AS eventName
FROM Medalists JOIN Event ON Medalists.eventID = Event.eventID
WHERE Event.type = 'combat';

-- Applying INNER JOIN between event and venue tables
SELECT eventID, Event.name AS eventName, Venue.name AS venueName
FROM Event INNER JOIN Venue ON Venue.venueCountry = 'France' 
AND Event.venueCode = Venue.venueCode;


-- performing a NATURAL RIGHT JOIN between Guides and Coaches tables.
SELECT *
FROM Guides
NATURAL RIGHT JOIN Coaches;

-- Self join to the table Team to find out the teams from the same country
SELECT T1.teamID AS T1ID, T2.teamID AS T2ID, T1.country
FROM Team AS T1
JOIN Team AS T2
ON (T1.country = T2.country AND T1.teamID <> T2.teamID);

-- Self join to the table Team to find out the teams from the Canada
SELECT T1.teamID AS T1ID, T2.teamID AS T2ID, T1.country
FROM Team AS T1
JOIN Team AS T2
ON (T1.country = T2.country AND T1.teamID <> T2.teamID)
WHERE T1.country = 'Canada';

-- Sorting Venue table where capacity is larger than 40000 and avoiding duplicate data
SELECT DISTINCT name, venueCountry, capacity
FROM Venue
WHERE capacity >= 40000
ORDER BY capacity;


-- finding average experience of coaches group by gender
SELECT gender, ROUND(AVG(experience), 2) AS average_experience
FROM Coaches
GROUP BY gender;

-- Store Procedure
-- to see the availavle procedure:
-- SHOW PROCEDURE STATUS WHERE Db='OlympicsDBS_Portfolio';

DELIMITER //
DROP PROCEDURE IF EXISTS AddAthlete;
CREATE PROCEDURE AddAthlete(
    IN athltid INT,
    IN tmid INT,
    IN nam VARCHAR(20),
    IN gndr CHAR(1),
    IN cntry VARCHAR(20),
    IN edctn VARCHAR(20)
)
COMMENT 'inserting values into athlete tables and updating athlete No in Team table' 
BEGIN
    INSERT INTO Athlete (athleteID, teamID, name, gender, country, education)
    VALUES (athltid, tmid, nam, gndr, cntry, edctn);
    UPDATE Team
    SET num_athletes = num_athletes + 1
    WHERE teamID = tmid;
END //

DELIMITER ;

CALL AddAthlete(1389027, 175, 'Jarmain Karim', 'M', 'USA', 'Masters');


----
DROP PROCEDURE IF EXISTS CategorizeExperience;

DELIMITER //

CREATE PROCEDURE CategorizeExperience(
    IN cntry VARCHAR(20),
    OUT ctgry VARCHAR(20)
)
BEGIN
    DECLARE avgExperience DECIMAL(5, 2);

-- Calculate the average experience
    SELECT AVG(experience)
    INTO avgExperience
    FROM Coaches
    WHERE country = cntry;

-- Categorize based on the average experience
    IF avgExperience IS NULL THEN
        SET ctgry = 'No coaches found for the given country.';
    ELSEIF avgExperience < 4 THEN
        SET ctgry = 'Beginner';
    ELSEIF avgExperience BETWEEN 4 AND 9 THEN
        SET ctgry = 'Intermediate';
    ELSE
        SET ctgry = 'Advanced';
    END IF;
END //

DELIMITER ;

CALL CategorizeExperience('France', @category);
SELECT @category; 

-- Triggers

-- Updating capacity of venues in France and Spain
UPDATE Venue
SET capacity = 50000
WHERE venueCountry IN ('France', 'Spain');


DROP TRIGGER IF EXISTS beforeVenueUpdate;

DELIMITER //

CREATE TRIGGER beforeVenueUpdate
BEFORE UPDATE
ON Venue FOR EACH ROW
BEGIN
    IF NEW.capacity < 40000 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Capacity cannot be lower than 40,000.';
    END IF;
END //

DELIMITER ;

-- Test with valid capacity
UPDATE Venue
SET capacity = 45000 
WHERE venueCountry = 'France';

-- Test with lower capacity
UPDATE Venue
SET capacity = 35000
WHERE venueCountry = 'France' LIMIT 1; 

SELECT * FROM Venue WHERE venueCountry='France';


-- Creating VIEWS

DROP VIEW IF EXISTS AthleteParticipation;

CREATE VIEW AthleteParticipation AS
SELECT 
    p.athleteID,  
    a.name AS athleteName,          
    p.eventID,  
    e.name AS eventName,         
    p.role,              
    p.score          
       
FROM 
    Participates p
JOIN 
    Athlete a ON p.athleteID = a.athleteID  
JOIN 
    Event e ON p.eventID = e.eventID;    
    
-- Testing the view
SELECT * FROM AthleteParticipation;
  




















































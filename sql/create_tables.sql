#Database Management System, 2024

-- Scripts to create tables:

SET FOREIGN_KEY_CHECKS = 0;

-- Participates table
DROP TABLE IF EXISTS Participates;

CREATE TABLE Participates(
    athleteID INT,
    eventID INT,
    role VARCHAR(20),
    score DECIMAL(5,2),
    PRIMARY KEY (athleteID, eventID),
    CONSTRAINT fk_participates_Athlete
        FOREIGN KEY (athleteID)
        REFERENCES Athlete(athleteID),
    CONSTRAINT fk_participates_Event
        FOREIGN KEY (eventID)
        REFERENCES Event(eventID)
);

-- Medalists table
DROP TABLE IF EXISTS Medalists;

CREATE TABLE Medalists(
    medalID INT PRIMARY KEY,
    athleteID INT,
    eventID INT,
    medalType VARCHAR(10),
    medalDate DATE,
    CONSTRAINT fk_Medalist_Athlete
        FOREIGN KEY (athleteID)
        REFERENCES Athlete(athleteID),
    CONSTRAINT fk_Medalist_Event
        FOREIGN KEY (eventID)
        REFERENCES Event(eventID)
);

-- Guides table
DROP TABLE IF EXISTS Guides;

CREATE TABLE Guides(
    coachID INT,
    teamID INT,
    duration DECIMAL(5,2),  
    PRIMARY KEY (coachID, teamID),
    CONSTRAINT fk_guides_Coach
        FOREIGN KEY (coachID)
        REFERENCES Coaches(coachID),
    CONSTRAINT fk_guides_Team
        FOREIGN KEY (teamID)
        REFERENCES Team(teamID)
);





-- AthleteLanguages table
DROP TABLE IF EXISTS AthleteLanguages;

CREATE TABLE AthleteLanguages(
    athleteID INT,
    language VARCHAR(20),
    PRIMARY KEY (athleteID, language),
    CONSTRAINT fk_Athlete
        FOREIGN KEY (athleteID)
        REFERENCES Athlete(athleteID)
);

-- Athlete table
DROP TABLE IF EXISTS Athlete;

CREATE TABLE Athlete(
    athleteID INT PRIMARY KEY,
    teamID INT,
    name VARCHAR(20) NOT NULL,
    gender CHAR(1),  
    country VARCHAR(20),
    education VARCHAR(20),
    CONSTRAINT fk_Team
        FOREIGN KEY (teamID)
        REFERENCES Team(teamID)
);

-- Event table
DROP TABLE IF EXISTS Event;

CREATE TABLE Event(
    eventID INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    type VARCHAR(20),
    venueCode INT,  
    CONSTRAINT fk_Venue
        FOREIGN KEY (venueCode)
        REFERENCES Venue(venueCode)
);

-- Coaches table
DROP TABLE IF EXISTS Coaches;

CREATE TABLE Coaches(
    coachID INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    gender CHAR(1),  
    country VARCHAR(20),
    experience DECIMAL(5,2) DEFAULT 3.50,  
    supervisor_coachID INT,
    CONSTRAINT fk_Coach
        FOREIGN KEY (supervisor_coachID)
        REFERENCES Coaches(coachID) 
);



-- Team table
DROP TABLE IF EXISTS Team;

CREATE TABLE Team(
    teamID INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    gender CHAR(1),  
    country VARCHAR(20),
    num_athletes INT DEFAULT 0
);


-- Venue table
DROP TABLE IF EXISTS Venue;

CREATE TABLE Venue(
    venueCode INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    venueCountry VARCHAR(20),
    capacity INT DEFAULT 250
);



-- Create tables in the correct order
DROP TABLE IF EXISTS TechnicalOfficials;

-- TechnicalOfficials table
CREATE TABLE TechnicalOfficials(
    officialsID INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    gender CHAR(1) NOT NULL,  
    country VARCHAR(20),
    category VARCHAR(20) 
);
































































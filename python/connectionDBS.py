#Database Management System, 2024

#connecting my database to Python 3
#Calling queries that are already defined 
#perorming inserting, updating, deleting data

import os
import mysql.connector

#username and password from environment variables
user = os.environ['DBS_USER']
password = os.environ['DBS_PASS']

#Establishing connection to the database
conn = mysql.connector.connect(
    user=user,
    password=password,
    host='127.0.0.1',
    database='OlympicsDBS_Portfolio'
)

#Checking if the connection is successful
if conn.is_connected():
    print("Connected to the database")
else:
    print("Connection failed")


# Createing a cursor object
cursor = conn.cursor()

#Query 1: Selecting male members from Bangladesh and India
query1 = """
SELECT name, country
FROM Athlete
WHERE gender = 'M'
AND country IN ('Bangladesh', 'India')
"""

cursor.execute(query1)
rows1 = cursor.fetchall()
print("Query 1 Results- Selecting male members from Bangladesh and India")
for row in rows1:
    print(row)

#Query 2: Selecting teams with athletes between 20 and 25
query2 = """
SELECT name, gender
FROM Team
WHERE num_athletes BETWEEN 20 AND 25
"""

cursor.execute(query2)
rows2 = cursor.fetchall()
print("\nQuery 2 Results- Selecting teams with athletes between 20 and 25")
for row in rows2:
    print(row)

#Query 3: Finding venues with 'e' as the 2nd letter
query3 = """
SELECT *
FROM Venue
WHERE name LIKE '_e%'
"""

cursor.execute(query3)
rows3 = cursor.fetchall()
print("\nQuery 3 Results-Finding venues with 'e' as the 2nd letter")
for row in rows3:
    print(row)


#Query 4: Finding records where supervisor_coachID is not NULL
query4 = """
SELECT coachID, name, supervisor_coachID
FROM Coaches
WHERE supervisor_coachID IS NOT NULL
"""

cursor.execute(query4)
rows4 = cursor.fetchall()
print("\nQuery 4 Results:")
for row in rows4:
    print(row)

#Query 5: Removing duplicates and NULL values from education in Athlete table
query5 = """
SELECT DISTINCT education
FROM Athlete
WHERE education IS NOT NULL
"""

cursor.execute(query5)
rows5 = cursor.fetchall()
print("\nQuery 5 Results:")
for row in rows5:
    print(row)

#Query 6: Finding female coaches experienced between 3 to 6 years, rounded to 1 decimal place
query6 = """
SELECT name, TRUNCATE(experience, 1) AS RoundedExperience
FROM Coaches
WHERE experience BETWEEN 3 AND 6
AND gender = 'F'
"""

cursor.execute(query6)
rows6 = cursor.fetchall()
print("\nQuery 6 Results:")
for row in rows6:
    print(row)

#Query 7: Finding medals awarded between 70 and 72 days ago using DATEDIFF and SYSDATE()
query7 = """
SELECT medalID, medalType, 
DATEDIFF(SYSDATE(), medalDate) AS daysSinceAwarded
FROM Medalists
WHERE DATEDIFF(SYSDATE(), medalDate) >= 70 AND DATEDIFF(SYSDATE(), medalDate) <= 72
"""

cursor.execute(query7)
rows7 = cursor.fetchall()
print("\nQuery 7 Results:")
for row in rows7:
    print(row)

#Query 8: Applying Theta Join to find out medalists participating in combat events
query8 = """
SELECT medalID, medalType, Medalists.athleteID, Event.name AS eventName
FROM Medalists JOIN Event ON Medalists.eventID = Event.eventID
WHERE Event.type = 'combat'
"""

cursor.execute(query8)
rows8 = cursor.fetchall()
print("\nQuery 8 Results:")
for row in rows8:
    print(row)

#Query 9: Applying INNER JOIN between Event and Venue tables
query9 = """
SELECT eventID, Event.name AS eventName, Venue.name AS venueName
FROM Event 
INNER JOIN Venue ON Venue.venueCode = Event.venueCode
WHERE Venue.venueCountry = 'France'
"""

cursor.execute(query9)
rows9 = cursor.fetchall()
print("\nQuery 9 Results:")
for row in rows9:
    print(row)

#Query 10: Performing a NATURAL RIGHT JOIN between Guides and Coaches tables
query10 = """
SELECT *
FROM Guides
NATURAL RIGHT JOIN Coaches
"""

cursor.execute(query10)
rows10 = cursor.fetchall()
print("\nQuery 10 Results:")
for row in rows10:
    print(row)

#Query 11: Self join to find teams from the same country
query11 = """
SELECT T1.teamID AS T1ID, T2.teamID AS T2ID, T1.country
FROM Team AS T1
JOIN Team AS T2
ON T1.country = T2.country AND T1.teamID <> T2.teamID
"""

cursor.execute(query11)
rows11 = cursor.fetchall()
print("\nQuery 11 Results:")
for row in rows11:
    print(row)

#Query 12: Self join to find teams from Canada
query12 = """
SELECT T1.teamID AS T1ID, T2.teamID AS T2ID, T1.country
FROM Team AS T1
JOIN Team AS T2
ON T1.country = T2.country AND T1.teamID <> T2.teamID
WHERE T1.country = 'Canada'
"""

cursor.execute(query12)
rows12 = cursor.fetchall()
print("\nQuery 12 Results:")
for row in rows12:
    print(row)

#Query 13: Sorting Venue table where capacity is larger than 40,000 and avoiding duplicates
query13 = """
SELECT DISTINCT name, venueCountry, capacity
FROM Venue
WHERE capacity >= 40000
ORDER BY capacity
"""

cursor.execute(query13)
rows13 = cursor.fetchall()
print("\nQuery 13 Results:")
for row in rows13:
    print(row)

#Query 14: Finding average experience of coaches grouped by gender
query14 = """
SELECT gender, ROUND(AVG(experience), 2) AS average_experience
FROM Coaches
GROUP BY gender
"""

cursor.execute(query14)
rows14 = cursor.fetchall()
print("\nQuery 14 Results:")
for row in rows14:
    print(row)


#Now, I will insert, update, delete some data

#Inserting data into Coach table without Supervisor

insert_query1 = """
INSERT INTO Coaches (coachID, name, gender, country, experience, supervisor_coachID)
VALUES (%s, %s, %s, %s, %s, %s)
"""
new_coaches = [
    (351, 'PEREZ Karim', 'M', 'Zambia', 9.8, None),
    (352, 'Kamal Khan', 'M', 'Korea', 8.8, None),
    (353, 'Parvin Akter', 'F', 'India', 6.2, None),
    (354, 'Daniel Garcia', 'M', 'Denmark', 3.8, None),
    (355, 'Emily Davis', 'F', 'Argentina', 3.7, None),
    (356, 'Sarah Martinez', 'F', 'UAE', 8.1, None),
    (357, 'James Brown', 'M', 'Canada', 7.4, None),
    (358, 'Jessica Hernandez', 'F', 'France', 4.5, None),
    (359, 'Linda Thompson', 'F', 'UK', 7.2, None),
    (360, 'David Williams', 'M', 'USA', 8.5, None),
    (361, 'Olivia Wilson', 'F', 'Brazil', 6.3, None),
    (362, 'Sarah Parvin', 'F', 'UAE', 4.8, None),
    (363, 'Emily Thompson', 'F', 'Maxico', 5.2, None),
    (364, 'Michael Johnson', 'M', 'Korea', 5.8, None),
    (365, 'Alexander Smith', 'M', 'USA', 7.8, None)
]

cursor.executemany(insert_query1, new_coaches)
conn.commit()  
print("\nInserted new coaches into the Coaches table without supervisor.")


#Inserting data into Coach table with Supervisor

insert_query2 = """
INSERT INTO Coaches (coachID, name, gender, country, experience, supervisor_coachID)
VALUES (%s, %s, %s, %s, %s, %s)
"""
new_coaches = [
    (1478901, 'Jessica Hernandez', 'F', 'France', 4.5, 358),
    (1438702, 'Parvin Akter', 'F', 'India', 6.2, 353),
    (1346532, 'Emily Thompson', 'F', 'Maxico', 5.2, 363),
    (1980452, 'Emily Davis', 'F', 'Argentina', 3.7, 355),
    (1287903, 'Sarah Martinez', 'F', 'UAE', 8.1, 356),
    (1672340, 'James Brown', 'M', 'Canada', 7.4, 357),
    (1978023, 'Alexander Smith', 'M', 'USA', 7.8, 365),
    (1793076, 'Linda Thompson', 'F', 'UK', 7.2, 359),
    (1470936, 'David Williams', 'M', 'USA', 8.5, 360),
    (1830982, 'Olivia Wilson', 'F', 'Brazil', 6.3, 361),
    (1629065, 'Sarah Parvin', 'F', 'UAE', 4.8, 362),
    (1705782, 'Daniel Garcia', 'M', 'Denmark', 3.8, 354),
    (1378932, 'Michael Johnson', 'M', 'Korea', 5.8, 364),
    
]

cursor.executemany(insert_query2, new_coaches)

conn.commit()  
print("\nInserted new coaches into the Coaches table sith supervisor.")

#updating data in Event table
#Changing event type from water to swimming

update_event_query = """
UPDATE Event
SET type = %s
WHERE type = %s
"""
updated_event_type = ("swimming", "water")

cursor.execute(update_event_query, updated_event_type)
conn.commit()  
print("\nUpdated the event type where it was 'water'.")


#deleting data from the table

delete_athleteLanguages_query = """
DELETE FROM AthleteLanguages
WHERE language = %s
"""

languageToDelete = ('Bengali',)

cursor.execute(delete_athleteLanguages_query, languageToDelete)
conn.commit() 
print("\nDeleted athleteIDs speaking Bengali.")

cursor.close()
conn.close()














































# Close the cursor and connection
#cursor.close()
#conn.close()

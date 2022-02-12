/* Question 1- 
List all the people in the passenger table, including their name, itinerary number, fare, and confirmation number. Order by
name and fare.*/
 
 SELECT PAS_NAME, PAS_ITINERARY_NO, PAS_FARE, PAS_CONFIRM_NO
 FROM PASSENGER
 ORDER BY PAS_NAME, PAS_FARE;
 
/*Question 2- 
Using an “OR” operator, list pilot name, state, zip code, and flight pay for pilots who make more than $2,500 per flight and
live in either Houston or Phoenix.*/
 
SELECT PIL_PILOTNAME, PIL_STATE, PIL_CITY, PIL_ZIP, PIL_FLIGHT_PAY
FROM PILOTS
WHERE PIL_FLIGHT_PAY > 2500 AND (PIL_CITY = 'HOUSTON' OR PIL_CITY = 'PHOENIX');

/*Question 3- 
Using an “IN”, list pilot names, zip and flight pay for pilots who make more than $2,500 per flight and live in either Houston
or Phoenix.*/

SELECT PIL_PILOTNAME, PIL_ZIP, PIL_FLIGHT_PAY
FROM PILOTS
WHERE PIL_FLIGHT_PAY > 2500 AND PIL_CITY  IN ('HOUSTON', 'PHOENIX');

/*Question 4- 
Using an “AND” and an “OR”, list all information (Equipment Number, Equipment Type, Seat Capacity, Fuel Capacity, and
Miles per Gallon) on aircraft that have a seat capacity less than 280, or aircraft that have a miles per gallon greater than 4.0
miles per gallon and fuel capacity less than 2000.*/

SELECT * FROM EQUIP_TYPE
WHERE EQ_SEAT_CAPACITY < 280 OR (EQ_MILES_PER_GAL > 4.0 AND EQ_FUEL_CAPACITY < 2000);

/* Question 5- 
Using PATTERN MATCHING (the LIKE operation), select all information for airports in Los Angeles.*/

SELECT * FROM AIRPORT
WHERE AIR_LOCATION LIKE 'Los%';

/* Question 6- 
Using a HAVING statement, produce a unique list of pilot Id's of pilots who piloted more than 20 departures. Order by pilot
id ascending.*/

SELECT DISTINCT DEP_PILOT_ID
FROM DEPARTURES
GROUP BY DEP_PILOT_ID
HAVING COUNT (DEP_PILOT_ID) > 20
ORDER BY DEP_PILOT_ID;

/* Question 7- 
List all flights showing flight number, flight fare, flight distance, and the miles flown per dollar (distance/fare) as “Miles Flown
Per Dollar” that have miles per dollar greater than $5.50, and sort by miles flown per dollar descending. Make sure to name
the attributes as shown in the example output.
You can learn round () function by yourself and try to apply it here so your “Miles Flown Per Dollar” column is round to two
decimal places. However, you won’t lose points if you don’t use round function.*/

SELECT FL_FLIGHT_NO AS "Flight Number", FL_FARE AS "Fare", FL_DISTANCE AS "Distance", ROUND(FL_DISTANCE/ FL_FARE, 2) AS "MILES FLOWN PER DOLLAR"
FROM FLIGHT
WHERE (FL_DISTANCE/ FL_FARE) > 5.50
ORDER BY "MILES FLOWN PER DOLLAR" DESC;

/* Question 8- 
Display airport location and number of departing flights as "Number of departing Flights".*/

SELECT A.AIR_LOCATION, COUNT(F.FL_FLIGHT_NO) AS "NUMBER OF DEPARTING FLIGHTS"
FROM AIRPORT A
JOIN FLIGHT F
ON FL_ORIG = AIR_COD
GROUP BY A.AIR_LOCATION;

/*Question 9- 
List the maximum pay, minimum pay and average flight pay by state for pilots. Make sure to name the attributes as shown in
the example output. */

SELECT PIL_STATE AS "STATE", MAX(PIL_FLIGHT_PAY) AS "MAX PAY", MIN(PIL_FLIGHT_PAY) AS "MIN PAY" , AVG(PIL_FLIGHT_PAY) AS "AVG PAY"
FROM PILOTS
GROUP BY PIL_STATE;

/* Question 10- 
Display pilot name and departure date of his first flight. Order by pilot name. Hint: you will need pilots and departures tables.*/

SELECT DISTINCT P.PIL_PILOTNAME, MIN(D.DEP_DEP_DATE) AS "FIRST DEPARTURE"
FROM PILOTS P
JOIN DEPARTURES D
ON PIL_PILOT_ID = DEP_PILOT_ID
GROUP BY P.PIL_PILOTNAME
ORDER BY P.PIL_PILOTNAME;

/* Question 11- 
For each unique equipment type, List the equipment types and maximum miles that can be flown as "Maximum Distance
Flown". Order by maximum distance descending.*/

SELECT DISTINCT EQ_EQUIP_TYPE, (EQ_FUEL_CAPACITY * EQ_MILES_PER_GAL) AS "MAXIMUM DISTANCE FLOWN"
FROM EQUIP_TYPE 
ORDER BY "MAXIMUM DISTANCE FLOWN" DESC;

/* Question 12-
List the number of flights originating from each airport as NUMBER_OF_FLIGHTS. Hint: you will need to use count function. */

SELECT FL_ORIG, COUNT(FL_FLIGHT_NO) AS "NUMBER_OF_FLIGHTS"
FROM FLIGHT
GROUP BY FL_ORIG;

/* Question 13-
Using an “OR” statement and a “WHERE” join, display flight number, origination and departure for flights that originate from
an airport that does not have a hub airline or flights that originate from an airport that is a hub for American Airlines.  */

SELECT FL_FLIGHT_NO, FL_ORIG, FL_DEST, AIR_CODE, AIR_HUB_AIRLINE
FROM FLIGHT 
JOIN AIRPORT 
ON FL_ORIG = AIR_CODE
WHERE AIR_HUB_AIRLINE IS NULL OR AIR_HUB_AIRLINE = 'American';

/* Question 14- 
Display the flight number, departure date and equipment type for all equipment that is manufactured by Concorde. Order by
departure date and flight number. Need to use “like” keyword in your query.*/

SELECT D.DEP_FLIGHT_NO, D.DEP_DEP_DATE, E.EQ_EQUIP_TYPE
FROM DEPARTURES D
JOIN EQUIP_TYPE E
ON D.DEP_EQUIP_NO = E.EQ_EQUIP_NO
WHERE E.EQ_EQUIP_TYPE LIKE 'CON%'
ORDER BY D.DEP_DEP_DATE, D.DEP_FLIGHT_NO;

/* Question 15- 
Using a SUB QUERY, display the IDs and names of pilots who are not currently scheduled for a departure. Hint: you will use
“not in” keyword. */

SELECT PIL_PILOT_ID, PIL_PILOTNAME
FROM PILOTS
WHERE PIL_PILOT_ID 
         NOT IN (SELECT DEP_PILOT_ID
                FROM DEPARTURES );

/* Question 16- 
Using “IS NULL” and an OUTER JOIN, display the IDs and names of pilots who are not currently scheduled for a departure.*/

SELECT P.PIL_PILOT_ID, P.PIL_PILOTNAME
FROM PILOTS P
FULL OUTER JOIN DEPARTURES D
ON P.PIL_PILOT_ID = D.DEP_PILOT_ID
WHERE DEP_DEP_DATE IS NULL;

/* Question 17- 
Display passenger name and seat number, as "Seat Number", for flight 101, departing on July 15, 2017 order by “Seat
Number” */

SELECT P.PAS_NAME, T.TIC_SEAT
FROM PASSENGER P
JOIN TICKET T
ON P.PAS_ITINERARY_NO = T.TIC_ITINERARY_NO
WHERE T.TIC_FLIGHT_NO = 101 AND T.TIC_FLIGHT_DATE = '15-JUL-17'
ORDER BY T.TIC_SEAT;

/* Question 18- 
List flight number, departure date and number of passengers as "Number of Passengers" for departures that have more than
5 passengers.*/

SELECT D.DEP_FLIGHT_NO AS "FLIGHT NUMBER", D.DEP_DEP_DATE AS "DATE", COUNT(P.PAS_CONFIRM_NO) AS "NUMBER OF PASSENGERS"
FROM DEPARTURES D
JOIN TICKET T
ON DEP_FLIGHT_NO = TIC_FLIGHT_NO
JOIN PASSENGER P
ON TIC_ITINERARY_NO = PAS_ITINERARY_NO
GROUP BY DEP_FLIGHT_NO, DEP_DEP_DATE
HAVING COUNT(PAS_CONFIRM_NO) > 5;

/* Question 19- 
Select flight number, origination and destination for all reservations booked by Andy Anderson, Order results by flight
number. */

SELECT FL_FLIGHT_NO, FL_ORIG, FL_DEST
FROM FLIGHT
WHERE FL_FLIGHT_NO 
IN (SELECT DEP_FLIGHT_NO
    FROM DEPARTURES
    WHERE DEP_FLIGHT_NO
    IN (SELECT RES_FLIGHT_NO 
        FROM RESERVATION
        WHERE RES_NAME = 'Andy Anderson'))
ORDER BY FL_FLIGHT_NO;

/*Question 20- 
Display departing airport code as "Departs From", arriving airport code as "Arrives at", and minimum fair as "Minimum Fair",
for flights that have minimum fare for flights between these two airports.*/ 


SELECT FL_ORIG AS "Departs from", FL_DEST as "Arrives at", MIN(FL_FARE) as "Minimum Fair"
FROM FLIGHT
GROUP BY FL_ORIG, FL_DEST;

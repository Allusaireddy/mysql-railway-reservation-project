Railway Reservation System

Train – train details
•	Passenger – passenger information
•	Ticket – booking details
•	Train_Route – station-wise route of each train
•	Train_Ticket_Fare – fare details for each class in each train
Using these tables, you must write SQL queries to filter, sort, and retrieve data like trains list, senior citizens, station codes, unconfirmed passengers, and AC coach fares.




1.Given the schema of Railway Reservation System, write a query to list all the trains in ascending order of train number.
2.Given the schema of Railway Reservation System, write a query to list the senior citizen passenger details. Sort the output by ascending order of passenger names.
Note: Refer the table Passenger from the given schema. Age of senior citizen should be greater than or equal to 60. Table names are case sensitive
3.Given the schema of Railway Reservation System, write a query to list the station names where station code starts with 'M'. Sort the output by ascending order of station code.
 Note: Refer the table Train_Route from the given schema. Table names are case sensitive.
4.Given the schema of Railway Reservation System, write a query to list the passenger names whose tickets are not con rmed. Sort the output by descending order of passenger names.
 Note: Refer the table Passenger from the given schema. The con rmed tickets will have 'reservation_status' as 'CONFIRM' Table names are case sensitive.
5.Given the schema of Railway Reservation System, write a query to list the distinct base fare of all AC coaches available in each train. Class Field can contain :AC CHAIR CAR, 2 TIER AC,1 TIER AC, 3 TIER AC , SLEEPER Sort the output by ascending order of base_fare.
Note: Refer the table Train_Ticket_Fare from the given schema. class eld should contain 'AC' in its description to nd the AC coaches. Table names are case sensitive. 
6. Given the schema of Railway Reservation System, write a query to nd the train names that are from Chennai to Mumbai, but do not have the source or destination in its name (train_name). Sort the output by descending order of train name
7. Given the schema of Railway Reservation System, write a query to nd the passengers(PNRNo, name, age) whose date of journey is 30 days from today. (Consider today's date as '2019-09-01' (YYYY-MM-DD)) Sort the output by ascending order of PNRNo and passenger name.
8.Given the schema of Railway Reservation System, write a query to print the train names in upper case along with the train number. Sort the output by ascending order of train name.
9. Given the schema of Railway Reservation System, write a query to print the station codes replacing 'M' with 'K' along with the station name. Sort the output by ascending order of station code.
10. Given the schema of Railway Reservation System, write a query to display the PNR number and transaction id, if transaction id is null, print 'not generated'. Sort the output by ascending order of PNR Number


-- ------------------------------------------------
-- Railway Reservation System schema 
-- ------------------------------------------------

-- 1) Train table
CREATE TABLE Train (
    train_number INT PRIMARY KEY,
    train_name VARCHAR(150) NOT NULL,
    source VARCHAR(100),
    destination VARCHAR(100),
    start_time TIME,
    reach_time TIME,
    traveltime VARCHAR(20),
    distance INT,
    class VARCHAR(100),
    days VARCHAR(100),
    type VARCHAR(50)
);

-- sample trains
INSERT INTO Train (train_number, train_name, source, destination, start_time, reach_time, traveltime, distance, class, days, type) VALUES
(12601, 'Chennai Express', 'Chennai', 'Mumbai', '06:00:00', '18:00:00', '12:00', 1210, 'AC CHAIR CAR, 3 TIER AC, SLEEPER', 'Daily', 'Express'),
(12951, 'Coastal Mail', 'Chennai', 'Mumbai', '08:00:00', '22:00:00', '14:00', 1300, '2 TIER AC, 3 TIER AC, SLEEPER', 'Daily', 'Mail'),
(13007, 'Kaveri Superfast', 'Chennai', 'Mumbai', '09:00:00', '23:30:00', '14:30', 1250, '1 TIER AC, 3 TIER AC, SLEEPER', 'Daily', 'Superfast'),
(15023, 'Mumbai Local', 'Mumbai', 'Pune', '05:30:00', '07:30:00', '02:00', 125, 'SLEEPER', 'Weekdays', 'Local'),
(11011, 'Bay Area Link', 'Chennai', 'Madurai', '10:00:00', '18:00:00', '08:00', 500, '3 TIER AC, SLEEPER', 'Daily', 'Express');

-- 2) Ticket table
CREATE TABLE Ticket (
    PNRNo VARCHAR(20) PRIMARY KEY,
    transactionid VARCHAR(50),
    from_station VARCHAR(100),
    to_station VARCHAR(100),
    date_of_journey DATE,
    class VARCHAR(50),
    date_of_booking DATE,
    total_ticket_fare DECIMAL(10,2),
    train_number INT,
    FOREIGN KEY (train_number) REFERENCES Train(train_number)
);

-- sample tickets (include NULL transactionid, and dates like 2019-10-01)
INSERT INTO Ticket (PNRNo, transactionid, from_station, to_station, date_of_journey, class, date_of_booking, total_ticket_fare, train_number) VALUES
('PNR001', 'TX1001', 'Chennai', 'Mumbai', '2019-10-01', '3 TIER AC', '2019-08-01', 1800.00, 12601),
('PNR002', NULL, 'Chennai', 'Mumbai', '2019-09-15', '2 TIER AC', '2019-08-20', 1500.00, 12951),
('PNR003', 'TX1003', 'Chennai', 'Mumbai', '2019-10-01', 'AC CHAIR CAR', '2019-08-15', 820.00, 12601),
('PNR004', 'TX1004', 'Mumbai', 'Pune', '2019-09-10', 'SLEEPER', '2019-07-20', 200.00, 15023),
('PNR005', NULL, 'Chennai', 'Madurai', '2019-10-01', '3 TIER AC', '2019-08-25', 920.00, 11011);

-- 3) Passenger table (PNRNo + serial_no as composite key)
CREATE TABLE Passenger (
    PNRNo VARCHAR(20),
    serial_no INT,
    name VARCHAR(100),
    age INT,
    reservation_status VARCHAR(30),
    PRIMARY KEY (PNRNo, serial_no),
    FOREIGN KEY (PNRNo) REFERENCES Ticket(PNRNo)
);

-- sample passengers (include senior citizens, RAC/WAITLIST)
INSERT INTO Passenger (PNRNo, serial_no, name, age, reservation_status) VALUES
('PNR001', 1, 'Ravi', 65, 'CONFIRM'),
('PNR001', 2, 'Meena', 58, 'CONFIRM'),
('PNR002', 1, 'Suresh', 62, 'RAC'),
('PNR003', 1, 'Anita', 45, 'CONFIRM'),
('PNR004', 1, 'Kamal', 70, 'WAITLIST'),
('PNR005', 1, 'Geeta', 60, 'RAC'),
('PNR005', 2, 'Balu', 30, 'RAC');

-- 4) Train_Route table (train_number, route_no, station_code are composite PK)
CREATE TABLE Train_Route (
    train_number INT,
    route_no INT,
    station_code VARCHAR(10),
    name VARCHAR(150),
    arrival_time TIME,
    depart_time TIME,
    distance INT,
    day INT,
    PRIMARY KEY (train_number, route_no, station_code),
    FOREIGN KEY (train_number) REFERENCES Train(train_number)
);

-- sample routes (include station codes starting with 'M' too)
INSERT INTO Train_Route (train_number, route_no, station_code, name, arrival_time, depart_time, distance, day) VALUES
(12601, 1, 'MAS', 'Chennai Central', NULL, '06:00:00', 0, 1),
(12601, 2, 'MBI', 'Madurai Junction', '10:00:00', '10:10:00', 500, 1),
(12601, 3, 'MMT', 'Mumbai Central', '18:00:00', NULL, 1200, 1),
(12951, 1, 'MAS', 'Chennai Central', NULL, '08:00:00', 0, 1),
(12951, 2, 'MDU', 'Madurai Junction', '11:00:00', '11:10:00', 480, 1),
(12951, 3, 'MMR', 'Mumbai Road', '22:00:00', NULL, 1300, 1),
(13007, 1, 'MAS', 'Chennai Central', NULL, '09:00:00', 0, 1),
(13007, 2, 'MNG', 'Mangalore Junction', '15:00:00', '15:15:00', 700, 1),
(13007, 3, 'MMT', 'Mumbai Central', '23:30:00', NULL, 1250, 1),
(15023, 1, 'MMT', 'Mumbai Central', NULL, '05:30:00', 0, 1),
(11011, 1, 'MAS', 'Chennai Central', NULL, '10:00:00', 0, 1);

-- 5) Train_Ticket_Fare table (composite PK train_number + class), includes all fields from image
CREATE TABLE Train_Ticket_Fare (
    train_number INT,
    class VARCHAR(50),
    base_fare DECIMAL(10,2),
    reservation_charge DECIMAL(8,2),
    superfast_charge DECIMAL(8,2),
    other_charge DECIMAL(8,2),
    tatkal_charge DECIMAL(8,2),
    service_tax DECIMAL(8,2),
    PRIMARY KEY (train_number, class),
    FOREIGN KEY (train_number) REFERENCES Train(train_number)
);

-- sample fares (include AC classes and others)
INSERT INTO Train_Ticket_Fare (train_number, class, base_fare, reservation_charge, superfast_charge, other_charge, tatkal_charge, service_tax) VALUES
(12601, 'AC CHAIR CAR', 800.00, 20.00, 50.00, 10.00, 0.00, 18.00),
(12601, '3 TIER AC', 1200.00, 30.00, 60.00, 10.00, 0.00, 18.00),
(12951, '2 TIER AC', 1500.00, 35.00, 70.00, 12.00, 0.00, 18.00),
(13007, '1 TIER AC', 2000.00, 40.00, 80.00, 12.00, 0.00, 18.00),
(15023, 'SLEEPER', 200.00, 10.00, 0.00, 5.00, 0.00, 5.00),
(11011, '3 TIER AC', 900.00, 25.00, 55.00, 10.00, 0.00, 18.00);

-- ------------------------------------------------
-- End of schema + sample data
-- ------------------------------------------------

#1
SELECT train_number, train_name
 FROM Train
 ORDER BY train_number;
#2
 SELECT *
 FROM Passenger
 WHERE age >= 60
 ORDER BY name;
 #3
  SELECT station_code, name
 FROM Train_Route
 WHERE station_code LIKE 'M%'
 ORDER BY 1;
 #4
  SELECT *
 FROM Passenger
 WHERE reservation_status != 'CONFIRM'
 ORDER BY name desc;
#5
SELECT DISTINCT base_fare
 FROM Train_Ticket_Fare
 WHERE class LIKE '%AC%'
 ORDER BY 1;
#6
SELECT train_name
 FROM Train
 WHERE source = 'Chennai' AND destination = 'Mumbai'
 AND train_name NOT LIKE '%Chennai%' AND train_name NOT LIKE '%Mumbai%'
 ORDER BY train_name desc;
 #7
  SELECT P.PNRNo, P.name, P.age
 FROM
 Ticket T,
 Passenger P
 WHERE T.PNRNo = P.PNRNo
 AND T.date_of_journey = DATE_ADD("2019-09-01", INTERVAL 30 DAY)
 ORDER BY 1,2;
#8
 SELECT train_number, upper(train_name) as train_name
 FROM Train
 ORDER BY train_name;
 #9
  SELECT replace(station_code,'M','K') as station_code, name
 FROM Train_Route
 ORDER BY 1;
#10
 SELECT PNRNo, IFNULL(transactionid,'not generated') as transactionid
 FROM
 Ticket
 ORDER by 1;


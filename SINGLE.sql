/*   Dawei Li 102831215

*/

/*

Tour(TourName, Description)
Primary Key TourName
Event(EventYear, EventMonth, EventDay, Fee, TourName)
Primary Key(EventYear, EventMonth, EventDay, TourName)
Foreign Key (TourName) References Tour
Booking(DateBooked, Payment, EventYear, EventMonth, EventDay, TourName, ClientID)
Primary Key (EventYear, EventMonth, EventDay, TourName, ClientID)
Foreign Key (EventYear, EventMonth, EventDay) References Event
Foreign Key (TourName) References Tour
Foreign Key (ClientID) References Client
Client(ClientID, Surname, GivenName, Gender)
Primary Key (ClientID)

*/


drop table if exists Booking;
drop table if exists Event;
drop table if exists Tour;
drop table if exists Client;


CREATE TABLE Tour (
 TourName nvarchar(100) PRIMARY KEY
, Description nvarchar(500)
);

CREATE TABLE Client (
 ClientID int PRIMARY KEY
,Surname nvarchar(100) NOT NULL
,GivenName nvarchar(100) NOT NULL
,Gender nvarchar(1) 
,CHECK (Gender in ('M','F','I'))
);

CREATE TABLE Event (
 TourName nvarchar(100) 
,EventMonth nvarchar(3)
,EventYear int
,EventDay int
,EventFee money NOT NULL
,PRIMARY KEY (EventYear,EventMonth, EventDay,TourName)
,Foreign KEY (TourName) References Tour
,CHECK (EventMonth in ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul','Aug', 'Sep','Oct','Nov', 'Dec') )
,CHECK (EventDay >= 1 AND EventDay <=31)
,CHECK (EventYear>999 AND EventYear<10000)
,CHECK (EventFee > 0)
);

CREATE TABLE Booking (
 ClientID int 
,TourName nvarchar(100)
,EventMonth nvarchar(3)
,EventYear int
,EventDay int
,Payment money
,DateBooked date NOT NULL
,PRIMARY KEY (ClientID, EventYear, EventMonth, EventDay,TourName)
,FOREIGN KEY (ClientID) REFERENCES Client
,FOREIGN KEY (EventYear, EventMonth, EventDay, TourName) REFERENCES Event
,CHECK (EventMonth in ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul','Aug', 'Sep','Oct','Nov', 'Dec') )
,CHECK (EventDay >= 1 AND EventDay <=31)
,CHECK (EventYear>999 AND EventYear<10000)
,CHECK (Payment > 0)
);

INSERT INTO Tour (TourName, Description)
VALUES ('North', 'Tour of wineries and outlets of the Bedigo and Castlemaine region');
INSERT INTO Tour (TourName, Description)
VALUES ('South', 'Tour of wineries and outlets of Mornington Penisula');
INSERT INTO Tour (TourName, Description)
VALUES ('West', 'Tour of wineries and outlets of the Geelong and Otways region');

INSERT INTO Client (ClientID, Surname, GIvenName, Gender)
VALUES (1, 'Price', 'Taylor','M');
INSERT INTO Client (ClientID, Surname, GIvenName, Gender)
VALUES (2, 'Bamble', 'Ellyse','M');
INSERT INTO Client (ClientID, Surname, GIvenName, Gender)
VALUES (3, 'Tan', 'Tilly','F');
INSERT INTO Client (ClientID, Surname, GIvenName, Gender)
VALUES (102831215, 'Li', 'Dawei','M');

INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee)
VALUES ('NORTH', 'Jan', 9, 2016, 200);
INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee)
VALUES ('NORTH', 'Feb', 13, 2016, 225);
INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee)
VALUES ('SOUTH', 'Jan', 9, 2016, 200);
INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee)
VALUES ('SOUTH', 'Jan', 16, 2016, 200);
INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee)
VALUES ('West', 'Jan', 29, 2016, 225);

INSERT INTO Booking (ClientID, TourName, EventMonth, EventDay, EventYear,
Payment, Datebooked)
VALUES (1, 'NORTH', 'Jan', 9, 2016, 200, '10-Dec-2015');
INSERT INTO Booking (ClientID, TourName, EventMonth, EventDay, EventYear,
Payment, Datebooked)
VALUES (2, 'NORTH', 'Jan', 9, 2016, 200, '16-Dec-2015');
INSERT INTO Booking (ClientID, TourName, EventMonth, EventDay, EventYear,
Payment, Datebooked)
VALUES (1, 'NORTH', 'Feb', 13, 2016, 225, '08-Jan-2016');
INSERT INTO Booking (ClientID, TourName, EventMonth, EventDay, EventYear,
Payment, Datebooked)
VALUES (2, 'NORTH', 'Feb', 13, 2016, 125, '14-Jan-2016');
INSERT INTO Booking (ClientID, TourName, EventMonth, EventDay, EventYear,
Payment, Datebooked)
VALUES (3, 'NORTH', 'Feb', 13, 2016, 225, '03-Feb-2016');
INSERT INTO Booking (ClientID, TourName, EventMonth, EventDay, EventYear,
Payment, Datebooked)
VALUES (1, 'SOUTH', 'Jan', 9, 2016, 200, '10-Dec-2015');
INSERT INTO Booking (ClientID, TourName, EventMonth, EventDay, EventYear,
Payment, Datebooked)
VALUES (2, 'SOUTH', 'Jan', 16, 2016, 200, '18-Dec-2015');
INSERT INTO Booking (ClientID, TourName, EventMonth, EventDay, EventYear,
Payment, Datebooked)
VALUES (3, 'SOUTH', 'Jan', 16, 2016, 200, '09-Jan-2016');
INSERT INTO Booking (ClientID, TourName, EventMonth, EventDay, EventYear,
Payment, Datebooked)
VALUES (2, 'WEST', 'Jan', 29, 2016, 225, '17-Dec-2015');
INSERT INTO Booking (ClientID, TourName, EventMonth, EventDay, EventYear,
Payment, Datebooked)
VALUES (3, 'WEST', 'Jan', 29, 2016, 200, '18-Dec-2015');

SELECT C.Surname, C.GivenName, T.TourName, 
T.Description, E.EventYear, E.EventMonth, E.EventDay, E.EventFee,
B.Payment, B.DateBooked
FROM Client C
INNER JOIN Booking B
ON B.ClientID = C.ClientID
INNER JOIN Event E
ON B.EventYear = E.EventYear
AND B.EventMonth = E.EventMonth
AND B.EventDay = E.EventDay
AND B.TourName = E.TourName
INNER JOIN Tour T
ON E.TourName = T.TourName;

SELECT E.EventMonth, T.TourName, Count(B.DateBooked)
FROM Event E
INNER JOIN Tour T
ON E.TourName = T.TourName
INNER JOIN Booking B
ON B.EventYear = E.EventYear
AND B.EventMonth = E.EventMonth
AND B.EventDay = E.EventDay
AND B.TourName = E.TourName
GROUP BY E.EventMonth, T.TourName; 

SELECT B.* FROM Booking B
INNER JOIN Event E
ON B.EventYear = E.EventYear
AND B.EventMonth = E.EventMonth
AND B.EventDay = E.EventDay
AND B.TourName = E.TourName
INNER JOIN Tour T
ON E.TourName = T.TourName
INNER JOIN Client C
ON B.ClientID = C.ClientID
WHERE B.payment >(SELECT avg(Payment) FROM Booking);

CREATE VIEW ViewAll AS
SELECT C.Surname, C.GivenName, T.TourName, 
T.Description, E.EventYear, E.EventMonth, E.EventDay, E.EventFee,
B.Payment, B.DateBooked
FROM Client C
INNER JOIN Booking B
ON B.ClientID = C.ClientID
INNER JOIN Event E
ON B.EventYear = E.EventYear
AND B.EventMonth = E.EventMonth
AND B.EventDay = E.EventDay
AND B.TourName = E.TourName
INNER JOIN Tour T
ON E.TourName = T.TourName;

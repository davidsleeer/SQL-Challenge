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

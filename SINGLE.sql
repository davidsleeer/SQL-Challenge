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




create database TripCp
go

drop table Trip
go
drop table Destination
go
drop table Ticket
go
drop table Transport
go
drop table Driver
go
drop table TransportType
go
use TripCp
go

create table Driver
(
	Id int Identity NOT NULL primary key,
	DriverName nvarchar(50) NOT NULL,
	DriverSurname nvarchar(50) NOT NULL,
	Age int NOT NULL,
	License nvarchar(50)
)
go

create table TransportType
(
	Id int Identity NOT NULL primary key,
	NameType nvarchar(50) NOT NULL UNIQUE
)
go
create table Transport
(
	Id int Identity NOT NULL Primary key,
	DriverId int NOT NULL,
	CompanyName nvarchar(50) NULL,
	CountPassangers int NOT NULL,
	TransportType int NOT NULL,
	constraint FK_Transport_To_Driver foreign key(DriverId)
	references Driver(Id),
	constraint FK_Transport_To_TransportType foreign key(TransportType)
	references TransportType(Id)
)
go

create table Destination
(
	Id int Identity NOT NULL primary key,
	Destination nvarchar(50) NOT NULL,
	DestinationDescription nvarchar(MAX) NULL
)
go

create table UserRole(
	Id int Identity NOT NULL Primary key,
	UserRole nvarchar(50) NOT NULL
)
go

create table CurrentUser
(
	Id int Identity NOT NULL primary key,
	UserName nvarchar(50) NOT NULL UNIQUE,
	UserPassword nvarchar(50) NOT NULL,
	PhoneNumber varchar(16) NOT NULL UNIQUE,
	RoleId int NOT NULL,
	constraint FK_CurrentUser_To_UserRole foreign key(RoleId)
	references UserRole(Id)
)
go

create table Ticket
(
	Id int Identity NOT NULL primary key,
	Price int NOT NULL,
	Seat int NULL,
	CurrentUserId int NOT NULL,
	constraint FK_Ticket_To_CurrentUser foreign key(CurrentUserId)
	references CurrentUser(Id)
)
go

create table Trip
(
	Id int Identity NOT NULL primary key,
	TransportId int NOT NULL,
	DestinationId int NOT NULL,
	DeparturePoint nvarchar(50) NOT NULL,
	DepartureTime DateTime NOT NULL,
	ArrivalTime DateTime NULL,
	TicketId int NOT NULL,
	constraint FK_Trip_To_Transport foreign key(TransportId)
	references Transport(Id),
	constraint FK_Trip_To_Destination foreign key(DestinationId)
	references Destination(Id),
	constraint FK_Trip_To_Ticket foreign key(TicketId)
	references Ticket(Id)
)

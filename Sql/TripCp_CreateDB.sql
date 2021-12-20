drop database TripCp
go
create database TripCp
go
use TripCp
go
drop table Ticket
go
drop table CurrentUser
go
drop table Trip
go
drop table Transport
go
drop table Driver
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

create table Transport
(
	Id int Identity NOT NULL Primary key,
	DriverId int NOT NULL,
	CompanyName nvarchar(50) NULL,
	CountPassangers int NOT NULL,
	TransportDescription nvarchar(MAX) NOT NULL,
	constraint FK_Transport_To_Driver foreign key(DriverId)
	references Driver(Id)
)
go

create table CurrentUser
(
	Id int Identity NOT NULL primary key,
	UserName nvarchar(50) masked with ( function = 'DEFAULT()' ) NOT NULL UNIQUE,
	UserPassword nvarchar(50) masked with ( function = 'DEFAULT()' ) NOT NULL,
	PhoneNumber varchar(16) masked with (function='partial(3,"-ZZ-ZZZ-ZZ-",2)') NOT NULL UNIQUE,
	Admin tinyint masked with (function='random(3,9)') default 1 NOT NULL
)
go

create table Trip
(
	Id int Identity NOT NULL primary key,
	TransportId int NOT NULL,
	DeparturePoint nvarchar(MAX) NOT NULL,
	DepartureTime DateTime NOT NULL,
	ArrivalTime DateTime NULL,
	Destination nvarchar(MAX) NOT NULL,
	constraint FK_Trip_To_Transport foreign key(TransportId)
	references Transport(Id)
)
go

create table Ticket
(
	Id int Identity NOT NULL primary key,
	Price int NOT NULL,
	Seat int NULL,
	CurrentUserId int NULL,
	TripId int NOT NULL,
	constraint FK_Ticket_To_Trip foreign key(TripId)
	references Trip(Id),
	constraint FK_Ticket_To_CurrentUser foreign key(CurrentUserId)
	references CurrentUser(Id)
)


use master

if not exists (SELECT * FROM sys.symmetric_keys WHERE name LIKE '%MS_DatabaseMasterKey%')
begin
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'pyrogpassword';
end
go

BACKUP MASTER KEY TO FILE = 'D:\Study\Practice\TripCp\MasterKey\masterkey1.mk'
    ENCRYPTION BY PASSWORD = 'pyrogpassword';
go

CREATE CERTIFICATE tripCp_cert WITH SUBJECT = 'tripCp_certificate';
go

BACKUP CERTIFICATE tripCp_cert TO FILE = 'D:\Study\Practice\TripCp\MasterKey\TripCp.cer'
   WITH PRIVATE KEY (
         FILE = 'D:\Study\Practice\TripCp\Certificate\TripCp.pvk',
         ENCRYPTION BY PASSWORD = 'pyrogpassword');
go


use TripCp
go
create database encryption key
   with algorithm = AES_256
   encryption by server certificate tripCp_cert;
go

alter database TripCp set encryption on
go

select
    DB_NAME(database_id) AS DatabaseName,
    Encryption_State AS EncryptionState,
    key_algorithm AS Algorithm,
    key_length AS KeyLength
from
    sys.dm_database_encryption_keys
go

select
    name AS DatabaseName,
    is_encrypted AS IsEncrypted
from sys.databases where name = 'TripCp'

go
create user reader without login
grant select on CurrentUser to reader
--sp_helprotect @username = 'reader'
	use TripCp;
go
-------------------------Удаление данных
delete from [dbo].Trip;
delete from [dbo].Ticket;
delete from [dbo].Transport;
delete from [dbo].CurrentUser;
delete from [dbo].Driver;



------------------------Вывод данных
select * from dbo.CurrentUser
select * from dbo.Ticket
select * from dbo.Trip
select * from dbo.Transport
select * from dbo.Driver

---------------------insert 100k values-----------------------
GO 
IF OBJECT_ID('[dbo].[InsertDBDriver]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[InsertDBDriver] 
END 
go
create PROCEDURE [dbo].[InsertDBDriver] -- вставка 100к значений 
AS 
BEGIN 
DECLARE 
@id int,
@DriverName nvarchar(50),
@DriverSurname nvarchar(50),
@age int,
@license int; 
SET @license = 1000000;  
begin tran
WHILE @license > 0 
BEGIN 
SET @age = FLOOR(rand()*(65-20)+20);
set @DriverName = 'name'+CONVERT(nvarchar(50),@license);
set @DriverSurname = 'surname'+CONVERT(nvarchar(50),@license);
INSERT INTO [Driver] ([DriverName],[DriverSurname],[Age], [License]) VALUES(@DriverName,@DriverSurname,@age,@license) 
SET @license -= 1; 
END; 
commit;
END; 
-------------------------Drivers------------------------------
exec [dbo].[InsertDBDriver];
----------Parameters: DriverName, DriverSurname, age, license(7num)
exec [dbo].[AddNewDriver] 'Timothey','Lebovski', 34, '1234567'
exec [dbo].[AddNewDriver] 'Jeff','Bridges', 52, '6667779'
-------------------------Users--------------------------------
----------Parameters: UserName, Userpassword, admin, phone
exec [dbo].[Register_User] 'user1', 'SurUser1',1,'+375296580546';
exec [dbo].[Register_User] 'user2', 'SurUser2',0,'+375296580547';
exec [dbo].[Register_User] 'user3', 'SurUser3',0,'+375296580548';
exec [dbo].[Login_User] 'user1', 'SurUser1';
------------------------Transport------------------------------
------Parameters: DriverId, CompanyName, CountPassangers, Transport Description
exec [dbo].[AddNewTransport] 14, 'ООО Типочки', 10, 'Маршрутка Газ NEXT Синего цвета';
exec [dbo].[AddNewTransport] 14, 'ООО Типочки', 15, 'Маршрутка Газ Citiline Зеленого цвета';
exec [dbo].[AddNewTransport] 15, 'ООО Типочки', 14, 'Маршрутка Газ Бизнес Кремового цвета';
exec [dbo].[AddNewTransport] 16, 'ООО Типочки', 13, 'Маршрутка Газ Citilines Синего цвета';
------------------------Trip-----------------------------------
select * from dbo.Transport
-------Parameters: (TransportId,DeparturePoint,DepartureTime,ArriveTime)
exec [dbo].[AddNewTrip] 4, 'г. Гродно ул. Типок д.22','2001-11-02 10:00:00', '2001-11-02 20:00:00', 'г. Минск ул. Есенина д. 12';
exec [dbo].[AddNewTrip] 3, 'г. Минск ул. Пушкина д. 13','2001-12-02 16:00:00', '2001-12-02 18:00:00', 'г. Минск ул. Крипочки д. 11';
exec [dbo].[AddNewTrip] 2, 'г. Гродно ул. Типок д. 68','2001-12-02 10:00:00', '2001-12-02 18:00:00', 'г. Минск ул. Величайший д. 14Б';

-------------------------Ticket-------------------------------
select * from dbo.Trip
----------Parameters: trip Id, Price
exec [dbo].[AddAutoTickets] 6, 300
----------Parameters: seat, price, tripId
exec [dbo].[AddNewTicket] 1, 200, 1;
exec [dbo].[AddNewTicket] 2, 200, 4;
exec [dbo].[AddNewTicket] 3, 200, 4;
exec [dbo].[AddNewTicket] 4, 200, 4;
exec [dbo].[AddNewTicket] 5, 200, 4;
exec [dbo].[AddNewTicket] 13, 200, 5;
exec [dbo].[AddNewTicket] 7, 200, 5;
exec [dbo].[AddNewTicket] 8, 200, 1;
exec [dbo].[AddNewTicket] 9, 200, 1;

-------------------------Selects-------------------------------
exec [dbo].[SelectAllUser]
exec [dbo].[SelectAllTrip]
exec [dbo].[SelectAllDriver]
exec [dbo].[SelectAllTickets]
-----------------Parameters: trip Id
exec [dbo].[SelectDriver] 15
exec [dbo].[SelectTrip] 4
exec [dbo].[SelectTicket] 1
-----------------Parameters: Id of ticket, Id of user
--select * from Ticket
exec [dbo].[BuyTicket] 3480364,1
exec [dbo].[BuyTicket] 2,3
exec [dbo].[BuyTicket] 3,3

-----------------Delete----------------------------------------
exec [dbo].[DeleteUser] 2
-----------------Parameters: Ticket Id
exec [dbo].[DeleteTicketByTicketId] 1
-----------------Parameters: Trip Id
exec [dbo].[DeleteTrip] 5
-----------------Parameters: Transport Id
exec [dbo].[DeleteTransport] 4
-----------------Parameters: Driver Id
exec [dbo].[DeleteDriver] 15

------------------------Вывод данных
select * from dbo.CurrentUser
select * from dbo.Ticket
select * from dbo.Trip
select * from dbo.Transport
select * from dbo.Driver

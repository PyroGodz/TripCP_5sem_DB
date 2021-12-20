use TripCp;
go

---------------------------------------------------
--[SelectAllUser] --------------------------------- 
---------------------------------------------------
IF OBJECT_ID('[dbo].[SelectAllUser]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SelectAllUser] 
END 
go
create procedure [dbo].[SelectAllUser] 
as begin
begin try
begin tran
execute as user='reader'
select [Id], [UserName], [PhoneNumber] from [dbo].[CurrentUser]
revert
commit;
end try
begin catch
print error_message()
-- 
end catch;
end;

---------------------------------------------------
--[SelectAllTrip] --------------------------------- 
---------------------------------------------------
IF OBJECT_ID('[dbo].[SelectAllTrip]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SelectAllTrip] 
END 
go
create procedure [dbo].[SelectAllTrip]
as begin
begin try
begin tran
select (select [TransportDescription] from [dbo].[Transport] where [Id]=[TransportId]) as [TransportDescription] , [DeparturePoint], [DepartureTime], [ArrivalTime] from [dbo].[Trip]
commit;
end try
begin catch
print error_message()
-- 
end catch;
end;

---------------------------------------------------
--[SelectAllDriver] --------------------------------- 
---------------------------------------------------
IF OBJECT_ID('[SelectAllDriver]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SelectAllDriver]
END 
go
create procedure [dbo].[SelectAllDriver]
as begin
begin try
begin tran
select [DriverName], [DriverSurname] from [dbo].[Driver]
commit;
end try
begin catch
print error_message()
-- 
end catch;
end;

---------------------------------------------------
--[SelectAllTickets] --------------------------------- 
---------------------------------------------------
IF OBJECT_ID('[SelectAllTickets]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SelectAllTickets]
END 
go
create procedure [dbo].[SelectAllTickets]
as begin
begin try
begin tran
select [Seat], (select [userName] from [CurrentUser] where [Id]=[CurrentUserId]) as [Name], (select [PhoneNumber] from [CurrentUser] where [Id]=[CurrentUserId]) as [Phone] from [dbo].[Ticket]
commit;
end try
begin catch
print error_message()
-- 
end catch;
end;


---------------------------------------------------
--[SelectDriver] --------------------------------- 
---------------------------------------------------
IF OBJECT_ID('[dbo].[SelectDriver]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SelectDriver] 
END 
go
create procedure [dbo].[SelectDriver]
(
	@driverId int
)
as begin
begin try
begin tran
select DriverName, DriverSurname, Id as [Working Identity Number] from Driver where Id = @driverId
commit;
end try
begin catch
print error_message()
-- 
end catch;
end;

---------------------------------------------------
--[SelectTrip] --------------------------------- 
---------------------------------------------------
IF OBJECT_ID('[dbo].[SelectTrip]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SelectTrip] 
END 
go
create procedure [dbo].[SelectTrip]
(
	@tripId int
)
as begin
begin try
begin tran
select (select [TransportDescription] from [dbo].[Transport] where [Id]=[TransportId]) as [TransportDescription], [DeparturePoint], [Destination] , [DepartureTime], [ArrivalTime] from [dbo].[Trip] where [Id] = @tripId
commit;
end try
begin catch
print error_message()
-- 
end catch;
end;

---------------------------------------------------
--[SelectTicket] --------------------------------- 
---------------------------------------------------
IF OBJECT_ID('[dbo].[SelectTicket]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SelectTicket]
END 
go
create procedure [dbo].[SelectTicket]
(
	@ticketId int
)
as begin
begin try
begin tran
select (select Destination from Trip where Id=TripId) as Destination,
(select DeparturePoint from Trip where Id=TripId) as DeparturePoint,
(select DepartureTime from Trip where Id=TripId) as Destination,
(select ArrivalTime from Trip where Id=TripId) as Destination,
(select CompanyName from Transport where Id in (select TransportId from Trip where Id=TripId)) as CompanyName,
(select TransportDescription from Transport where Id in (select TransportId from Trip where Id=TripId)) as Transport,
Price, Seat from Ticket where Id = @ticketId
commit;
end try
begin catch
print error_message()
-- 
end catch;
end;
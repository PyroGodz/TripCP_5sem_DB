use TripCP;
go

--------------------------------------------------------
--[dbo].[DeleteTicketByUserId]-----------------------------------------
--------------------------------------------------------
IF OBJECT_ID('[dbo].[DeleteTicketByUserId]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteTicketByUserId]
END 
go
create procedure [dbo].[DeleteTicketByUserId]
(
@userid int
)
as begin
begin try
begin tran
delete from [dbo].[Ticket] where [CurrentUserId]=@userid;
commit;
end try
begin catch
print error_message()
 
end catch;
end;
go
---------------------------------------------------
--[DeleteUser]-------------------------------------
--------------------------------------------------- 
IF OBJECT_ID('[dbo].[DeleteUser]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteUser] 
END 
go
create procedure [dbo].[DeleteUser]
(
@userid int
)
as begin
begin try
begin tran
exec [dbo].[DeleteTicketByUserId] @userid;

delete from [dbo].[CurrentUser] where [Id]=@userid;
commit;
end try
begin catch
print error_message()
 
end catch;
end;
go
--------------------------------------------------------
--[dbo].[DeleteTicketByTicketId]-----------------------------------------
--------------------------------------------------------
IF OBJECT_ID('[dbo].[DeleteTicketByTicketId]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteTicketByTicketId]
END 
go
create procedure [dbo].[DeleteTicketByTicketId]
(
@ticketId int
)
as begin
begin try
begin tran
delete from [dbo].[Ticket] where [Id]=@ticketId;
commit;
end try
begin catch
print error_message()
 
end catch;
end;
go
--------------------------------------------------------
--[dbo].[DeleteTicketByTripId]-----------------------------------------
--------------------------------------------------------
IF OBJECT_ID('[dbo].[DeleteTicketByTripId]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteTicketByTripId]
END 
go
create procedure [dbo].[DeleteTicketByTripId]
(
@trId int
)
as begin
begin try
begin tran
delete from [dbo].[Ticket] where [TripId]=@trId;
commit;
end try
begin catch
print error_message()
 
end catch;
end;
go

--------------------------------------------------------
--[dbo].[DeleteTrip]-----------------------------------------
--------------------------------------------------------
IF OBJECT_ID('[dbo].[DeleteTrip]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteTrip]
END 
go
create procedure [dbo].[DeleteTrip]
(
@tripId int
)
as begin
begin try
begin tran
exec [dbo].[DeleteTicketByTripId] @tripid;

delete from [dbo].[Trip] where [Id]=@tripId;
commit;
end try
begin catch
print error_message()
 
end catch;
end;
go
--------------------------------------------------------
--[dbo].[DeleteTicketByTransportId]-----------------------------------------
--------------------------------------------------------
IF OBJECT_ID('[dbo].[DeleteTicketByTransportId]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteTicketByTransportId]
END 
go
create procedure [dbo].[DeleteTicketByTransportId]
(
@transportId int
)
as begin
begin try
begin tran
delete from [dbo].[Ticket] where [TripId] in (select [Id] from [dbo].[Trip] where [TransportId]=@transportId)
commit;
end try
begin catch
print error_message()
 
end catch;
end;
go
--------------------------------------------------------
--[dbo].[DeleteTripByTransportId]-----------------------------------------
--------------------------------------------------------
IF OBJECT_ID('[dbo].[DeleteTripByTransportId]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteTripByTransportId]
END 
go
create procedure [dbo].[DeleteTripByTransportId]
(
@transportId int
)
as begin
begin try
begin tran
exec [dbo].[DeleteTicketByTransportId] @transportId;

delete from [dbo].[Trip] where [TransportId]=@transportId;
commit;
end try
begin catch
print error_message()
 
end catch;
end;
go
--------------------------------------------------------
--[dbo].[DeleteTransport]-----------------------------------------
--------------------------------------------------------
IF OBJECT_ID('[dbo].[DeleteTransport]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteTransport]
END 
go
create procedure [dbo].[DeleteTransport]
(
@transportId int
)
as begin
begin try
begin tran
exec [dbo].[DeleteTripByTransportId] @transportId;

delete from [dbo].[Transport] where [Id]=@transportId;
commit;
end try
begin catch
print error_message()
 
end catch;
end;
go
--------------------------------------------------------
--[dbo].[DeleteTicketByDriverId]-----------------------------------------
--------------------------------------------------------
IF OBJECT_ID('[dbo].[DeleteTicketByDriverId]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteTicketByDriverId]
END 
go
create procedure [dbo].[DeleteTicketByDriverId]
(
@driverId int
)
as begin
begin try
begin tran
delete from [dbo].[Ticket] where [TripId] in 
(select [Id] from [dbo].[Trip] where [TransportId] in 
(select [Id] from [dbo].[Transport] where [DriverId] = @driverId));
commit;
end try
begin catch
print error_message()
 
end catch;
end;

go
--------------------------------------------------------
--[dbo].[DeleteTripByDriverId]-----------------------------------------
--------------------------------------------------------
--------------------------------------------------------
--[dbo].[DeleteTripByDriverId]-----------------------------------------
--------------------------------------------------------
IF OBJECT_ID('[dbo].[DeleteTripByDriverId]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteTripByDriverId]
END 
go
create procedure [dbo].[DeleteTripByDriverId]
(
@driveId int
)
as begin
begin try
begin tran
exec [dbo].[DeleteTicketByDriverId] @driveId;

delete from [dbo].[Trip] where [TransportId] in (select [Id] from [dbo].[Transport] where [DriverId] = @driveId);
commit;
end try
begin catch
print error_message()
end catch;
end;

go
--------------------------------------------------------
--[dbo].[DeleteTransportByDriverId]-----------------------------------------
--------------------------------------------------------
IF OBJECT_ID('[dbo].[DeleteTransportByDriverId]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteTransportByDriverId]
END 
go
create procedure [dbo].[DeleteTransportByDriverId]
(
@driverId int
)
as begin
begin try
begin tran
exec [dbo].[DeleteTripByDriverId] @driverId;

delete from [dbo].[Transport] where [DriverId]=@driverId;
commit;
end try
begin catch
print error_message()
 
end catch;
end;
go
--------------------------------------------------------
--[dbo].[DeleteDriver]-----------------------------------------
--------------------------------------------------------
IF OBJECT_ID('[dbo].[DeleteDriver]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteDriver]
END 
go
create procedure [dbo].[DeleteDriver]
(
@driverId int[dbo].[DeleteTicketByTicketId]
)
as begin
begin try
begin tran
exec [dbo].[DeleteTransportByDriverId] @driverId;

delete from [dbo].[Driver] where [Id]=@driverId;
commit;
end try
begin catch
print error_message()

end catch;
end;

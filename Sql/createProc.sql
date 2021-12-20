use TripCp;
go


---------------------------------------------------
--[AddNewTicket]------------------------------------
---------------------------------------------------

IF OBJECT_ID('[dbo].[AddNewTicket]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[AddNewTicket] 
END 
go
create procedure [dbo].[AddNewTicket]
(
	@seat int,	
	@Price int,
	@tripId int
) 
as begin
begin try
begin tran
	if not exists(select 1 from Ticket where TripId = @tripId and Seat = @seat)
		insert into [dbo].[Ticket]([Seat],[Price],[TripId])
		values (@seat,@Price,@tripId);
commit;
end try
begin catch
print error_message()
 
end catch
end 

---------------------------------------------------
--[AddNewTransport]-------------------------------
---------------------------------------------------
IF OBJECT_ID('[dbo].[AddNewTransport]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[AddNewTransport]
END 
go
create procedure [dbo].[AddNewTransport]
(
	@DriverId int,
	@CompanyName nvarchar(50) ,
	@CountPassangers int,
	@TransportDescription nvarchar(MAX)
)
as begin
begin try
begin tran
insert into [dbo].[Transport]([DriverId],[CompanyName],[CountPassangers],[TransportDescription])
values (@DriverId,@CompanyName,@CountPassangers,@TransportDescription);
commit;
end try
begin catch
print error_message()
 
end catch
end

---------------------------------------------------
--[AddNewTrip]------------------------------------
---------------------------------------------------
IF OBJECT_ID('[dbo].[AddNewTrip]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[AddNewTrip] 
END 
go
create procedure [dbo].[AddNewTrip]
(
	@TransportId int,
	@DeparturePoint nvarchar(MAX),
	@DepartureTime DateTime,
	@ArrivalTime DateTime,
	@Dest nvarchar(MAX)
)
as begin
begin try
--begin tran
declare @date date = GetDate();
insert into [dbo].[Trip]([TransportId],[DeparturePoint],[DepartureTime],[ArrivalTime],[Destination])
values (@TransportId,@DeparturePoint,@DepartureTime,@ArrivalTime, @Dest);
--commit;
end try
begin catch
print error_message()
 
end catch
end

--[AddAutoTickets]------------------------------------
---------------------------------------------------
IF OBJECT_ID('[dbo].[AddAutoTickets]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[AddAutoTickets]
END 
go
create procedure [dbo].[AddAutoTickets]
(
	@tripId int,
	@price int
)
as begin
begin try
declare @countPassgrs int = 0;
select @countPassgrs = CountPassangers from Transport where Id in (select TransportId from Trip where Id = @tripId)
	while @countPassgrs > 0
		begin
			exec AddNewTicket @countPassgrs, @price, @tripId;
			set @countPassgrs = @countPassgrs - 1;
		end;
--commit;
end try
begin catch
print error_message()
end catch
end
---------------------------------------------------
----[AddNewDriver]---------------------------------
---------------------------------------------------
IF OBJECT_ID('[dbo].[AddNewDriver]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[AddNewDriver] 
END 
go
create procedure [dbo].[AddNewDriver]
(
	@DriverName nvarchar(50),
	@DriverSurname nvarchar(50),
	@Age int,
	@License nvarchar(50)
)
as begin
begin try
begin tran
insert into [dbo].[Driver]([DriverName],[DriverSurname],[Age],[License])
values (@DriverName,@DriverSurname,@Age,@License);
commit;
end try
begin catch
print error_message()
 
end catch
end

---------------------------------------------------
--[BuyTicket]------------------------------------
---------------------------------------------------

IF OBJECT_ID('[dbo].[BuyTicket]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[BuyTicket] 
END 
go
create procedure [dbo].[BuyTicket]
(
	@ticketId int,
	@currentUserId int
) 
as begin
begin try
begin tran
update [dbo].[Ticket]
set [CurrentUserId] = @currentUserId
where (CurrentUserId is null and [Id] = @ticketId)
commit;
end try
begin catch
print error_message()
end catch
end 

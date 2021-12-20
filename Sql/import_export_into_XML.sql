use TripCp;
go

--drop procedure ExportXmlTicket
--go
--create procedure ExportXmlTicket
--as
--Begin

--	exec master.dbo.sp_configure 'show advanced options', 1
--		RECONFIGURE WITH OVERRIDE
--	exec master.dbo.sp_configure 'xp_cmdshell', 1
--		RECONFIGURE WITH OVERRIDE;

--	declare @fileName varchar(100)
--	declare @sqlStr varchar(1000)
--	declare @sqlCmd varchar(1000)
--	set @fileName = 'D:\Study\Practice\TripCp\xmlTicket.xml'
--	set @sqlStr = 'use TripCp; declare @text varchar(max) = (select * from Ticket for xml path(''TicketIs''), ROOT(''Ticket'')); select replace(@text, ''</TicketIs>'', ''</TicketIs>'' + char(13))'
--	set @sqlCmd = 'bcp "' + @sqlStr + '" queryout ' + @fileName + ' -w -T -S PYROG\SQLEXPRESS'
--	exec xp_cmdshell @sqlCmd;
--end
--go
--ExportXmlTicket;

IF OBJECT_ID('[dbo].[ExportTransport]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ExportTransport]
END 
go
CREATE PROCEDURE [dbo].[ExportTransport]
AS
	SELECT DriverId, CompanyName, CountPassangers, TransportDescription
	FROM [dbo].[Transport]
	FOR XML PATH('TransportIs'), ROOT('Transport');
	ExportTransport;

go
IF OBJECT_ID('[dbo].[ImportTransport]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ImportTransport]
END 
go
create procedure [dbo].[ImportTransport]
	@xml XML = NULL
AS
Select  @xml  = 
CONVERT(XML,bulkcolumn,2) FROM OPENROWSET(BULK 'D:\Study\Practice\TripCp\Transport.xml',SINGLE_BLOB) AS X
SET ARITHABORT ON
Insert into [dbo].[Transport]
        (
          DriverId, CompanyName, CountPassangers, TransportDescription
        )
    Select DISTINCT
        
        P.value('DriverId[1]', 'int') AS [DriverId],
        P.value('CompanyName[1]', 'nvarchar(50)') AS [CompanyName], 
        P.value('CountPassangers[1]', 'int') AS [CountPassangers],
		P.value('TransportDescription[1]', 'nvarchar(max)') AS [TransportDescription]
       
    From @xml.nodes('/Transport/TransportIs') PropertyFeed(P)
GO
ImportTransport;

IF OBJECT_ID('[dbo].[ExportTicket]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ExportTicket]
END 
go
CREATE PROCEDURE [dbo].[ExportTicket]
AS
	SELECT [Price],[Seat],[CurrentUserId],[TripId]
	FROM [dbo].[Ticket]
	FOR XML PATH('TicketIs'), ROOT('Ticket');
	ExportTicket;


go
IF OBJECT_ID('[dbo].[ImportTicket]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ImportTicket]
END 
go
create procedure [dbo].[ImportTicket]
	@xml XML = NULL
AS
Select  @xml  = 
CONVERT(XML,bulkcolumn,2) FROM OPENROWSET(BULK 'D:\Study\Practice\TripCp\Ticket.xml',SINGLE_BLOB) AS X
SET ARITHABORT ON
Insert into [dbo].[Ticket]
        (
          [Price],[Seat],[CurrentUserId],[TripId]
        )
    Select DISTINCT
        
        P.value('Price[1]', 'int') AS [Price],
        P.value('Seat[1]', 'int') AS [Seat], 
        P.value('CurrentUserId[1]', 'int') AS [CurrentUserId],
		P.value('TripId[1]', 'int') AS [TripId]
       
    From @xml.nodes('/Ticket/TicketIs') PropertyFeed(P)
GO
ImportTicket;
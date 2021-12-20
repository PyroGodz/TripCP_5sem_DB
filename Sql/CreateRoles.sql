use TripCp;

-------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------[TripCp_user_Role]--------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------


DROP ROLE [TripCp_user_Role];
CREATE ROLE [TripCp_user_Role];
GRANT EXECUTE ON [dbo].[Register_User]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[Login_User]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[BuyTicket]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[SelectAllUser]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[SelectAllTrip]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[SelectAllDriver]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[SelectAllTickets]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[SelectDriver]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[SelectTrip]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[SelectTicket]  TO [TripCp_admin_Role];
go
sp_addrolemember 'TripCp_user_Role', 'user';

DROP ROLE [TripCp_admin_Role];
CREATE ROLE [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[Register_User]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[Login_User]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[AddNewTicket]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[AddNewTransport]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[AddNewTrip]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[AddAutoTickets]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[AddNewDriver]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[BuyTicket]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[DeleteTicketByUserId]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[DeleteUser]   TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[DeleteTicketByTicketId]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[DeleteTicketByTripId]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[DeleteTrip]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[DeleteTicketByTransportId]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[DeleteTripByTransportId]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[DeleteTransport]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[DeleteTicketByDriverId]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[DeleteTripByDriverId]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[DeleteTransportByDriverId]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[DeleteDriver]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[SelectAllUser]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[SelectAllTrip]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[SelectAllDriver]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[SelectAllTickets]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[SelectDriver]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[SelectTrip]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[SelectTicket]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[ExportTransport]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[ImportTransport]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[ExportTicket]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[ImportTicket]  TO [TripCp_admin_Role];
GRANT EXECUTE ON [dbo].[InsertDBDriver]  TO [TripCp_admin_Role];
go
sp_addrolemember 'TripCp_admin_Role', 'admin'


use TripCp;
go

create unique nonclustered index indx_user_name on CurrentUser(UserName)
create unique nonclustered index indx_phone_number on CurrentUser(PhoneNumber)

create index indx_trip_id on Ticket(TripId);
create index indx_current_user_id on Ticket(CurrentUserId);
create index indx_transport_id on Trip(TransportId);
create index indx_driver_Id on Transport(DriverId);
use TripCp
go
drop login [userdb];
go
drop login [admindb];
go

--connection login to user
CREATE LOGIN [userdb] WITH PASSWORD=N'userdb',
 DEFAULT_DATABASE=[TripCp], DEFAULT_LANGUAGE=[русский], 
 CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [userdb] ENABLE
GO

--connection login to admin
CREATE LOGIN [admindb] WITH PASSWORD=N'admindb',
 DEFAULT_DATABASE=[TripCp], DEFAULT_LANGUAGE=[русский], 
 CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [admindb] ENABLE
GO

create user [user] for login [userdb]
go
create user [admin] for login [admindb]
go
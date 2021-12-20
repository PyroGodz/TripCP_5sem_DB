use TripCp;
go

---------------------------------------------------
--[Register_User]------------------------------------
---------------------------------------------------

IF OBJECT_ID('[dbo].[Register_User]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[Register_User]
END 
go
create procedure [dbo].[Register_User]
(
	@UserName nvarchar(50),
	@UserPassword nvarchar(50),
	@Admin int,
	@PhoneNumber varchar(16)
)
as begin
begin try
--begin tran
insert into [dbo].[CurrentUser]([UserName],[UserPassword],[Admin],[PhoneNumber])
values (@UserName, @UserPassword, @Admin, @PhoneNumber)
end try
begin catch
print error_message()
end catch
end

---------------------------------------------------
--[Login_User]------------------------------------
---------------------------------------------------

IF OBJECT_ID('[dbo].[Login_User]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[Login_User]
END 
go
create procedure [dbo].[Login_User]
(
	@Name nvarchar(50),
	@Password nvarchar(50)
)
as begin
begin try
execute as User = 'reader'
	select *
       from CurrentUser 
       where (UserName = isnull(@Name,null) and UserPassword = @Password)
	   revert
end try
begin catch
print error_message()
end catch
end
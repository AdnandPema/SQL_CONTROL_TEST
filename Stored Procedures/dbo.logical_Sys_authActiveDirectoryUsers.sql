SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [logical_Sys_authActiveDirectoryUsers]
AS
begin
SELECT * FROM dbo.Users WHERE UserType = 2 AND Activ = 1;
END;
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[authApplicationUsers] 
AS 
begin
SELECT * FROM dbo.Users WHERE UserType = 1 AND Activ = 1;
END
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Logical_Sys_CompanyLogo] 
(
   @logoPath nvarchar( 200 )
) 
AS
BEGIN	 

	DECLARE @fieldName NVARCHAR( 200 );
	SET @fieldName = 'CompanyLogo';
	
	DECLARE	@imgString varchar(80);
	DECLARE @insertString varchar(3000);

  IF NOT EXISTS(SELECT [Name] FROM dbo.Images WHERE [Name] = @fieldName )
	  BEGIN
			SET @imgString = @logoPath

			SET @insertString = N'INSERT INTO images( Name, Image ) 
			' + @fieldName + ', SELECT * FROM OPENROWSET(BULK N''' + @imgString + ''', SINGLE_BLOB) as tempImg'

			EXEC(@insertString)
	  END
  ELSE
	BEGIN
		SET @imgString = @logoPath

		SET @insertString = N'Update images set Image =  SELECT * FROM OPENROWSET(BULK N''' + @imgString + ''', SINGLE_BLOB) as tempImg where name =' + @fieldName

		EXEC(@insertString)
	END
END;
GO

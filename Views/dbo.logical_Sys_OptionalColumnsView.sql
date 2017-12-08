SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*  
Description:   View e cila merr Optional Columns. 
               Perdoret ne Gjenerim Barkodesh.
Author:   A. Mema
Create Date:   05/09/2017
Param:   --
Return:   --
Modified Date:   --
Modification:   --
*/
CREATE VIEW [dbo].[logical_Sys_OptionalColumnsView]
AS
  SELECT [TableName] AS 'TableName', 
         [ColumnName] AS 'ColumnName', 
		 [ColumnNameToDisplay] AS 'ColumnNameToDisplay', 
		 [Required] AS 'Required', 
		 [Active] AS 'Active', 
		 [RequiredExport] AS 'RequiredExport'
  FROM Optional_Columns;
GO

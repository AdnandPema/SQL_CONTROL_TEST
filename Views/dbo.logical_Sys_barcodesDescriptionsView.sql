SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*  
Description:   View e cila merr pershkrimet e barkodeve per ti shfaqur ne forme historiku te nderfaqa e Gjenerim Barkodesh
Author:   A. Mema
Create Date:   08/09/2017
Param:   --
Return:   [Description] -  i domosdoshem
Modified Date:   --
Modification:   --
*/
CREATE VIEW [dbo].[logical_Sys_barcodesDescriptionsView]
AS
SELECT DISTINCT [Description] AS 'Description'
FROM Voucher_Barcode
WHERE [Description] IS NOT NULL AND [Description] != '';
GO

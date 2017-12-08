SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







CREATE view
[dbo].[Alpha_Kategori]
as
SELECT categoryCode AS Code,DESCRIPTION
 FROM srv.MCAlpha.dbo.KategoriteAlfa

 WHERE categoryCode <>5







GO

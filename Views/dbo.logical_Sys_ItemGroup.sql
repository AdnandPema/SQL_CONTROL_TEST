SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[logical_Sys_ItemGroup]
AS
select code,description from ItemGroup where Active=1
GO

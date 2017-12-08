SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[Logical_Sys_ListItemCatalogActiveRecipes] 
AS
SELECT  DISTINCT Recipeno,RecipeDescription,Startdate,StartHour,EndDate,EndHour FROM dbo.Item_Recipes
                             
                            where 
         --                   ([startdate] <= CONVERT(DATE,GETDATE())and [enddate] >= CONVERT(DATE,GETDATE()))
         --                   and ([starthour] <= CONVERT(VARCHAR(8),GETDATE(),108) and [endhour] >= CONVERT(VARCHAR(8),GETDATE(),108))
         --                   and (
									--monday = 1 and 'monday' = datename(dw,getdate()) 
									--or tuesday = 1 and 'tuesday' = datename(dw,getdate())
									--or Wednesday = 1 and 'Wednesday' = datename(dw,getdate())
									--or thursday = 1 and 'thursday' = datename(dw,getdate())
									--or friday = 1 and 'friday' = datename(dw,getdate())
									--or saturday = 1 and 'saturday' = datename(dw,getdate())
									--or sunday = 1 and 'sunday' = datename(dw,getdate())
         --                   )
         --                    AND
                              Active = 1
ORDER BY StartDate,StartHour ASC
--EXEC dbo.ACTIVE_RECIPES @timeNow = '2013-12-12 ' -- datetime


--SELECT * FROM dbo.Item_Recipes
GO

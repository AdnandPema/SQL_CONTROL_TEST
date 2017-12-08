SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[Logical_Sys_ListActiveRecipes] 
AS
SELECT  DISTINCT recipesno,RecipesDescription,startdate,StartTime,enddate,EndTime,[Type] AS RecipesType FROM dbo.Recipes_Trigger
                            where 
                            Active = 1
                           --  and 
                           --  CONVERT(DATE,GETDATE()) between StartDate and EndDate
                           --AND 
                           --StartTime <= CONVERT(time,getdate(),108) 
                           --AND
                           --CONVERT(time,getdate(),108)  < EndTime
ORDER BY StartDate,StartTime ASC
--EXEC dbo.ACTIVE_RECIPES @timeNow = '2013-12-12 ' -- datetime

GO

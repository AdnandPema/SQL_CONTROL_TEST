SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[Logical_Sys_ListInactiveRecipes] 
AS
SELECT DISTINCT recipesno,RecipesDescription,startdate,StartTime,enddate,EndTime,[type] AS recipesType FROM dbo.Recipes_Trigger
                            where 
                            Active = 0 
ORDER BY StartDate,StartTime ASC


GO

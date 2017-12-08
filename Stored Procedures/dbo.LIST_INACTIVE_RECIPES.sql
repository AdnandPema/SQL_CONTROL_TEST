SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[LIST_INACTIVE_RECIPES] 
AS
SELECT DISTINCT recipesno,RecipesDescription,RecipesDescription,startdate,StartTime,enddate,EndTime FROM dbo.Recipes_Trigger
                            where 
                            Active = 0 
ORDER BY StartDate,StartTime ASC


GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Author,Orges_Kreka,>
-- Create date: <Create Date,08/11/2017,>
-- Description:	<Description,Procedura qe do te marre si parameter tabelen e item dhe do i shtoje tek tabela Item_Recipes ne databaze,>
-- =============================================
CREATE PROCEDURE  [dbo].[Logical_Sys_InsertIntoItemRecipes]
(
	@itemRecipes Item_Recipes_Type READONLY, 
	@recipeNo NVARCHAR(50),
	@recipeDescription NVARCHAR(1000),
	@startDate DATE,
	@endDate DATE,
	@startHour TIME(7),
	@endHour TIME(7),
	@monday BIT,
	@tuesday BIT,
	@wednesday BIT,
	@thursday BIT,
	@friday BIT,
	@saturday BIT,
	@sunday BIT,
	@active BIT,
	@storeType NVARCHAR(4000),
	@storeValue NVARCHAR(4000),
	@clientCode NVARCHAR(50),
	@lastUserModified NVARCHAR(50),
	
	@executationStatus int OUTPUT
	
)
AS
	BEGIN TRY
	BEGIN TRANSACTION
		INSERT INTO dbo.Item_Recipes
		        ( 
		          RecipeNo ,
		          RecipeDescription ,
		          StartDate ,
		          EndDate ,
		          StartHour ,
		          EndHour ,
		          Monday ,
		          TuesDay ,
		          Wednesday ,
		          Thursday ,
		          Friday ,
		          Saturday ,
		          Sunday ,
		          Type ,
		          Code ,
		          Quantity ,
		          UnitPrice ,
		          StoreType ,
		          StoreValue ,
		          Active ,
		          LastUserModified ,
		          LastDateModified ,
		          ClientCode
		        )
		       SELECT
				 @recipeNo,
				 @recipeDescription,
				 @startDate,
				 @endDate,
				 @startHour,
				 @endHour,
				 @monday,
				 @tuesday,
				 @wednesday,
		         @thursday,
		         @friday,
		         @saturday,
				 @sunday,
				 '1',
			     Code,
				 Quantity,
				 UnitPrice,
				 @storeType,
				 @storeValue,
				 @active,
				 @lastUserModified,
				 GETDATE(),
				 @clientCode
				 FROM @itemRecipes
	
	
	   COMMIT TRANSACTION
	   SET @executationStatus = 1;
	   RETURN @executationStatus;
	END TRY
	BEGIN CATCH
		 IF @@TRANCOUNT > 0
		 ROLLBACK TRANSACTION
		SET @executationStatus = 0;
		RETURN @executationStatus;
	END CATCH
GO

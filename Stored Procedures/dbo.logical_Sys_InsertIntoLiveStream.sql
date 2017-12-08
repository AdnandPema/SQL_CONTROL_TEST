SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Author,Orges_Kreka,>
-- Create date: <Create Date,18/09/2017,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[logical_Sys_InsertIntoLiveStream]
(
	  @barcode NVARCHAR(4000)
      ,@startDate DATETIME
      ,@endDate DATETIME
      ,@store NVARCHAR(4000)
      ,@type NVARCHAR(4000)
   --   ,@description NVARCHAR(4000)
      ,@discountValue FLOAT
      ,@discountPer FLOAT
      ,@value FLOAT
   --   ,@active BIT
   --   ,@printed bit
   --   ,@customerID NVARCHAR(4000)
   --   ,@documentNoUsed NVARCHAR(4000)
   --   ,@usedDate DATETIME
   --   ,@usedStore NVARCHAR(4000)
   --   ,@documentNoPrinted NVARCHAR(4000)
   --   ,@printedDate DATETIME
   --   ,@printedStore NVARCHAR(4000)
      ,@status INT
      ,@activeRecipeCode NVARCHAR(50)
      ,@monday BIT
      ,@tuesday BIT
      ,@wednesday BIT
      ,@thursday BIT
      ,@friday BIT
      ,@saturday BIT
      ,@sunday BIT
)
AS
BEGIN
	
	UPDATE dbo.LiveStream	SET
	  [Barcode] = @barcode
      ,[StartDate] = @startDate
      ,[EndDate] = @endDate
      ,[Store] = @store
      ,[Type] = @type
      ,[Description] = 'Per POS'
      ,[DiscountValue] = @discountValue
      ,[Discount%] = @discountPer
      ,[Value] = @value
      ,[Active] = 1
      ,[Printed] = 1
      ,[CustomerId] = ''
      ,[DocumentNoUsed] = ''
      ,[UsedDate] = GETDATE()
      ,[UsedStore] = ''
      ,[DocumentNoPrinted] = ''
      ,[PrintedDate] = GETDATE()
      ,[PrintedStore] = ''
      ,[Status] = @status
      ,[ActiveRecipeCode] = @activeRecipeCode
      ,[Monday] = @monday
      ,[TuesDay] = @tuesday
      ,[Wednesday] = @wednesday
      ,[Thursday] = @thursday
      ,[Friday] = @friday
      ,[Saturday] = @saturday
      ,[Sunday] = @sunday
	  WHERE [Barcode] = @barcode
	  IF @@ROWCOUNT = 0

	 INSERT INTO dbo.LiveStream
	         ( Barcode ,
	           StartDate ,
	           EndDate ,
	           Store ,
	           Type ,
	           Description ,
	           DiscountValue ,
	           [Discount%] ,
	           Value ,
	           Active ,
	           Printed ,
	           CustomerId ,
	           DocumentNoUsed ,
	           UsedDate ,
	           UsedStore ,
	           DocumentNoPrinted ,
	           PrintedDate ,
	           PrintedStore ,
	           Status ,
	           ActiveRecipeCode ,
	           Monday ,
	           TuesDay ,
	           Wednesday ,
	           Thursday ,
	           Friday ,
	           Saturday ,
	           Sunday
	         )
	 VALUES  ( @barcode , -- Barcode - nvarchar(4000)
	           @startDate , -- StartDate - datetime
	           @endDate , -- EndDate - datetime
	           @store , -- Store - nvarchar(4000)
	           @type , -- Type - nvarchar(4000)
	           'Per POS' , -- Description - nvarchar(4000)
	           @discountValue, -- DiscountValue - float
	           @discountPer , -- Discount% - float
	           @value, -- Value - float
	           1 , -- Active - bit
	           1 , -- Printed - bit
	           '' , -- CustomerId - nvarchar(4000)
	           '' , -- DocumentNoUsed - nvarchar(4000)
	           GETDATE(), -- UsedDate - datetime
	           '' , -- UsedStore - nvarchar(4000)
	           '' , -- DocumentNoPrinted - nvarchar(4000)
	           GETDATE() , -- PrintedDate - datetime
	           N'' , -- PrintedStore - nvarchar(4000)
	           @status , -- Status - int
	           @activeRecipeCode , -- ActiveRecipeCode - nvarchar(50)
	           @monday , -- Monday - bit
	           @tuesday , -- TuesDay - bit
	           @wednesday , -- Wednesday - bit
	           @thursday , -- Thursday - bit
	           @friday , -- Friday - bit
	           @saturday , -- Saturday - bit
	           @sunday  -- Sunday - bit
	         )
	
END;
GO

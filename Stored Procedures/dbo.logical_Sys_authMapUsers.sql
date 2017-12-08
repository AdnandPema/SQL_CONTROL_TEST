SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [logical_Sys_authMapUsers]
(	
	@userName nvarchar( 50 ),
	@profileID int,
	@guid text,
	@description nvarchar( 25 ),
	@pass nvarchar( 50 ),
	@activ bit,
	@lineDiscount bit,
	@invoiceDiscount bit,
	@fiscalIvoice bit,
	@eod bit,
	@userType int
)
AS
BEGIN
	INSERT INTO dbo.Users
	        ( 
	          UserName ,
	          Description ,
	          Password ,
	          Activ ,
	          LineDiscount ,
	          InvoiceDiscount ,
	          FiscalInvoice ,
	          EOD ,
	          Profile,
	          User_GUID,
	          UserType
	        )
	VALUES  ( 
			  @userName , -- UserName - nvarchar(50)
	          @description, -- Description - nvarchar(50)
	          @pass , -- Password - nvarchar(50)
	          @activ, -- Activ - bit
	          @lineDiscount , -- LineDiscount - bit
	          @invoiceDiscount , -- InvoiceDiscount - bit
	          @fiscalIvoice , -- FiscalInvoice - bit
	          @eod, -- EOD - bit
	          @profileID,  -- Profile - int,
	          @guid,
	          @userType
	        )
END;
GO

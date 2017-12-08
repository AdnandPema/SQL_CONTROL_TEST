SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*  
Description:   Procedure e cila shton nje barkod ne tabelen Voucher_Barcode nqs ekziston. Perdoret ne nderfaqen Gjenerim Barkodesh.
Author:   A. Mema
Create Date:   04/09/2017
Param:   @barcode = vlera e barkodit
         @description = perhkrimi  i barkodit
		 @active = ???
		 @nodeSynced = ???
		 @message = ???
		 @inProcess = ???
Return:   --
Modified Date:   --
Modification:   --
*/
CREATE PROCEDURE [dbo].[logical_Sys_insertBarcode]
(@barcode [nvarchar](50), @description [nvarchar](50), @active [bit], @nodeSynced [nvarchar](4000), @message [nvarchar](4000), @inProcess [bit])
AS
BEGIN
  IF NOT EXISTS(SELECT [Barcode] FROM Voucher_Barcode WHERE [Barcode] = @barcode)
  BEGIN
    INSERT INTO Voucher_Barcode ([Barcode], [Description], [Active], [NodeSynced], [Message], [InProcess], [LastInsertDate])
    VALUES (@barcode, @description, @active, @nodeSynced, @message, @inProcess, GETDATE());
  END
END
GO

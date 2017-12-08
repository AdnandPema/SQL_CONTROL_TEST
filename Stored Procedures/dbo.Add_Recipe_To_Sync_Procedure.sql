SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Add_Recipe_To_Sync_Procedure] 
(
	@table varchar(50),
	@syncedRowId INT,
	@nodeToSync varchar( 100 ),
	@code     nvarchar( 50 )
)
AS 
BEGIN
	
	UPDATE dbo.Node_SyncStatus SET 
	[Table] = @table,
	[SyncedRowID] = @syncedRowId,
	[NodeToSync] = @nodeToSync,
	Action = 'UPDATE',
	[Code] = @code,
	[Custom1] = '',
	[Custom2] = '',
	[Custom3] = '',
	[LastModifiedDate] = GETDATE()
	WHERE [SyncedRowID] = @SyncedRowID AND [NodeToSync] = @nodeToSync
	
	IF @@ROWCOUNT = 0
	
	INSERT INTO dbo.Node_SyncStatus
	        ( [Table] ,
	          SyncedRowID ,
	          NodeToSync ,
	          Action ,
	          Code ,
	          SyncStatus ,
	          Custom1 ,
	          Custom2 ,
	          Custom3 ,
	          LastModifiedDate
	        )
	VALUES  ( @table , -- Table - varchar(50)
	          @syncedRowId, -- SyncedRowID - int
	          @nodeToSync , -- NodeToSync - varchar(100)
	          'INSERT' , -- Action - nvarchar(50)
	          @code , -- Code - nvarchar(50)
	          0 , -- SyncStatus - bit
	          '' , -- Custom1 - nvarchar(50)
	          '' , -- Custom2 - nvarchar(50)
	          '' , -- Custom3 - nvarchar(50)
	          GETDATE()  -- LastModifiedDate - datetime
	        )
	
END;
GO

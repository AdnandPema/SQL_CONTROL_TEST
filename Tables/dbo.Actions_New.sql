CREATE TABLE [dbo].[Actions_New]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ActionColumn] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Column Name] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[condition] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Type] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[active] [bit] NULL,
[OutputChannelId] [int] NULL CONSTRAINT [DF_Actions_New_OutputChannelId] DEFAULT ((-1))
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================


CREATE TRIGGER [dbo].[T_InsertAction] ON dbo.Actions_New
  FOR INSERT
AS 
DECLARE TrigTempInsert_Cursor CURSOR FOR

SELECT Id, Code FROM Inserted

DECLARE @ID int, @Code varchar(20)

OPEN TrigTempInsert_Cursor;

FETCH NEXT FROM TrigTempInsert_Cursor INTO @ID, @Code
WHILE @@FETCH_STATUS = 0

BEGIN
  -- Insert statements for trigger here
  
  INSERT INTO [Node_SyncStatus]
                                                       ([Table]
                                                       ,[SyncedRowID]
                                                       ,[NodeToSync]
                                                       ,[Action]
                                                       ,[Code]  
                                                       ,[SyncStatus]                                
                                                      )
 Select  'Actions_New'
                                                        ,@ID
                                                        , [NodeName]
                                                        ,'INSERT'  
                                                        ,@Code 
                                                        ,'0'
FROM [Node_TableRelation] nt
inner join Node_Info ni 
on  ni.id=nt.NodeId
WHERE [Table]='Actions_New' 

FETCH NEXT FROM TrigTempInsert_Cursor INTO @ID, @Code

END;

CLOSE TrigTempInsert_Cursor;

DEALLOCATE TrigTempInsert_Cursor;
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================


CREATE TRIGGER [dbo].[T_UpdateAction] ON dbo.Actions_New FOR UPDATE

AS

DECLARE TrigTempUpdate_Cursor CURSOR FOR

SELECT Id, Code FROM Inserted

DECLARE @ID int, @Code varchar(20)

OPEN TrigTempUpdate_Cursor;

FETCH NEXT FROM TrigTempUpdate_Cursor INTO @ID, @Code

WHILE @@FETCH_STATUS = 0

BEGIN

INSERT INTO [Node_SyncStatus]
                                                       ([Table]
                                                       ,[SyncedRowID]
                                                       ,[NodeToSync]
                                                       ,[Action]
                                                       ,[Code]  
                                                       ,[SyncStatus]                                
                                                      )
 Select  'Actions_New'
                                                        ,@ID
                                                        , [NodeName]
                                                        ,'UPDATE'  
                                                        ,@Code 
                                                        ,'0'
FROM [Node_TableRelation] nt
inner join Node_Info ni 
on  ni.id=nt.NodeId
WHERE [Table]='Actions_New' 

FETCH NEXT FROM TrigTempUpdate_Cursor INTO @ID, @Code

END;

CLOSE TrigTempUpdate_Cursor;

DEALLOCATE TrigTempUpdate_Cursor;
GO

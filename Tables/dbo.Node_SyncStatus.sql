CREATE TABLE [dbo].[Node_SyncStatus]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Table] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SyncedRowID] [int] NULL,
[NodeToSync] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Action] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SyncStatus] [bit] NULL,
[Custom1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_tabGjnedjeSync_LastModifiedDate] DEFAULT (getdate())
) ON [PRIMARY]
GO

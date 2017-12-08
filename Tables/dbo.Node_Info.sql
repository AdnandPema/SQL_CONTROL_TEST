CREATE TABLE [dbo].[Node_Info]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[NodeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NodeDescription] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NodeIP] [nchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NodeDataBase] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Password] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom1] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom2] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom3] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_NyjetInfo_DateModified] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Node_Info] ADD CONSTRAINT [PK_Apply_control] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO

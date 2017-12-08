CREATE TABLE [dbo].[InputChannels_Value]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[InputChannelsID] [int] NULL,
[Value] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Column_Name] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProgramType] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Type] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Relation] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Relation_Value] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Database] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NULL
) ON [PRIMARY]
GO

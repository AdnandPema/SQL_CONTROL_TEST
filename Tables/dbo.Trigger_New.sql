CREATE TABLE [dbo].[Trigger_New]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TriggerColumn] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Column Name] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[condition] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Type] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[active] [bit] NULL,
[InputChannelId] [int] NULL
) ON [PRIMARY]
GO

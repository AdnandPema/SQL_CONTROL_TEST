CREATE TABLE [dbo].[Source]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NULL CONSTRAINT [DF_Source_Active] DEFAULT ((1))
) ON [PRIMARY]
GO

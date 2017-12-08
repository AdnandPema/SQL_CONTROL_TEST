CREATE TABLE [dbo].[ClientType]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[Type] [int] NULL,
[Code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NULL
) ON [PRIMARY]
GO

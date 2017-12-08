CREATE TABLE [dbo].[Input_Channels]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Value] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NULL
) ON [PRIMARY]
GO

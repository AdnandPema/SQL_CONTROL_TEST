CREATE TABLE [dbo].[ProfileHeader]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Description] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Level] [int] NULL
) ON [PRIMARY]
GO

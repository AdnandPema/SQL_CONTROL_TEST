CREATE TABLE [dbo].[ProfileLines]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[HeaderId] [int] NULL,
[Modules] [bit] NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Parent] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NameSq] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Priority] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProfileLines] ADD CONSTRAINT [PK_ProfileLines] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO

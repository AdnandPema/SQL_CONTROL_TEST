CREATE TABLE [dbo].[Recipes_Actions]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[RecipesNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OutputChannelId] [int] NULL,
[ActionsId] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ValueAction] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ItemList_BundlePack]
(
[id] [int] NULL,
[Code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ItemClassificator] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Quantity] [float] NULL,
[Active] [bit] NULL
) ON [PRIMARY]
GO

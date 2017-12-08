CREATE TABLE [dbo].[Item_Recipes]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[RecipeNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecipeDescription] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StartDate] [date] NULL,
[EndDate] [date] NULL,
[StartHour] [time] NULL,
[EndHour] [time] NULL,
[Monday] [bit] NULL,
[TuesDay] [bit] NULL,
[Wednesday] [bit] NULL,
[Thursday] [bit] NULL,
[Friday] [bit] NULL,
[Saturday] [bit] NULL,
[Sunday] [bit] NULL,
[Type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Quantity] [float] NULL,
[UnitPrice] [float] NULL,
[StoreType] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StoreValue] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NULL,
[LastUserModified] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastDateModified] [datetime] NULL CONSTRAINT [DF_Item_Recipes_LastDateModified] DEFAULT (getdate()),
[ClientCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO

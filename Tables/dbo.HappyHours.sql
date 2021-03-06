CREATE TABLE [dbo].[HappyHours]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[HHCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Type] [int] NOT NULL,
[Code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UoM] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
[Quantity] [float] NULL CONSTRAINT [DF_HappyHours_Quantity] DEFAULT ((1)),
[UnitPrice] [float] NULL,
[StoreType] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_HappyHours_StoreType] DEFAULT (N'Te Gjithe'),
[StoreValue] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NULL CONSTRAINT [DF_HappyHours_Active] DEFAULT ((1)),
[LastUserModified] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastDateModified] [datetime] NULL CONSTRAINT [DF_HappyHours_LastDateModified] DEFAULT (getdate()),
[ClientCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_HappyHours_ClientCode] DEFAULT (N'All')
) ON [PRIMARY]
GO

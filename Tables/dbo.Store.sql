CREATE TABLE [dbo].[Store]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[StoreCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Surface] [float] NULL,
[City] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[State] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GeograficLocation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NrofCheckOutDesk] [int] NULL,
[StoreFormat] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Series]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Code] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StartingNo] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EndingNo] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastNoUsed] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IncrementBy] [int] NULL,
[StartingDate] [date] NULL,
[CashDesk] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NULL
) ON [PRIMARY]
GO

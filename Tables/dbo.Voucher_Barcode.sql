CREATE TABLE [dbo].[Voucher_Barcode]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[Barcode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NULL,
[NodeSynced] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Voucher_Barcode_NodeSynced] DEFAULT (''),
[Message] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Voucher_Barcode_Message] DEFAULT (''),
[InProcess] [bit] NULL CONSTRAINT [DF_Voucher_Barcode_InProcess] DEFAULT ((0)),
[LastInsertDate] [datetime] NULL CONSTRAINT [DF_Voucher_Barcode_LastInsertDate] DEFAULT (getdate())
) ON [PRIMARY]
GO

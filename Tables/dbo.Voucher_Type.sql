CREATE TABLE [dbo].[Voucher_Type]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TextToPrint] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrintText] [bit] NULL,
[HeaderText] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrintHeader] [bit] NULL,
[PrintValidity] [bit] NULL,
[PrintBarcode] [bit] NULL,
[PrintFooter] [bit] NULL,
[FooterText] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[Users]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Password] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Activ] [bit] NULL,
[LineDiscount] [bit] NULL,
[InvoiceDiscount] [bit] NULL,
[FiscalInvoice] [bit] NULL,
[EOD] [bit] NULL,
[Profile] [int] NULL,
[UserType] [int] NULL,
[User_GUID] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

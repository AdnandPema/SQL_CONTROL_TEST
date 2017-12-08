CREATE TABLE [dbo].[Voucher_Recipes]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecipeNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VoucherStartDate] [datetime] NULL,
[StartTime] [datetime] NULL,
[VoucherEndDate] [datetime] NULL,
[EndTime] [datetime] NULL,
[VoucherDescription] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VoucherStore] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VoucherStoreSpecific] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Voucher_Type] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Voucher_Recipes_Voucher_Type] DEFAULT (N'Tipi1'),
[PeriodType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Voucher_Recipes_PeriodType] DEFAULT (N'Datë Fikse'),
[PeriodDay] [int] NULL CONSTRAINT [DF_Voucher_Recipes_PeriodDay] DEFAULT ((30)),
[Status] [int] NULL CONSTRAINT [DF_Voucher_Recipes_Status] DEFAULT ((0)),
[ActiveRecipeCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Monday] [bit] NULL,
[TuesDay] [bit] NULL,
[Wednesday] [bit] NULL,
[Thursday] [bit] NULL,
[Friday] [bit] NULL,
[Saturday] [bit] NULL,
[Sunday] [bit] NULL
) ON [PRIMARY]
GO

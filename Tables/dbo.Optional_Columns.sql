CREATE TABLE [dbo].[Optional_Columns]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[TableName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ColumnName] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ColumnNameToDisplay] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Required] [bit] NULL,
[Active] [bit] NULL,
[LastModifiedDate] [datetime] NULL CONSTRAINT [DF_Optional_Columns_LastModifiedDate] DEFAULT (getdate()),
[Tag] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RequiredExport] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Optional_Columns] ADD CONSTRAINT [PK_Optional_Columns] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO

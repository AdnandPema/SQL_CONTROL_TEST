CREATE TABLE [dbo].[Node_TableRelation]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[NodeID] [int] NOT NULL,
[Table] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LasModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_NyjeTabConfig_LasModifiedDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Node_TableRelation] ADD CONSTRAINT [PK_Node_TableRelation] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Node_TableRelation] ADD CONSTRAINT [FK_Node_TableRelation_Node_Info] FOREIGN KEY ([NodeID]) REFERENCES [dbo].[Node_Info] ([ID]) ON DELETE CASCADE
GO

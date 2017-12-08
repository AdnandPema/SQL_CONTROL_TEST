SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[Logical_Rpt_LogBraktisjeKuponi]

(
@DateFillim AS nvarchar(10), 
@DateMbarim AS nvarchar(10),
@Cashier AS varchar(100),
@Cashdesk as varchar(30),
@DocumentNo as varchar(50),
@ItemNo as varchar(50) 
)
AS
 
Declare @sql nvarchar(max)
SET @sql = 'SELECT [DocumentDate]
                            ,CONVERT(VARCHAR(8),[Time],108) as [Time]
                            ,[DocumentNo]
                            ,[User]
                            ,[Host]
                            ,[DocumentType]
                            ,[Code]
                            ,[Description]
                            ,[Quantity]
                            ,[Price]

                            FROM LogiPOS.dbo.[Log] where  [DocumentDate] between '''+@DateFillim+ '''and''' +@DateMbarim+''''  

			if (@Cashier != 'Të gjithë' and @Cashier != 'All Cashiers' and @Cashier != '' )
			begin set @sql= @sql + ' and [User] = ''' +@Cashier + '''' end
            
            if (@CashDesk != 'Të gjithë' and @CashDesk != 'All Desks' and @CashDesk != '')
            begin set @sql += ' and [Host] = '''+ @CashDesk+'''' end
               
            if (@DocumentNo!= '')
            begin set @sql += 'and [DocumentNo] like ''%'+ @DocumentNo +'%''' end
            
            if (@ItemNo != '')
            begin set @sql += ' and [Code] like  ''%' + @ItemNo +'%''' end
			execute(@sql)
GO

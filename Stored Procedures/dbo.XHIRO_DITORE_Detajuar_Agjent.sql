SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[XHIRO_DITORE_Detajuar_Agjent] (@st AS nvarchar(10), @et AS nvarchar(10),@agjent as nvarchar(Max))
AS
Declare @ParamDefinition AS nvarchar(Max)
Declare @sql as nvarchar(MAX)
SET @sql= 'select 
                              min(Agjenti) Agjenti,
                              KodiArtikullit,
                              min(Pershkrimi) Pershkrimi,
                              SUM(Sasia) Sasia,
                              MIN(Cmimi) Cmimi,
                              SUM(Total) Total
                              from
                              (
                              select
                              (sp.Description) as Agjenti,
                              ItemNo as KodiArtikullit,
                              (sl.Description)  as Pershkrimi,
                              (Quantity) as Sasia,
                              (UnitPrice) as Cmimi,
                              (SL.Amount) as Total
                              from
                              LogiPOS_New.dbo.saleslines SL
                              left join LogiPos.dbo.SalesHeader SH on SH.ID=sl.HeaderID
                              left Join LogiPos.dbo.SalesPerson sp on sp.Code= SH.SalesPerson
                              where sh.documentDate between '''+ @st+ ''' and '''+ @et+ '''
                              union all
                              select
                              (sp.Description) as Agjenti,
                              ItemNo as KodiArtikullit,
                              (hsl.Description)as  Pershkrimi,
                              (Quantity) as Sasia,
                              (UnitPrice) as Cmimi,
                              (HSL.Amount) as Total
                              from
                              LogiPOS_New.dbo.Hsaleslines HSL
                              left join LogiPos.dbo.HSalesHeader HSH on HSH.ID=Hsl.HeaderID
                              left Join LogiPos.dbo.SalesPerson sp on sp.Code= hsh.SalesPerson
                              where HSH.documentDate between '''+ @st+ ''' and '''+ @et+ '''
                              ) A'
                              
IF @agjent = '' or  @agjent='Të gjithë' or  @agjent= 'All Salespersons'
BEGIN
SET @sql = @sql
END
else 
BEGIN
SET @sql = @sql +' where Agjenti ='''+ @agjent + ''''
END

SET @sql = @sql +' group by Agjenti,KodiArtikullit
                           order by Agjenti,KodiArtikullit'

Execute(@sql)
--Set @ParamDefinition ='@agjent nvarchar(max), @st DateTime, @et DateTime'
--EXECUTE (@st)
--Execute(@et) 
--Execute(@agjent)
--Execute(@ParamDefinition)
--Execute(@sql)  
-- where sh.documentDate between '''+ @st+ ''' and '''+@et+'''            
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[Shitje_Sipas_Klasifikimit] 

(
@DateFillim AS DATETIME,
@DateMbarim AS DateTime,
@Category as varchar(50),
@Customer as varchar(50),
@Item as varchar(50)
)

AS

DECLARE @KNga varchar(30)
DECLARE @KDeri varchar(30)

DECLARE @CNga varchar(30)
DECLARE @CDeri varchar(30)


SET @KNga = @Category
SET @KDeri = @Category

SET @CNga = @Customer
SET @CDeri = @Customer

IF @Category= 'Të gjithë'
BEGIN
SET @KNga = ''
SET @KDeri = 'ZZ'
END

IF @Customer = 'Të gjithë'
BEGIN
SET @CNga = ''
SET @CDeri = 'ZZ'
END
--IF @Customer = 'BLUEBAR'
--BEGIN
--SET @CNga = 'KB01'
--SET @CDeri = 'KB04'
--END

Select 

KodiArtikullit,
MIN(Pershkrimi) as Pershkrimi,
MIN(Kategoria) as Kategoria,
MIN(Grupi) as Grupi,
MIN(Klasif3) as Klasif3,
MIN(Klasif3) as Klasif4,
MIN(Klasif3) as Klasif5,
MIN(Klasif3) as Klasif6,
round(isnull(SUM(Vlera)/nullif(sum(Sasia),0),0),2) as Cmimi,
sum(Sasia) as Sasia,
SUM(Vlera) as Vlera
from

(

select 

ItemNo as KodiArtikullit,
i.Description as Pershkrimi,
i.[Item Category Code] as Kategoria,
i.[item group code] as Grupi,
i.[Item Category 3] as Klasif3,
i.[Item Category 4]as Klasif4,
i.[Item Category 5]as Klasif5,
i.[Item Category 6]as Klasif6,
i.[Unit Price] as Cmimi,
(Quantity) as Sasia,
(sl.Amount) as Vlera
from LogiPOS.dbo.SalesLines sl
left join LogiPOS.dbo.Item i on i.No = sl.ItemNo
left join LogiPOS.dbo.SalesHeader sh on sh.ID = sl.HeaderID
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
AND I.[ITEM Category CODE] >= @KNga AND I.[ITEM Category CODE] <= @KDeri 
AND SH.Location >= @CNga AND SH.Location <= @CDeri
AND I.DESCRIPTION LIKE '%' + @ITEM + '%'                           
                            
--union all
--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--i.[Item Category 5]as Klasif5,
--i.[Item Category 6]as Klasif6,
--i.[Unit Price] as Cmimi,
--Quantity as Sasia,
--Hsl.Amount as Vlera
--from NuNuNa.dbo.HSalesLines Hsl
--left join NuNuNa.dbo.Item i on i.No = Hsl.ItemNo
--left join NuNuNa.dbo.HSalesHeader Hsh on Hsh.ID = Hsl.HeaderID
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE]>= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND HSH.Location >= @CNga AND HSH.Location <= @CDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'

--union all --MarketPlace

--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--i.[Item Category 5]as Klasif5,
--i.[Item Category 6]as Klasif6,
--i.[Unit Price] as Cmimi,
--(Quantity) as Sasia,
--(sl.Amount) as Vlera
--from MarketPlace.dbo.SalesLines sl
--left join MarketPlace.dbo.Item i on i.No = sl.ItemNo
--left join MarketPlace.dbo.SalesHeader sh on sh.ID = sl.HeaderID
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE] >= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND SH.Location >= @CNga AND SH.Location <= @CDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'                           
                            
--union all
--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--i.[Item Category 5]as Klasif5,
--i.[Item Category 6]as Klasif6,
--i.[Unit Price] as Cmimi,
--Quantity as Sasia,
--Hsl.Amount as Vlera
--from MarketPlace.dbo.HSalesLines Hsl
--left join MarketPlace.dbo.Item i on i.No = Hsl.ItemNo
--left join MarketPlace.dbo.HSalesHeader Hsh on Hsh.ID = Hsl.HeaderID
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE]>= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND HSH.Location >= @CNga AND HSH.Location <= @CDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'

--union all --Souvenir

--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--i.[Item Category 5]as Klasif5,
--i.[Item Category 6]as Klasif6,
--i.[Unit Price] as Cmimi,
--(Quantity) as Sasia,
--(sl.Amount) as Vlera
--from Souvenir.dbo.SalesLines sl
--left join Souvenir.dbo.Item i on i.No = sl.ItemNo
--left join Souvenir.dbo.SalesHeader sh on sh.ID = sl.HeaderID
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE] >= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND SH.Location >= @CNga AND SH.Location <= @CDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'                           
                            
--union all
--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--i.[Item Category 5]as Klasif5,
--i.[Item Category 6]as Klasif6,
--i.[Unit Price] as Cmimi,
--Quantity as Sasia,
--Hsl.Amount as Vlera
--from Souvenir.dbo.HSalesLines Hsl
--left join Souvenir.dbo.Item i on i.No = Hsl.ItemNo
--left join Souvenir.dbo.HSalesHeader Hsh on Hsh.ID = Hsl.HeaderID
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE]>= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND HSH.Location >= @CNga AND HSH.Location <= @CDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'

--union all --Pascucci

--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--i.[Item Category 5]as Klasif5,
--i.[Item Category 6]as Klasif6,
--i.[Unit Price] as Cmimi,
--(Quantity) as Sasia,
--(sl.Amount) as Vlera
--from Pascucci.dbo.SalesLines sl
--left join Pascucci.dbo.Item i on i.No = sl.ItemNo
--left join Pascucci.dbo.SalesHeader sh on sh.ID = sl.HeaderID
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE] >= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND SH.Location >= @CNga AND SH.Location <= @CDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'                           
                            
--union all
--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--i.[Item Category 5]as Klasif5,
--i.[Item Category 6]as Klasif6,
--i.[Unit Price] as Cmimi,
--Quantity as Sasia,
--Hsl.Amount as Vlera
--from Pascucci.dbo.HSalesLines Hsl
--left join Pascucci.dbo.Item i on i.No = Hsl.ItemNo
--left join Pascucci.dbo.HSalesHeader Hsh on Hsh.ID = Hsl.HeaderID
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE]>= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND HSH.Location >= @CNga AND HSH.Location <= @CDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'
     
--     union all --Segafredo

--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--i.[Item Category 5]as Klasif5,
--i.[Item Category 6]as Klasif6,
--i.[Unit Price] as Cmimi,
--(Quantity) as Sasia,
--(sl.Amount) as Vlera
--from Segafredo.dbo.SalesLines sl
--left join Segafredo.dbo.Item i on i.No = sl.ItemNo
--left join Segafredo.dbo.SalesHeader sh on sh.ID = sl.HeaderID
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE] >= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND SH.Location >= @CNga AND SH.Location <= @CDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'                           
                            
--union all
--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--i.[Item Category 5]as Klasif5,
--i.[Item Category 6]as Klasif6,
--i.[Unit Price] as Cmimi,
--Quantity as Sasia,
--Hsl.Amount as Vlera
--from Segafredo.dbo.HSalesLines Hsl
--left join Segafredo.dbo.Item i on i.No = Hsl.ItemNo
--left join Segafredo.dbo.HSalesHeader Hsh on Hsh.ID = Hsl.HeaderID
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE]>= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND HSH.Location >= @CNga AND HSH.Location <= @CDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'
             
        
) A  

group by KodiArtikullit
order by Sasia Desc


GO

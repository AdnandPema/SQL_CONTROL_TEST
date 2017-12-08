SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [dbo].[Permbledhese_Artikuj] 

(
@DateFillim AS DATETIME,
@DateMbarim AS DateTime,
@Waiter AS varchar(50),
@Category as varchar(50),
@Customer as varchar(50),
@Item as varchar(50)
)

AS

DECLARE @WNga  varchar(50)
DECLARE @WDeri  varchar(50)

DECLARE @KNga varchar(30)
DECLARE @KDeri varchar(30)

DECLARE @CNga varchar(30)
DECLARE @CDeri varchar(30)

SET @WNga = @Waiter
SET @WDeri = @Waiter

SET @KNga = @Category
SET @KDeri = @Category

SET @CNga = @Customer
SET @CDeri = @Customer

IF @Waiter = 'Të gjithë'
BEGIN
SET @WNga = '00'
SET @WDeri = 'ZZ'
END

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
--MIN(Grupi) as Grupi,
--MIN(Klasif3) as Klasif3,
--MIN(Klasif3) as Klasif4,
min(Kamarieri) as Kamarieri,
--MIN(Klienti)as Klienti,
--waiterid,
isnull(round(SUM(Vlera),2)/nullif(sum(Sasia),0),0) as Cmimi,
sum(Sasia) as Sasia,
round(SUM(Vlera),0) as Total
from

(select 

ItemNo as KodiArtikullit,
i.Description as Pershkrimi,
i.[Item Category Code] as Kategoria,
i.[item group code] as Grupi,
i.[Item Category 3] as Klasif3,
i.[Item Category 4]as Klasif4,
u.Description as Kamarieri,
--c.Name as Klienti,
sh.Cashier as waiterid,
i.[Unit Price] as Cmimi,
(Quantity) as Sasia,
(sl.Amount) as Vlera
from LogiPos.dbo.SalesLines sl
left join LogiPos.dbo.Item i on i.No = sl.ItemNo
left join LogiPos.dbo.SalesHeader sh on sh.ID = sl.HeaderID
left join LogiPos.dbo.Users u on u.Id = sh.Cashier
--left join bar.logibarveror.dbo.Customer C on C.[No] = sh.CustomerNo
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
AND I.[ITEM Category CODE] >= @KNga AND I.[ITEM Category CODE] <= @KDeri 
AND SH.Location >= @CNga AND SH.Location <= @CDeri
AND u.Description >= @WNga AND u.Description <= @WDeri
AND I.DESCRIPTION LIKE '%' + @ITEM + '%'                           
                            
--union all


--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--u.Description as Kamarieri,
----c.Name as Klienti,
--sh.Cashier as waiterid,
--i.[Unit Price] as Cmimi,
--(Quantity) as Sasia,
--(sl.Amount) as Vlera
--from MarketPlace.dbo.SalesLines sl
--left join MarketPlace.dbo.Item i on i.No = sl.ItemNo
--left join MarketPlace.dbo.SalesHeader sh on sh.ID = sl.HeaderID
--left join MarketPlace.dbo.Users u on u.Id = sh.Cashier
----left join bar.logibarveror.dbo.Customer C on C.[No] = sh.CustomerNo
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE] >= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND SH.Location >= @CNga AND SH.Location <= @CDeri
--AND u.Description >= @WNga AND u.Description <= @WDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'                           
                            
--union all

--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--u.Description as Kamarieri,
----c.Name as Klienti,
--hsh.Cashier as waiterid,
--i.[Unit Price] as Cmimi,
--Quantity as Sasia,
--Hsl.Amount as Vlera
--from MarketPlace.dbo.HSalesLines Hsl
--left join MarketPlace.dbo.Item i on i.No = Hsl.ItemNo
--left join MarketPlace.dbo.HSalesHeader Hsh on Hsh.ID = Hsl.HeaderID
--left join MarketPlace.dbo.Users u on u.Id = hsh.Cashier
----left join bar.logibarveror.dbo.Customer C on C.[No] = hsh.CustomerNo
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE]>= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND HSH.Location >= @CNga AND HSH.Location <= @CDeri
--AND u.Description >= @WNga AND u.Description <= @WDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'

--union all --NuNuNa

--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--u.Description as Kamarieri,
----c.Name as Klienti,
--sh.Cashier as waiterid,
--i.[Unit Price] as Cmimi,
--(Quantity) as Sasia,
--(sl.Amount) as Vlera
--from NuNuNa.dbo.SalesLines sl
--left join NuNuNa.dbo.Item i on i.No = sl.ItemNo
--left join NuNuNa.dbo.SalesHeader sh on sh.ID = sl.HeaderID
--left join NuNuNa.dbo.Users u on u.Id = sh.Cashier
----left join bar.logibarveror.dbo.Customer C on C.[No] = sh.CustomerNo
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE] >= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND SH.Location >= @CNga AND SH.Location <= @CDeri
--AND u.Description >= @WNga AND u.Description <= @WDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'                           
                            
--union all

--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--u.Description as Kamarieri,
----c.Name as Klienti,
--hsh.Cashier as waiterid,
--i.[Unit Price] as Cmimi,
--Quantity as Sasia,
--Hsl.Amount as Vlera
--from NuNuNa.dbo.HSalesLines Hsl
--left join NuNuNa.dbo.Item i on i.No = Hsl.ItemNo
--left join NuNuNa.dbo.HSalesHeader Hsh on Hsh.ID = Hsl.HeaderID
--left join NuNuNa.dbo.Users u on u.Id = hsh.Cashier
----left join bar.logibarveror.dbo.Customer C on C.[No] = hsh.CustomerNo
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE]>= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND HSH.Location >= @CNga AND HSH.Location <= @CDeri
--AND u.Description >= @WNga AND u.Description <= @WDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'

--union all --Souvenir

--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--u.Description as Kamarieri,
----c.Name as Klienti,
--sh.Cashier as waiterid,
--i.[Unit Price] as Cmimi,
--(Quantity) as Sasia,
--(sl.Amount) as Vlera
--from Souvenir.dbo.SalesLines sl
--left join Souvenir.dbo.Item i on i.No = sl.ItemNo
--left join Souvenir.dbo.SalesHeader sh on sh.ID = sl.HeaderID
--left join Souvenir.dbo.Users u on u.Id = sh.Cashier
----left join bar.logibarveror.dbo.Customer C on C.[No] = sh.CustomerNo
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE] >= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND SH.Location >= @CNga AND SH.Location <= @CDeri
--AND u.Description >= @WNga AND u.Description <= @WDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'                           
                            
--union all

--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--u.Description as Kamarieri,
----c.Name as Klienti,
--hsh.Cashier as waiterid,
--i.[Unit Price] as Cmimi,
--Quantity as Sasia,
--Hsl.Amount as Vlera
--from Souvenir.dbo.HSalesLines Hsl
--left join Souvenir.dbo.Item i on i.No = Hsl.ItemNo
--left join Souvenir.dbo.HSalesHeader Hsh on Hsh.ID = Hsl.HeaderID
--left join Souvenir.dbo.Users u on u.Id = hsh.Cashier
----left join bar.logibarveror.dbo.Customer C on C.[No] = hsh.CustomerNo
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE]>= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND HSH.Location >= @CNga AND HSH.Location <= @CDeri
--AND u.Description >= @WNga AND u.Description <= @WDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'

--union all --Pascucci

--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--u.Description as Kamarieri,
----c.Name as Klienti,
--sh.Waiter as waiterid,
--i.[Unit Price] as Cmimi,
--(Quantity) as Sasia,
--(sl.Amount) as Vlera
--from Pascucci.dbo.SalesLines sl
--left join Pascucci.dbo.Item i on i.No = sl.ItemNo
--left join Pascucci.dbo.SalesHeader sh on sh.ID = sl.HeaderID
--left join Pascucci.dbo.Users u on u.Id = sh.Waiter
----left join bar.logibarveror.dbo.Customer C on C.[No] = sh.CustomerNo
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE] >= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND SH.Location >= @CNga AND SH.Location <= @CDeri
--AND u.Description >= @WNga AND u.Description <= @WDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'                           
                            
--union all

--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--u.Description as Kamarieri,
----c.Name as Klienti,
--hsh.Waiter as waiterid,
--i.[Unit Price] as Cmimi,
--Quantity as Sasia,
--Hsl.Amount as Vlera
--from Pascucci.dbo.HSalesLines Hsl
--left join Pascucci.dbo.Item i on i.No = Hsl.ItemNo
--left join Pascucci.dbo.HSalesHeader Hsh on Hsh.ID = Hsl.HeaderID
--left join Pascucci.dbo.Users u on u.Id = hsh.Waiter
----left join bar.logibarveror.dbo.Customer C on C.[No] = hsh.CustomerNo
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE]>= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND HSH.Location >= @CNga AND HSH.Location <= @CDeri
--AND u.Description >= @WNga AND u.Description <= @WDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'

--union all --Segafredo

--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--u.Description as Kamarieri,
----c.Name as Klienti,
--sh.Waiter as waiterid,
--i.[Unit Price] as Cmimi,
--(Quantity) as Sasia,
--(sl.Amount) as Vlera
--from Segafredo.dbo.SalesLines sl
--left join Segafredo.dbo.Item i on i.No = sl.ItemNo
--left join Segafredo.dbo.SalesHeader sh on sh.ID = sl.HeaderID
--left join Segafredo.dbo.Users u on u.Id = sh.Waiter
----left join bar.logibarveror.dbo.Customer C on C.[No] = sh.CustomerNo
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE] >= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND SH.Location >= @CNga AND SH.Location <= @CDeri
--AND u.Description >= @WNga AND u.Description <= @WDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'                           
                            
--union all

--select 

--ItemNo as KodiArtikullit,
--i.Description as Pershkrimi,
--i.[Item Category Code] as Kategoria,
--i.[item group code] as Grupi,
--i.[Item Category 3] as Klasif3,
--i.[Item Category 4]as Klasif4,
--u.Description as Kamarieri,
----c.Name as Klienti,
--hsh.Waiter as waiterid,
--i.[Unit Price] as Cmimi,
--Quantity as Sasia,
--Hsl.Amount as Vlera
--from Segafredo.dbo.HSalesLines Hsl
--left join Segafredo.dbo.Item i on i.No = Hsl.ItemNo
--left join Segafredo.dbo.HSalesHeader Hsh on Hsh.ID = Hsl.HeaderID
--left join Segafredo.dbo.Users u on u.Id = hsh.Waiter
----left join bar.logibarveror.dbo.Customer C on C.[No] = hsh.CustomerNo
--WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND I.[ITEM Category CODE]>= @KNga AND I.[ITEM Category CODE] <= @KDeri 
--AND HSH.Location >= @CNga AND HSH.Location <= @CDeri
--AND u.Description >= @WNga AND u.Description <= @WDeri
--AND I.DESCRIPTION LIKE '%' + @ITEM + '%'


) A  

group by waiterid,KodiArtikullit
order by Sasia Desc



GO

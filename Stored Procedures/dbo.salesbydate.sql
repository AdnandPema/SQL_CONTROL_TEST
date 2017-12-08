SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE Procedure [dbo].[salesbydate] 

@DateFillim as datetime,
@DateMbarim as datetime,
@Customer as nvarchar(50)

as

DECLARE @CNga nvarchar(50)
DECLARE @CDeri nvarchar(50)

SET @CNga = @Customer
SET @CDeri = @Customer

IF @Customer = 'Të gjithë'
BEGIN
SET @CNga = ''
SET @CDeri = 'zz'
END
--IF @Customer = 'BLUEBAR'
--BEGIN
--SET @CNga = 'KB01'
--SET @CDeri = 'KB04'
--END
select
[Data],
Sum(Coupons) as NrFatura,
round ((SUM(Turnover))/(nullif(sum(Coupons),0)),0) as ShporteMesatare,
round(Sum(Turnover),0) as Xhiro

from
(

select 
DateDoc as 'Data',
COUNT(*) as Coupons,
round ((SUM(Amount))/(nullif(COUNT(*),0)),0) as AvgBasket,
SUM(Amount)as Turnover
from LogiPOS.dbo.SalesHeader
where DateDoc >= @DateFillim AND DateDoc <= @DateMbarim 
AND Location >= @CNga AND Location <= @CDeri 
group by DateDoc

union all

select top 100 percent
DateDoc as 'Data',
COUNT(*) as Coupons,
round ((SUM(Amount))/(nullif(COUNT(*),0)),0) as AvgBasket,
SUM(Amount)as Turnover
from LogiPOS.dbo.HSalesHeader
where DateDoc >= @DateFillim AND DateDoc <= @DateMbarim  
AND Location >= @CNga AND Location <= @CDeri 
group by DateDoc

--union all --Market Place

--select 
--DateDoc as 'Data',
--COUNT(*) as Coupons,
--round ((SUM(Amount))/(nullif(COUNT(*),0)),0) as AvgBasket,
--SUM(Amount)as Turnover
--from MarketPlace.dbo.SalesHeader
--where DateDoc >= @DateFillim AND DateDoc <= @DateMbarim 
--AND Location >= @CNga AND Location <= @CDeri 
--group by DateDoc

--union all

--select top 100 percent
--DateDoc as 'Data',
--COUNT(*) as Coupons,
--round ((SUM(Amount))/(nullif(COUNT(*),0)),0) as AvgBasket,
--SUM(Amount)as Turnover
--from MarketPlace.dbo.HSalesHeader
--where DateDoc >= @DateFillim AND DateDoc <= @DateMbarim  
--AND Location >= @CNga AND Location <= @CDeri 
--group by DateDoc

--union all --NuNuNa

--select 
--DateDoc as 'Data',
--COUNT(*) as Coupons,
--round ((SUM(Amount))/(nullif(COUNT(*),0)),0) as AvgBasket,
--SUM(Amount)as Turnover
--from NuNuNa.dbo.SalesHeader
--where DateDoc >= @DateFillim AND DateDoc <= @DateMbarim 
--AND Location >= @CNga AND Location <= @CDeri 
--group by DateDoc

--union all

--select top 100 percent
--DateDoc as 'Data',
--COUNT(*) as Coupons,
--round ((SUM(Amount))/(nullif(COUNT(*),0)),0) as AvgBasket,
--SUM(Amount)as Turnover
--from NuNuNa.dbo.HSalesHeader
--where DateDoc >= @DateFillim AND DateDoc <= @DateMbarim  
--AND Location >= @CNga AND Location <= @CDeri 
--group by DateDoc

--union all --Pascucci

--select 
--DateDoc as 'Data',
--COUNT(*) as Coupons,
--round ((SUM(Amount))/(nullif(COUNT(*),0)),0) as AvgBasket,
--SUM(Amount)as Turnover
--from Pascucci.dbo.SalesHeader
--where DateDoc >= @DateFillim AND DateDoc <= @DateMbarim 
--AND Location >= @CNga AND Location <= @CDeri 
--group by DateDoc

--union all

--select top 100 percent
--DateDoc as 'Data',
--COUNT(*) as Coupons,
--round ((SUM(Amount))/(nullif(COUNT(*),0)),0) as AvgBasket,
--SUM(Amount)as Turnover
--from Pascucci.dbo.HSalesHeader
--where DateDoc >= @DateFillim AND DateDoc <= @DateMbarim  
--AND Location >= @CNga AND Location <= @CDeri 
--group by DateDoc

--union all --Segafredo

--select 
--DateDoc as 'Data',
--COUNT(*) as Coupons,
--round ((SUM(Amount))/(nullif(COUNT(*),0)),0) as AvgBasket,
--SUM(Amount)as Turnover
--from Segafredo.dbo.SalesHeader
--where DateDoc >= @DateFillim AND DateDoc <= @DateMbarim 
--AND Location >= @CNga AND Location <= @CDeri 
--group by DateDoc

--union all

--select top 100 percent
--DateDoc as 'Data',
--COUNT(*) as Coupons,
--round ((SUM(Amount))/(nullif(COUNT(*),0)),0) as AvgBasket,
--SUM(Amount)as Turnover
--from Segafredo.dbo.HSalesHeader
--where DateDoc >= @DateFillim AND DateDoc <= @DateMbarim  
--AND Location >= @CNga AND Location <= @CDeri 
--group by DateDoc

)A
group by [Data]
order by [Data]





GO

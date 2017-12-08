SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE Procedure [dbo].[salesbymonth] 

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
Muaji = case month([Data])
when '01' then 'Janar'
when '02' then 'Shkurt'
when '03' then 'Mars'
when '04' then 'Prill'
when '05' then 'Maj'
when '06' then 'Qershor'
when '07' then 'Korrik'
when '08' then 'Gusht'
when '09' then 'Shtator'
when '10' then 'Tetor'
when '11' then 'Nentor'
when '12' then 'Dhjetor'
end , --+ ' ' + '|' + convert(nvarchar(50),min(year(Date))
Sum(Coupons) as NrFature,
round ((SUM(Turnover))/(nullif(sum(Coupons),0)),0) as ShporteMesatare,
round (Sum(Turnover),0) as Xhiro

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

--union all --MarketPlace

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

) A
group by Year([Data]),month([Data])
order by month([Data])





GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE Procedure [dbo].[salesbyhour] 

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
--min(Year) as 'Year',min(Month) as 'Month',min(Date) as Date,
Ora = RIGHT('00' + CAST(ora AS VARCHAR), 2) +':00'/* - '+ RIGHT('00' + CAST(ora +1 AS VARCHAR), 2) +':00' as 'Time'*/,
ISNULL(sum(Coupons),0) AS NrFatura,
round(isnull(sum(AvarageBasket),0),0) as ShporteMesatare,
round(ISNULL(sum(Amount),0),0) AS Xhiro,
1 as OreShitje--round(((sum(Amount)/nullif(sum(S),0))*100),2) as Pesha

from
(

SELECT
YEAR(CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))) as 'Year',
CONVERT(VARCHAR(20), DATENAME(MM, CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))), 100) as 'Month',
CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate ))) as 'Date',
DATEPART(hour,DocumentDate ) as ora,
sum(Amount) as Amount,
count(*) as Coupons,
nullif((sum(Amount)/count(*)),0) as AvarageBasket,
(select SUM(Amount) from LogiPOS.dbo.SalesHeader where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND CustomerNo >= @CNga AND CustomerNo <= @CDeri ) as S
from LogiPOS.dbo.SalesHeader
where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND Location >= @CNga AND Location <= @CDeri 
group by DATEPART(hour,documentdate),CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))

UNION ALL

SELECT
YEAR(CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))) as 'Year',
CONVERT(VARCHAR(20), DATENAME(MM, CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))), 100) as 'Month',
CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate ))) as 'Date',
DATEPART(hour,DocumentDate ) as ora,
sum(Amount) as Amount,
count(*) as Coupons,
nullif((sum(Amount)/count(*)),0) as AvarageBasket,
(select SUM(Amount) from LogiPOS.dbo.HSalesHeader where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND CustomerNo >= @CNga AND CustomerNo <= @CDeri ) as S
from LogiPOS.dbo.HSalesHeader
where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND Location >= @CNga AND Location <= @CDeri 
group by DATEPART(hour,documentdate),CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))

--union all --MarketPlace

--SELECT
--YEAR(CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))) as 'Year',
--CONVERT(VARCHAR(20), DATENAME(MM, CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))), 100) as 'Month',
--CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate ))) as 'Date',
--DATEPART(hour,DocumentDate ) as ora,
--sum(Amount) as Amount,
--count(*) as Coupons,
--nullif((sum(Amount)/count(*)),0) as AvarageBasket,
--(select SUM(Amount) from LogiPOS.dbo.SalesHeader where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND CustomerNo >= @CNga AND CustomerNo <= @CDeri ) as S
--from LogiPOS.dbo.SalesHeader
--where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND Location >= @CNga AND Location <= @CDeri 
--group by DATEPART(hour,documentdate),CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))

--UNION ALL

--SELECT
--YEAR(CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))) as 'Year',
--CONVERT(VARCHAR(20), DATENAME(MM, CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))), 100) as 'Month',
--CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate ))) as 'Date',
--DATEPART(hour,DocumentDate ) as ora,
--sum(Amount) as Amount,
--count(*) as Coupons,
--nullif((sum(Amount)/count(*)),0) as AvarageBasket,
--(select SUM(Amount) from LogiPOS.dbo.HSalesHeader where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND CustomerNo >= @CNga AND CustomerNo <= @CDeri ) as S
--from LogiPOS.dbo.HSalesHeader
--where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND Location >= @CNga AND Location <= @CDeri 
--group by DATEPART(hour,documentdate),CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))

--union all --Souvenir

--SELECT
--YEAR(CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))) as 'Year',
--CONVERT(VARCHAR(20), DATENAME(MM, CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))), 100) as 'Month',
--CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate ))) as 'Date',
--DATEPART(hour,DocumentDate ) as ora,
--sum(Amount) as Amount,
--count(*) as Coupons,
--nullif((sum(Amount)/count(*)),0) as AvarageBasket,
--(select SUM(Amount) from Souvenir.dbo.SalesHeader where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND CustomerNo >= @CNga AND CustomerNo <= @CDeri ) as S
--from Souvenir.dbo.SalesHeader
--where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND Location >= @CNga AND Location <= @CDeri 
--group by DATEPART(hour,documentdate),CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))

--UNION ALL

--SELECT
--YEAR(CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))) as 'Year',
--CONVERT(VARCHAR(20), DATENAME(MM, CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))), 100) as 'Month',
--CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate ))) as 'Date',
--DATEPART(hour,DocumentDate ) as ora,
--sum(Amount) as Amount,
--count(*) as Coupons,
--nullif((sum(Amount)/count(*)),0) as AvarageBasket,
--(select SUM(Amount) from Souvenir.dbo.HSalesHeader where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND CustomerNo >= @CNga AND CustomerNo <= @CDeri ) as S
--from Souvenir.dbo.HSalesHeader
--where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND Location >= @CNga AND Location <= @CDeri 
--group by DATEPART(hour,documentdate),CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))

--union all --Pascucci

--SELECT
--YEAR(CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))) as 'Year',
--CONVERT(VARCHAR(20), DATENAME(MM, CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))), 100) as 'Month',
--CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate ))) as 'Date',
--DATEPART(hour,DocumentDate ) as ora,
--sum(Amount) as Amount,
--count(*) as Coupons,
--nullif((sum(Amount)/count(*)),0) as AvarageBasket,
--(select SUM(Amount) from Pascucci.dbo.SalesHeader where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND CustomerNo >= @CNga AND CustomerNo <= @CDeri ) as S
--from Pascucci.dbo.SalesHeader
--where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND Location >= @CNga AND Location <= @CDeri 
--group by DATEPART(hour,documentdate),CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))

--UNION ALL

--SELECT
--YEAR(CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))) as 'Year',
--CONVERT(VARCHAR(20), DATENAME(MM, CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))), 100) as 'Month',
--CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate ))) as 'Date',
--DATEPART(hour,DocumentDate ) as ora,
--sum(Amount) as Amount,
--count(*) as Coupons,
--nullif((sum(Amount)/count(*)),0) as AvarageBasket,
--(select SUM(Amount) from Pascucci.dbo.HSalesHeader where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND CustomerNo >= @CNga AND CustomerNo <= @CDeri ) as S
--from Pascucci.dbo.HSalesHeader
--where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND Location >= @CNga AND Location <= @CDeri 
--group by DATEPART(hour,documentdate),CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))

--union all --Segafredo

--SELECT
--YEAR(CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))) as 'Year',
--CONVERT(VARCHAR(20), DATENAME(MM, CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))), 100) as 'Month',
--CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate ))) as 'Date',
--DATEPART(hour,DocumentDate ) as ora,
--sum(Amount) as Amount,
--count(*) as Coupons,
--nullif((sum(Amount)/count(*)),0) as AvarageBasket,
--(select SUM(Amount) from Segafredo.dbo.SalesHeader where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND CustomerNo >= @CNga AND CustomerNo <= @CDeri ) as S
--from Segafredo.dbo.SalesHeader
--where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND Location >= @CNga AND Location <= @CDeri 
--group by DATEPART(hour,documentdate),CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))

--UNION ALL

--SELECT
--YEAR(CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))) as 'Year',
--CONVERT(VARCHAR(20), DATENAME(MM, CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))), 100) as 'Month',
--CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate ))) as 'Date',
--DATEPART(hour,DocumentDate ) as ora,
--sum(Amount) as Amount,
--count(*) as Coupons,
--nullif((sum(Amount)/count(*)),0) as AvarageBasket,
--(select SUM(Amount) from Segafredo.dbo.HSalesHeader where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND CustomerNo >= @CNga AND CustomerNo <= @CDeri ) as S
--from Segafredo.dbo.HSalesHeader
--where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND Location >= @CNga AND Location <= @CDeri 
--group by DATEPART(hour,documentdate),CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, DocumentDate )))


) A
group by ora
order by ora
--where DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND CustomerNo >= @CNga AND CustomerNo <= @CDeri 





GO

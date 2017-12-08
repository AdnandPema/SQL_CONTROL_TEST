SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[Xhiro_Per_Klient] 

(
@DateFillim AS DATETIME,
@DateMbarim AS DateTime,
--@Waiter AS int,
@Customer as varchar(50)
)

AS

--DECLARE @WNga int
--DECLARE @WDeri int

DECLARE @CNga varchar(30)
DECLARE @CDeri varchar(30)

--SET @WNga = @Waiter
--SET @WDeri = @Waiter

SET @CNga = @Customer
SET @CDeri = @Customer

--IF @Waiter = '-1'
--BEGIN
--SET @WNga = 0
--SET @WDeri = 9999
--END

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
CONVERT(nvarchar(30),DocumentDate, 103) as Datedoc,
--min(computerName),
Customer as Waiter,

--min(Waiter) as Waiter,
SUM(XhiroTotale) AS XhiroTotale, 
sum(NrFatura) AS NrFatura,
SUM(PCARD) AS PCARD,
SUM(PPOINTS)as PPOINTS,
SUM(PVOUCHER) AS PVOUCHER,
SUM(XhiroTotale-PCARD-PVOUCHER) AS LekeCASH, 
ROUND(SUM(XhiroTotale)/NULLIF(COUNT(1),0),0) AS ShporteMesatare

From (


SELECT TOP 100 PERCENT SH.DocumentDate,'c' AS computerName ,'NuNuNa' as Customer,/*min(U.Description) as Waiter,*/SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(PPOINTS)as PPOINTS,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM LogiPOS.dbo.SalesHeader AS SH
inner join LogiPOS.dbo.Customer C on C.[No] = SH.Location
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND SH.Waiter >= @WNga AND SH.Waiter <= @WDeri 
AND SH.Location >= @CNga AND SH.Location <= @CDeri
GROUP BY SH.DocumentDate,SH.CustomerNo
UNION ALL

SELECT TOP 100 PERCENT SH.DocumentDate,'c' AS computerName,'NuNuNa' as Customer,/*min(U.Description) as Waiter,*/SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH,SUM(PPOINTS)as PPOINTS, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM LogiPOS.dbo.HSalesHeader AS SH
inner join LogiPOS.dbo.Customer C on C.[No] = SH.Location
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND SH.Waiter >= @WNga AND SH.Waiter <= @WDeri 
AND SH.Location >= @CNga AND SH.Location <= @CDeri
GROUP BY SH.DocumentDate,SH.CustomerNo

/*UNION ALL --MarketPlace

SELECT TOP 100 PERCENT SH.DocumentDate,'c' AS computerName ,'Market Place' as Customer,/*min(U.Description) as Waiter,*/SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM MarketPlace.dbo.SalesHeader AS SH
inner join MarketPlace.dbo.Customer C on C.[No] = SH.Location
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND SH.Waiter >= @WNga AND SH.Waiter <= @WDeri 
AND SH.Location >= @CNga AND SH.Location<= @CDeri
GROUP BY SH.DocumentDate,SH.CustomerNo
UNION ALL

SELECT TOP 100 PERCENT SH.DocumentDate,'c' AS computerName,'Market Place' as Customer,/*min(U.Description) as Waiter,*/SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM MarketPlace.dbo.HSalesHeader AS SH
inner join MarketPlace.dbo.Customer C on C.[No] = SH.Location
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND SH.Waiter >= @WNga AND SH.Waiter <= @WDeri 
AND SH.Location >= @CNga AND SH.Location <= @CDeri
GROUP BY SH.DocumentDate,SH.CustomerNo

UNION ALL --Souvenir

SELECT TOP 100 PERCENT SH.DocumentDate,'c' AS computerName ,'Souvenir' as Customer,/*min(U.Description) as Waiter,*/SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM Souvenir.dbo.SalesHeader AS SH
inner join Souvenir.dbo.Customer C on C.[No] = SH.Location
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND SH.Waiter >= @WNga AND SH.Waiter <= @WDeri 
AND SH.Location >= @CNga AND SH.Location<= @CDeri
GROUP BY SH.DocumentDate,SH.CustomerNo
UNION ALL

SELECT TOP 100 PERCENT SH.DocumentDate,'c' AS computerName,'Souvenir' as Customer,/*min(U.Description) as Waiter,*/SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM Souvenir.dbo.HSalesHeader AS SH
inner join Souvenir.dbo.Customer C on C.[No] = SH.Location
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND SH.Waiter >= @WNga AND SH.Waiter <= @WDeri 
AND SH.Location >= @CNga AND SH.Location <= @CDeri
GROUP BY SH.DocumentDate,SH.CustomerNo

UNION ALL --Pascucci

SELECT TOP 100 PERCENT SH.DocumentDate,'c' AS computerName ,'Pascucci' as Customer,/*min(U.Description) as Waiter,*/SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM Pascucci.dbo.SalesHeader AS SH
inner join Souvenir.dbo.Customer C on C.[No] = SH.Location
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND SH.Waiter >= @WNga AND SH.Waiter <= @WDeri 
AND SH.Location >= @CNga AND SH.Location<= @CDeri
GROUP BY SH.DocumentDate,SH.CustomerNo
UNION ALL

SELECT TOP 100 PERCENT SH.DocumentDate,'c' AS computerName,'Pascucci' as Customer,/*min(U.Description) as Waiter,*/SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM Pascucci.dbo.HSalesHeader AS SH
inner join Pascucci.dbo.Customer C on C.[No] = SH.Location
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND SH.Waiter >= @WNga AND SH.Waiter <= @WDeri 
AND SH.Location >= @CNga AND SH.Location <= @CDeri
GROUP BY SH.DocumentDate,SH.CustomerNo

UNION ALL --Segafredo

SELECT TOP 100 PERCENT SH.DocumentDate,'c' AS computerName ,'Segafredo' as Customer,/*min(U.Description) as Waiter,*/SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM Segafredo.dbo.SalesHeader AS SH
inner join Segafredo.dbo.Customer C on C.[No] = SH.Location
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND SH.Waiter >= @WNga AND SH.Waiter <= @WDeri 
AND SH.Location >= @CNga AND SH.Location<= @CDeri
GROUP BY SH.DocumentDate,SH.CustomerNo
UNION ALL

SELECT TOP 100 PERCENT SH.DocumentDate,'c' AS computerName,'Segafredo' as Customer,/*min(U.Description) as Waiter,*/SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM Segafredo.dbo.HSalesHeader AS SH
inner join Segafredo.dbo.Customer C on C.[No] = SH.Location
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
--AND SH.Waiter >= @WNga AND SH.Waiter <= @WDeri 
AND SH.Location >= @CNga AND SH.Location <= @CDeri
GROUP BY SH.DocumentDate,SH.CustomerNo*/



) A

GROUP BY CONVERT(nvarchar(30),DocumentDate, 103),Customer
order by CONVERT(nvarchar(30),DocumentDate, 103) 

GO

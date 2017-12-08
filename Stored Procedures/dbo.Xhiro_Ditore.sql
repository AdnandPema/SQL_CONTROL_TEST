SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [dbo].[Xhiro_Ditore] 

(
@DateFillim AS DATETIME,
@DateMbarim AS DateTime,
@Waiter AS  varchar(50),
@Customer as varchar(50)
)

AS

DECLARE @WNga  varchar(50)
DECLARE @WDeri  varchar(50)

DECLARE @CNga varchar(30)
DECLARE @CDeri varchar(30)

SET @WNga = @Waiter
SET @WDeri = @Waiter

SET @CNga = @Customer
SET @CDeri = @Customer

IF @Waiter = 'Të gjithë'
BEGIN
SET @WNga = '00'
SET @WDeri =  'ZZ'
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
CONVERT(nvarchar(30),DocumentDate, 103) as Datedoc,
min(computerName),
min(Waiter) as Waiter,
SUM(XhiroTotale) AS XhiroTotale, 
sum(NrFatura) AS NrFatura,
SUM(PCARD) AS PCARD,
SUM(PVOUCHER) AS PVOUCHER,
SUM(PPOINTS) AS PPOINTS,
SUM(XhiroTotale-PCARD-PVOUCHER) AS LekeCASH, 
ROUND(SUM(XhiroTotale)/NULLIF(COUNT(1),0),0) AS ShporteMesatare

From (



SELECT TOP 100 PERCENT SH.DocumentDate,'M03' AS computerName,/*'SV'+' '+ */min(U.Description) as Waiter,SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(PPOINTS) AS PPOINTS,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
from LogiPOS.dbo.SalesHeader AS SH
inner join  LogiPOS.dbo.Users U on U.ID = SH.cashier
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
AND u.Description >= @WNga AND  u.Description <= @WDeri
AND SH.Location >= @CNga AND SH.Location <= @CDeri
GROUP BY SH.DocumentDate,SH.Cashier

UNION ALL

SELECT TOP 100 PERCENT SH.DocumentDate,'M03' AS computerName,/*'SV'+' '+*/min(U.Description) as Waiter,SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(PPOINTS) AS PPOINTS,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM LogiPOS.dbo.HSalesHeader AS SH
inner join LogiPOS.dbo.Users U on U.ID = SH.cashier
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
AND u.Description >= @WNga AND  u.Description <= @WDeri
AND SH.Location >= @CNga AND SH.Location <= @CDeri
GROUP BY SH.DocumentDate,SH.cashier

/*UNION ALL --MarketPlace

SELECT TOP 100 PERCENT SH.DocumentDate,'M01' AS computerName, min(U.Description) as Waiter,SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(PPOINTS) AS PPOINTS,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
from MarketPlace.dbo.SalesHeader AS SH
inner join  MarketPlace.dbo.Users U on U.ID = SH.cashier
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
AND u.Description >= @WNga AND  u.Description <= @WDeri
AND SH.Location >= @CNga AND SH.Location <= @CDeri
GROUP BY SH.DocumentDate,SH.Cashier

UNION ALL

SELECT TOP 100 PERCENT SH.DocumentDate,'M01' AS computerName,min(U.Description) as Waiter,SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(PPOINTS) AS PPOINTS,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM MarketPlace.dbo.HSalesHeader AS SH
inner join MarketPlace.dbo.Users U on U.ID = SH.cashier
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
AND u.Description >= @WNga AND  u.Description <= @WDeri
AND SH.Location >= @CNga AND SH.Location <= @CDeri
GROUP BY SH.DocumentDate,SH.cashier

UNION ALL --NuNuNa

SELECT TOP 100 PERCENT SH.DocumentDate,'M02' AS computerName, min(U.Description) as Waiter,SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(PPOINTS) AS PPOINTS,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
from NuNuNa.dbo.SalesHeader AS SH
inner join  NuNuNa.dbo.Users U on U.ID = SH.cashier
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
AND u.Description >= @WNga AND  u.Description <= @WDeri
AND SH.Location >= @CNga AND SH.Location <= @CDeri
GROUP BY SH.DocumentDate,SH.Cashier

UNION ALL

SELECT TOP 100 PERCENT SH.DocumentDate,'M02' AS computerName,min(U.Description) as Waiter,SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(PPOINTS) AS PPOINTS,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM NuNuNa.dbo.HSalesHeader AS SH
inner join NuNuNa.dbo.Users U on U.ID = SH.cashier
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
AND u.Description >= @WNga AND  u.Description <= @WDeri
AND SH.Location >= @CNga AND SH.Location <= @CDeri
GROUP BY SH.DocumentDate,SH.cashier

UNION ALL --Pascucci

SELECT TOP 100 PERCENT SH.DocumentDate,'B01' AS computerName, min(U.Description) as Waiter,SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(PPOINTS) AS PPOINTS,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
from Pascucci.dbo.SalesHeader AS SH
inner join  Pascucci.dbo.Users U on U.ID = SH.Waiter
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
AND u.Description >= @WNga AND  u.Description <= @WDeri
AND SH.Location >= @CNga AND SH.Location <= @CDeri
GROUP BY SH.DocumentDate,SH.Waiter

UNION ALL

SELECT TOP 100 PERCENT SH.DocumentDate,'B01' AS computerName,min(U.Description) as Waiter,SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(PPOINTS) AS PPOINTS,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM Pascucci.dbo.HSalesHeader AS SH
inner join Pascucci.dbo.Users U on U.ID = SH.Waiter
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
AND u.Description >= @WNga AND  u.Description <= @WDeri
AND SH.Location >= @CNga AND SH.Location <= @CDeri
GROUP BY SH.DocumentDate,SH.Waiter

UNION ALL --Segafredo

SELECT TOP 100 PERCENT SH.DocumentDate,'B02' AS computerName, min(U.Description) as Waiter,SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(PPOINTS) AS PPOINTS,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
from Segafredo.dbo.SalesHeader AS SH
inner join  Segafredo.dbo.Users U on U.ID = SH.Waiter
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
AND u.Description >= @WNga AND  u.Description <= @WDeri
AND SH.Location >= @CNga AND SH.Location <= @CDeri
GROUP BY SH.DocumentDate,SH.Waiter

UNION ALL

SELECT TOP 100 PERCENT SH.DocumentDate,'B02' AS computerName,min(U.Description) as Waiter,SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(PPOINTS) AS PPOINTS,SUM(sh.Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM Segafredo.dbo.HSalesHeader AS SH
inner join Segafredo.dbo.Users U on U.ID = SH.Waiter
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim 
AND u.Description >= @WNga AND  u.Description <= @WDeri
AND SH.Location >= @CNga AND SH.Location <= @CDeri
GROUP BY SH.DocumentDate,SH.Waiter*/
) A
GROUP BY CONVERT(nvarchar(30),DocumentDate, 103),Waiter
order by min(computerName)




GO

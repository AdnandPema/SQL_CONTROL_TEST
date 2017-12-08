SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[XHIRO_DITORE_Agjent] (@DateFillim AS DATETIME, @DateMbarim AS DateTime,@Cashier as varchar(10),@Cashdesk as varchar(30))
AS

DECLARE @CNga varchar(10)
DECLARE @CDeri varchar(10)

DECLARE @CDNga varchar(30)
DECLARE @CDDeri varchar(30)

SET @CNga = @Cashier
SET @CDeri = @Cashier

SET @CDNga = @CashDesk
SET @CDDeri = @CashDesk

IF @Cashier = ''
BEGIN
SET @CNga = '00'
SET @CDeri = 'ZZ'
END

IF @CashDesk = ''
BEGIN
SET @CDNga = '00'
SET @CDDeri = 'ZZ'
END
SELECT  MIN(SalesPerson) AS SalesPerson,SUM( XhiroTotale) AS XhiroTotale,COUNT(1) AS NrFatura ,
SUM(PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(LekeCASH) AS LekeCASH, ROUND(SUM(XhiroTotale)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM (
SELECT TOP 100 PERCENT --SH.DateDoc,
--SH.CashDesk,
sh.salesperson AS code,
min(sp.Description) as SalesPerson,SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM LogiPos.dbo.SalesHeader AS SH
left join LogiPos.dbo.SalesPerson sp on sp.Code = SH.SalesPerson
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND SH.SalesPerson >= @CNga AND SH.SalesPerson <= @CDeri AND SH.CashDesk >= @CDNga AND SH.CashDesk <= @CDDeri
GROUP BY sh.DocumentNo,SH.SalesPerson--,SH.CashDesk--,SH.DateDoc,SH.CashDesk
UNION ALL
SELECT TOP 100 PERCENT --SH.DateDoc,
--SH.CashDesk,
sh.salesperson AS code,
min(sp.Description) as SalesPerson,SUM(SH.Amount) AS XhiroTotale, COUNT(1) AS NrFatura,
SUM(SH.PCARD) AS PCARD,SUM(PVOUCHER) AS PVOUCHER,SUM(Amount-PCARD-PVOUCHER) AS LekeCASH, ROUND(SUM(SH.Amount)/NULLIF(COUNT(1),0),0) AS ShporteMesatare
FROM LogiPos.dbo.HSalesHeader AS SH
left join  LogiPos.dbo.SalesPerson sp on sp.Code = SH.SalesPerson
WHERE DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim AND SH.SalesPerson >= @CNga AND SH.SalesPerson <= @CDeri AND SH.CashDesk >= @CDNga AND SH.CashDesk <= @CDDeri
GROUP BY sh.DocumentNo,SH.SalesPerson--,SH.CashDesk--,SH.DateDoc,SH.CashDesk
)a
GROUP BY a.code
GO

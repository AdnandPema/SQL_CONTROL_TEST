SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[Logical_Rpt_PaymentMethods]

(
@DateFillim AS DATETIME, 
@DateMbarim AS DateTime,
@Cashier AS int,
@Cashdesk as varchar(30)
)
AS

DECLARE @CNga int
DECLARE @CDeri int

DECLARE @CDNga varchar(30)
DECLARE @CDDeri varchar(30)

SET @CNga = @Cashier
SET @CDeri = @Cashier

SET @CDNga = @CashDesk
SET @CDDeri = @CashDesk

IF @Cashier = ''
BEGIN
SET @CNga = 0
SET @CDeri = 9999
END

IF @CashDesk = ''
BEGIN
SET @CDNga = '00'
SET @CDDeri = 'ZZ'
END

select
Cashier,
min(U.Description) CashierName,
Tipi,
Sum(Amount)Amount

from

(

select 
Cashier,
DocumentDate,
DateDoc,
'PCASH' Tipi,
(Amount-PCARD-PVOUCHER-PPOINTS) as Amount
from LogiPos.dbo.SalesHeader H
WHERE (DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim)
AND (H.Cashier >= @CNga AND H.Cashier <= @CDeri)
AND (H.CashDesk >= @CDNga AND H.CashDesk <= @CDDeri)
and PCASH <> 0

union all

select 
H.Cashier,
H.DocumentDate,
H.DateDoc,
min(M.Description) as Tipi,
sum(P.Amount) as Amount
from LogiPos.dbo.BPayment_Transaction P
left join LogiPos.dbo.BPaymentMethod M on M.Code = P.BPaymentCode
left join LogiPos.dbo.SalesHeader H on h.DocumentNo = p.DocumentNo
WHERE (h.DocumentDate >= @DateFillim AND h.DocumentDate <= @DateMbarim)
AND (H.Cashier >= @CNga AND H.Cashier <= @CDeri)
AND (H.CashDesk >= @CDNga AND H.CashDesk <= @CDDeri)
and PCARD <> 0
group by H.Cashier, H.DocumentDate, h.DateDoc, P.BPaymentCode

union all

select 
Cashier,
DocumentDate,
DateDoc,
'PVoucher' Tipi,
PVOUCHER as Amount
from LogiPos.dbo.SalesHeader H
WHERE (DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim)
AND (H.Cashier >= @CNga AND H.Cashier <= @CDeri)
AND (H.CashDesk >= @CDNga AND H.CashDesk <= @CDDeri)
and PVOUCHER <> 0

union all

select 
Cashier,
DocumentDate,
DateDoc,
'PPOINTS' Tipi,
PVOUCHER as Amount
from LogiPos.dbo.SalesHeader H
WHERE (DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim)
AND (H.Cashier >= @CNga AND H.Cashier <= @CDeri)
AND (H.CashDesk >= @CDNga AND H.CashDesk <= @CDDeri)
and PPOINTS <> 0

union all --Historiku

select 
Cashier,
DocumentDate,
DateDoc,
'PCASH' Tipi,
(Amount-PCARD-PVOUCHER-PPOINTS) as Amount
from LogiPos.dbo.HSalesHeader H
WHERE (DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim)
AND (H.Cashier >= @CNga AND H.Cashier <= @CDeri)
AND (H.CashDesk >= @CDNga AND H.CashDesk <= @CDDeri)
and PCASH <> 0

union all
select 
H.Cashier,
H.DocumentDate,
H.DateDoc,
min(M.Description) as Tipi,
sum(P.Amount) as Amount
from LogiPos.dbo.HBPayment_Transaction P
left join LogiPos.dbo.BPaymentMethod M on M.Code = P.BPaymentCode
left join LogiPos.dbo.HSalesHeader H on h.DocumentNo = p.DocumentNo
WHERE (h.DocumentDate >= @DateFillim AND h.DocumentDate <= @DateMbarim)
AND (H.Cashier >= @CNga AND H.Cashier <= @CDeri)
AND (H.CashDesk >= @CDNga AND H.CashDesk <= @CDDeri)
and PCARD <> 0
group by H.Cashier, H.DocumentDate, h.DateDoc, P.BPaymentCode

union all

select 
Cashier,
DocumentDate,
DateDoc,
'PVoucher' Tipi,
PVOUCHER as Amount
from LogiPos.dbo.HSalesHeader H
WHERE (DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim)
AND (H.Cashier >= @CNga AND H.Cashier <= @CDeri)
AND (H.CashDesk >= @CDNga AND H.CashDesk <= @CDDeri)
and PVOUCHER <> 0

union all

select 
Cashier,
DocumentDate,
DateDoc,
'PPOINTS' Tipi,
PVOUCHER as Amount
from LogiPos.dbo.HSalesHeader H
WHERE (DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim)
AND (H.Cashier >= @CNga AND H.Cashier <= @CDeri)
AND (H.CashDesk >= @CDNga AND H.CashDesk <= @CDDeri)
and PPOINTS <> 0




) A
left join LogiPos.dbo.Users U on U.Id = A.Cashier
group by Cashier, Tipi
order by Cashier


GO

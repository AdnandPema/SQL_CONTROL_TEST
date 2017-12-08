SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[Logical_Rpt_FiscalInvoices] 

(

@DateFillim AS DATETIME, 
@DateMbarim AS DateTime,
@SerialNo AS varchar(30),
@Cashdesk as varchar(30)



)
AS

DECLARE @SNga as varchar(30)
DECLARE @SDeri as varchar(30)

DECLARE @CDNga varchar(30)
DECLARE @CDDeri varchar(30)

SET @SNga = @SerialNo
SET @SDeri = @SerialNo

SET @CDNga = @CashDesk
SET @CDDeri = @CashDesk

IF @SerialNo = ''
BEGIN
SET @SNga = ''
SET @SDeri = 'zz'
END

IF @CashDesk = ''
BEGIN
SET @CDNga = '00'
SET @CDDeri = 'ZZ'
END

select
DocumentDate,
DateDoc,
CashDesk,
DocumentNo,
CustomerNo,
CustomerName,
SerialNo,
round(AmountNoVAT,2) AmountNoVAT,
round(VATValue,2) VATValue,
round(Amount,2) Amount

from

(
select 

DocumentDate,
DateDoc,
CashDesk,
DocumentNo,
h.CustomerNo,
min(c.Name) CustomerName,
h.SerialNo,
sum(l.Amount/(1+(l.[VAT%]/100))) AmountNoVAT,
min(h.amount) - sum(l.Amount/(1+(l.[VAT%]/100))) VATValue,
min(h.amount) Amount
from LogiPOS.dbo.SalesLines L
left join LogiPOS.dbo.SalesHeader H on L.HeaderID = h.ID
left join LogiPOS.dbo.Customer c on h.CustomerNo = c.[No]
where h.SerialNo <> ''
and (DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim)
AND H.SerialNo like '%'+@SNga+'%'--(H.SerialNo >= @SNga AND H.SerialNo <= @SDeri)
AND (H.CashDesk >= @CDNga AND H.CashDesk <= @CDDeri)
group by DocumentDate,DateDoc, CashDesk, DocumentNo, h.CustomerNo, h.SerialNo

union all

select 

DocumentDate,
DateDoc,
CashDesk,
DocumentNo,
h.CustomerNo,
min(c.Name) CustomerName,
h.SerialNo,
sum(l.Amount/(1+(l.[VAT%]/100))) AmountNoVAT,
min(h.amount) - sum(l.Amount/(1+(l.[VAT%]/100))) VATValue,
min(h.amount) Amount
from LogiPOS.dbo.HSalesLines L
left join LogiPOS.dbo.HSalesHeader H on L.HeaderID = h.ID
left join LogiPOS.dbo.Customer c on h.CustomerNo = c.[No]
where h.SerialNo <> ''
and (DocumentDate >= @DateFillim AND DocumentDate <= @DateMbarim)
AND H.SerialNo like '%'+@SNga+'%'--(H.SerialNo >= @SNga AND H.SerialNo <= @SDeri)
AND (H.CashDesk >= @CDNga AND H.CashDesk <= @CDDeri)
group by DocumentDate,DateDoc, CashDesk, DocumentNo, h.CustomerNo, h.SerialNo

) A


order by DocumentDate asc
GO

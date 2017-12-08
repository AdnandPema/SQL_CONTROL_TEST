SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE procedure

[dbo].[LogiMARK_Rpt_VoucherStatus]

 @StarDate datetime
,@EndDate datetime
--,@Client nvarchar (100)
--,@LogiPOSDB nvarchar(100)
--,@CRMDB nvarchar(100)

as

select
V.Barcode Voucheri,
R.RecipesNO Kodi_Recetes,
R.RecipesDescription Pershkrimi_Recetes,
L.DocumentDate Data_Leshimit,
round(convert(float,L.Amount),3) Vlera_Leshimit,
isnull(D.DocumentDate,'') Data_Perdorimit,
isnull(C.FirstName + ' '+ C.LastName,'') Klienti,
round(isnull(convert(float,D.Amount),0),3) Vlera,
round(convert(float,isnull(((isnull(D.Amount,0)-L.Amount)/D.Amount),0)),5) Koeficenti_Kthimit


from voucher..livestream V
left join

(
select
DocumentDate,
DocumentNo,
LoyalityCardID,
VoucherBarcode,
RecipeNo,
Amount
from logipos..salesheader
where RecipeNo <> ''
and DocumentDate between @StarDate and @EndDate

union all

select
DocumentDate,
DocumentNo,
LoyalityCardID,
VoucherBarcode,
RecipeNo,
Amount
from logipos..hsalesheader
where RecipeNo <> ''
) L on l.DocumentNo = v.DocumentNoPrinted
and DocumentDate between @StarDate and @EndDate

left join 

(
select
DocumentDate,
DocumentNo,
LoyalityCardID,
VoucherBarcode,
RecipeNo,
Amount
from logipos..salesheader
where VoucherBarcode <> ''


union all

select
DocumentDate,
DocumentNo,
LoyalityCardID,
VoucherBarcode,
RecipeNo,
Amount
from logipos..hsalesheader
where VoucherBarcode <> ''

) D on D.DocumentNo = v.DocumentNoUsed

left join CRM.dbo.Client_Barcode BC on BC.Barcode = D.LoyalityCardID
left join CRM.dbo.Client C on c.Id = bc.ClientId
left join Recipes_Trigger R on r.RecipesNO = L.RecipeNo
where l.RecipeNo is not null
order by L.DocumentDate 

GO

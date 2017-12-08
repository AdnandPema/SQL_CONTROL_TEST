SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--Frekuenca e klienteve duke perdorur promocione

CREATE procedure

[dbo].[LogiMARK_Rpt_ClientPromoFrequence]

 @StarDate datetime
,@EndDate datetime
--,@Client nvarchar (100)
--,@LogiPOSDB nvarchar(100)
--,@CRMDB nvarchar(100)
as


select
min(FirstName) + ' ' + min(LastName)  as Klienti,
RecipeNo 'Kodi Recetes',
MIN(RecipesDescription) as 'Pershkrimi Recetes',
round(SUM(Ticket),0) as 'Fatura',
round(SUM(Amount)/SUM(Ticket),0) as 'Shporta Mesatare',
round(SUM(Amount),0) as Xhiro
from 

(
select
LoyalityCardID,
RecipeNo,
COUNT(1) Ticket,
sum(Amount) Amount
from Logipos..SalesHeader
where RecipeNo <> '' and LoyalityCardID <> ''
and DocumentDate BETWEEN @StarDate and @EndDate
group by LoyalityCardID, RecipeNo

union all

select
LoyalityCardID,
RecipeNo,
COUNT(1) Ticket,
sum(Amount) Amount
from Logipos..HSalesHeader
where RecipeNo <> '' and LoyalityCardID <> ''
and DocumentDate BETWEEN @StarDate and @EndDate
group by LoyalityCardID, RecipeNo

) A
left join CRM..Client_Barcode on Client_Barcode.Barcode = A.LoyalityCardID
left join CRM..Client on Client.Id = Client_Barcode.ClientId
left join Recipes_Trigger on Recipes_Trigger.RecipesNo = A.RecipeNo
group by RecipeNo, ClientId
order by COUNT(1) desc, SUM(Amount) desc

GO

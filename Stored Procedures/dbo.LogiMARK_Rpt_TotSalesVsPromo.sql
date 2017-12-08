SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE procedure

[dbo].[LogiMARK_Rpt_TotSalesVsPromo]

 @StarDate datetime
,@EndDate datetime
--,@LogiPOSDB nvarchar(100)


as

select
 'Tipi_i_shitjes' = case a.RecipeNo
    when '' then 'Pa Receta'
    else 'Me receta'
    end,
    isnull(min(r.RecipesDescription),'') 'Pershkrimi i Recetes',
    'Shitje per '= case CRM when 1 then 'Kliente CRM' else '' end,
    round(SUM(ticket),0) as NrFatura,
    round(SUM(amount) / SUM(ticket),0) as ShportaMesatare,
    round(SUM(amount),0) as Xhiro
    from 
    (
    select 
    
    RecipeNo,
    CRM=case LoyalityCardID when '' then 0 else 1 end,
    COUNT(1) Ticket,
    sum(Amount) Amount
    from logiPOS..SalesHeader
   where DocumentDate BETWEEN @StarDate and @EndDate
   group by RecipeNo,case LoyalityCardID when '' then 0 else 1 end
    union all
   select 
    
    RecipeNo,
    CRM=case LoyalityCardID when '' then 0 else 1 end,
    COUNT(1) Ticket,
    sum(Amount) Amount
    from logiPOS..HSalesHeader
   where DocumentDate BETWEEN @StarDate and @EndDate
   group by RecipeNo, case LoyalityCardID when '' then 0 else 1 end
    ) A 
    left join Recipes_Trigger R on r.RecipesNO = a.RecipeNo
    group by case a.RecipeNo
    when '' then 'Pa Receta'
    else 'Me receta'
    end, crm
    order by case a.RecipeNo
    when '' then 'Pa Receta'
    else 'Me receta'
    end, crm

GO

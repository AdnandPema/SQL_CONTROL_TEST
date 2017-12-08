SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE view
[dbo].[Recipe_SDSC_HH]
as

select top 100 percent
(A.recipesNo) RecipeNo,
inputTVAlue Times,
A.OutputAValue Category,
(B.OutputAValue) Discount
from
(
select
recipesNo,
inputTVAlue,
OutputAValue
from Recipe_SDSC
where OutputTrigger = 'Item Category Code' 
) A 
left join
(
select
recipesNo,
OutputAValue
from Recipe_SDSC
where OutputTrigger = 'Zbritje ne %' 
) B on A.recipesNo = B.recipesNo

order by convert(float,(B.OutputAValue)) asc






GO

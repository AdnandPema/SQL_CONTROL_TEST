SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





create view
[dbo].[Recipe_HH]
as

select
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

union all

select
A.recipesNo RecipeNo,--max(A.recipesNo) RecipNo,
inputTVAlue Times,
A.OutputAValue Category,
(CAST(B.OutputAValue AS FLOAT))Discount--MAX(CAST(B.OutputAValue AS FLOAT)) Discount

from
(
select
recipesNo,
inputTVAlue,
OutputAValue
from Recipe_RCDV
where OutputTrigger = 'Item Category Code' 
) A 
left join
(
select
recipesNo,
OutputAValue
from Recipe_RCDV
where OutputTrigger = 'Zbritje ne %' 
) B on A.recipesNo = B.recipesNo






GO

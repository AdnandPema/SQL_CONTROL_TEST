SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE view 

[dbo].[Recipe_RCDV]

as 

select 
r.recipesNo,
InputTValue,
OutputTrigger,
OutputAValue,
R.id RID,
t.id as TID
from 


(select --Merr trigerin aktiv per cdo recete

Recipes_Trigger.Id,
Recipes_Trigger.RecipesNo,
--Recipes_Trigger.RecipesDescription,
--Recipes_Trigger.StartDate,
--dbo.Recipes_Trigger.StartTime,
--Recipes_Trigger.EndDate,
--dbo.Recipes_Trigger.EndTime,
--Recipes_Trigger.StoreCode,
--b.Value as InputChannel,
--a.[Column Name] as InputTrigger,
--a.ICond,
--a.[Type],
Recipes_Trigger.Value as InputTValue
--F.AValue as OutputChannel
from  Recipes_Trigger
left join 
(select id ,Value from Input_Channels )as b on b.id = Recipes_Trigger.InputChannelsID
left join 
(select id as IDTN,[Column Name],condition as ICond,[Type] from Trigger_New)as a on a.IDTN = Recipes_Trigger.TriggerID
left join 
(select distinct RecipesNo,OutputChannelId,c.AValue
from Recipes_Actions
left join 
( select ID as IDOC,value as AValue from Output_Channels)as c 
on 
c.IDOC = Recipes_Actions.OutputChannelId)as F
on F.RecipesNo = Recipes_Trigger.RecipesNO 
where Active = 1 
and CONVERT(DATE,GETDATE()) between StartDate and EndDate
AND StartTime <= CONVERT(time,getdate(),108) 
AND CONVERT(time,getdate(),108)  < EndTime  
AND CONVERT(time,getdate(),108)  < EndTime 
and ( a.[Column Name] = 'VisitsNr' and b.Value = 'Klienti' and F.AValue = 'Artikulli' and Recipes_Trigger.RecipesDescription='Returning Customer on daily visits')

) T 

-- Merr Aksionin qe duhet te ndodhe per cdo triger
left join 
(

select 
Recipes_Actions.id,
Recipes_Actions.RecipesNo,
--c.AValue as OutputChannel,
--d.ActionColumn,
d.OutputColumnName as OutputTrigger,
--d.OCond,
--d.[Type],
Recipes_Actions.ValueAction as OutputAValue
from Recipes_Actions
left join
( select ID as IDOC,value as AValue from Output_Channels)as c
on
c.IDOC = Recipes_Actions.OutputChannelId
left join
( select id as IDAN,ActionColumn,[Column Name]as OutputColumnName,condition as OCond,[Type] from Actions_New ) as d
on
d.IDAN = Recipes_Actions.ActionsId
) 
R on r.RecipesNo = t.RecipesNo                             
GO

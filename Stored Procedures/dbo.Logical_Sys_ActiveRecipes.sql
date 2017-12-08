SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Logical_Sys_ActiveRecipes] 
AS
select Recipes_Trigger.Id,
                                   Recipes_Trigger.RecipesNo,
                                   Recipes_Trigger.RecipesDescription,
                                   Recipes_Trigger.StartDate,
                                   dbo.Recipes_Trigger.StartTime,
                                   Recipes_Trigger.EndDate,
                                   dbo.Recipes_Trigger.EndTime,
                                   (Recipes_Trigger.StoreType+ ' '+ dbo.Recipes_Trigger.storevalue) AS store,
                                   b.Value as InputChannel,
                                   a.[Column Name] as InputTrigger,
                                   a.ICond,
                                   a.[Type],
                                   Recipes_Trigger.Value as InputTValue,
                                   F.AValue as OutputChannel,
                                   u.Description AS [USER]
                                  ,Recipes_Trigger.[status]
                                  ,Recipes_Trigger.[Type] AS RecipesType
                                  ,Optional
                                  ,Notes
                                  ,ISNULL(ClientCode,'All')ClientCode                                  
                             from  Recipes_Trigger
                             LEFT JOIN users u ON u.id = dbo.Recipes_Trigger.createduser  
                                left join 
                            (
								select id ,
									   Value
							     from Input_Channels 
							 )as b on b.id = Recipes_Trigger.InputChannelsID
								
								left join 
							(
                                select id as IDTN,
                                       [Column Name],
                                       condition as ICond,
                                       [Type] from Trigger_New
                             )as a   on a.IDTN = Recipes_Trigger.TriggerID
                          
                                left join 
                            (
                               select distinct RecipesNo,
											OutputChannelId,
											c.AValue
                               from Recipes_Actions
                                 left join 
                                   ( 
                                       select ID as IDOC,
                                              value as AValue
                                       from Output_Channels
                                    )as c on  c.IDOC = Recipes_Actions.OutputChannelId
                             )as F on F.RecipesNo = Recipes_Trigger.RecipesNO 
                                   
                            where 
                            Active = 1 and 
                             CONVERT(DATE,GETDATE()) between StartDate and EndDate
                           AND 
                           StartTime <= CONVERT(time,getdate(),108) 
                          
                           AND
                           CONVERT(time,getdate(),108)  < EndTime
                           and (
							monday = 1 and 'monday' = datename(dw,getdate()) 
							or tuesday = 1 and 'tuesday' = datename(dw,getdate())
							or Wednesday = 1 and 'Wednesday' = datename(dw,getdate())
							or thursday = 1 and 'thursday' = datename(dw,getdate())
							or friday = 1 and 'friday' = datename(dw,getdate())
							or saturday = 1 and 'saturday' = datename(dw,getdate())
							or sunday = 1 and 'sunday' = datename(dw,getdate())
) 
ORDER BY F.RecipesNo,id ASC


GO

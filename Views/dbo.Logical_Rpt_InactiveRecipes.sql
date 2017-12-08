SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE View [dbo].[Logical_Rpt_InactiveRecipes] 
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
                                   ,Recipes_Trigger.[type] AS Recipestype
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
                           Active = 0 --and 
                           --  CONVERT(DATE,GETDATE()) between StartDate and EndDate
                           --AND 
                           --StartTime <= CONVERT(time,getdate(),108) 
                           ----cast(StartTime as time )<= cast (GETDATE() as time)
                           --AND
                           --CONVERT(time,getdate(),108)  < EndTime
--ORDER BY id ASC
--EXEC dbo.ACTIVE_RECIPES @timeNow = '2013-12-12 ' -- datetime



GO

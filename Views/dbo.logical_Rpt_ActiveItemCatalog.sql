SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[logical_Rpt_ActiveItemCatalog] AS


SELECT ir.id
,ir.RecipeNo
,ir.RecipeDescription
,ir.StartDate
,ir.EndDate
,ir.StartHour
,ir.EndHour
,ir.monday
,ir.TuesDay
,ir.Wednesday
,ir.Thursday
,ir.Friday
,ir.Saturday
,ir.Sunday
,ir.[Type]
,ir.Code
,ir.Quantity
,ir.UnitPrice
,ir.StoreType
,ir.StoreValue
,u.Description AS [LastUserModified]
,ct.Description AS ClientCode
FROM dbo.Item_Recipes ir
LEFT JOIN dbo.Users u ON ir.LastUserModified = u.Id
LEFT JOIN dbo.ClientType ct ON ct.Code = ClientCode
WHERE ir.Active=1 
--AND  ([startdate] <= CONVERT(DATE,GETDATE())and [enddate] >= CONVERT(DATE,GETDATE()))
--                            and ([starthour] <= CONVERT(VARCHAR(8),GETDATE(),108) and [endhour] >= CONVERT(VARCHAR(8),GETDATE(),108))
--                            and (
--									monday = 1 and 'monday' = datename(dw,getdate()) 
--									or tuesday = 1 and 'tuesday' = datename(dw,getdate())
--									or Wednesday = 1 and 'Wednesday' = datename(dw,getdate())
--									or thursday = 1 and 'thursday' = datename(dw,getdate())
--									or friday = 1 and 'friday' = datename(dw,getdate())
--									or saturday = 1 and 'saturday' = datename(dw,getdate())
--									or sunday = 1 and 'sunday' = datename(dw,getdate())
--                            )


GO

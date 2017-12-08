SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Logical_Sys_Catalog_Item] 
(@itemNo AS NVARCHAR(4000)
,@store AS NVARCHAR(500))
AS
BEGIN
--SELECT * FROM item_recipes
declare @kodi1 varchar(4000) 
set @kodi1 = @itemNo 
select 
TOP 1 
                            RecipeNo,
                            recipeDescription,
                            hh.UnitPrice UnitPrice
                            from dbo.item_recipes hh --duhet bere dinamike
                            where ([startdate] <= CONVERT(DATE,GETDATE())and [enddate] >= CONVERT(DATE,GETDATE()))
                            and ([starthour] <= CONVERT(VARCHAR(8),GETDATE(),108) and [endhour] >= CONVERT(VARCHAR(8),GETDATE(),108))
                            and (
									monday = 1 and 'monday' = datename(dw,getdate()) 
									or tuesday = 1 and 'tuesday' = datename(dw,getdate())
									or Wednesday = 1 and 'Wednesday' = datename(dw,getdate())
									or thursday = 1 and 'thursday' = datename(dw,getdate())
									or friday = 1 and 'friday' = datename(dw,getdate())
									or saturday = 1 and 'saturday' = datename(dw,getdate())
									or sunday = 1 and 'sunday' = datename(dw,getdate())
                            )
                             and Active = 1 and [Type]= 1 
                             and Code = @kodi1
                            AND @store =
                             (CASE  
                              WHEN StoreType='Te gjithe' THEN  ( SELECT TOP 1 @store FROM store WHERE StoreCode IN(SELECT DISTINCT StoreCode FROM dbo.Store))
                              WHEN StoreType='StoreCode' THEN (storeValue)
                              WHEN StoreType='City' THEN ( SELECT TOP 1 @store FROM store WHERE StoreCode IN (select DISTINCT storecode FROM store WHERE City=StoreValue))
                              WHEN StoreType='State' THEN ( SELECT TOP 1 @store FROM store WHERE StoreCode IN (SELECT DISTINCT storecode FROM store WHERE [State]=StoreValue))
                              WHEN StoreType='GeograficLocation' THEN ( SELECT TOP 1 @store FROM store WHERE StoreCode IN (SELECT DISTINCT storecode FROM store WHERE [GeograficLocation]=StoreValue))
                              WHEN StoreType='StoreFormat' THEN ( SELECT TOP 1 @store FROM store WHERE StoreCode IN (SELECT DISTINCT storecode FROM store WHERE [GeograficLocation]=StoreValue))
                              WHEN StoreType='NrofCheckOutDesk' THEN  (SELECT TOP 1 @store FROM store WHERE StoreCode IN (SELECT DISTINCT storecode FROM store WHERE [NrofCheckOutDesk]=StoreValue))
                             ELSE ''
                             END)
                           
                        END
GO

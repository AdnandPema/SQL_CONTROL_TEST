SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Logical_Sys_SalesPriceHappyHour_Item] 
(@itemNo AS NVARCHAR(4000))
AS

BEGIN

declare @kodi1 varchar(4000) 
set @kodi1 = @itemNo 
select 
                            'LogiMARK HH Artikull' RecipeNo,
                            min(hh.UnitPrice) UnitPrice
                            from dbo.happyhours hh --duhet bere dinamike
                            WHERE
                            (GETDATE() BETWEEN CONVERT (DATE,CONVERT(NVARCHAR(50),StartDate)+' '+CONVERT(NVARCHAR(50),StartHour)) AND 
							CONVERT(DATE,CONVERT(NVARCHAR(50),EndDate)+' ' +CONVERT(NVARCHAR(50),EndHour)))
                            -- ([startdate] <= CONVERT(DATE,GETDATE())and [enddate] >= CONVERT(DATE,GETDATE()))
                            --and ([starthour] <= CONVERT(VARCHAR(8),GETDATE(),108) and [endhour] >= CONVERT(VARCHAR(8),GETDATE(),108))
                            and (
                            monday = 1 and 'monday' = datename(dw,getdate()) 
                            or tuesday = 1 and 'tuesday' = datename(dw,getdate())
                            or Wednesday = 1 and 'Wednesday' = datename(dw,getdate())
                            or thursday = 1 and 'thursday' = datename(dw,getdate())
                            or friday = 1 and 'friday' = datename(dw,getdate())
                            or saturday = 1 and 'saturday' = datename(dw,getdate())
                            or sunday = 1 and 'sunday' = datename(dw,getdate())
                            ) 
                            and Active = 1 
                            and [Type]= 1 
                            and Code = @kodi1
                            END

GO

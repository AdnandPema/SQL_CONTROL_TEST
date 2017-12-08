SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Logical_Sys_SalesPriceHappyHour_Category] 
(
@itemNo AS NVARCHAR(4000)
)
AS

BEGIN

declare @kodi1 nvarchar(4000) 
DECLARE @skonto FLOAT
DECLARE @RecipeNo NVARCHAR(4000)

set @kodi1 = @itemNo 
--nxierr vetem skonton nese ska do e nxierri zero
SELECT TOP 1 
@skonto = isnull((UnitPrice),0),
@RecipeNo = (RecipeNo)
from
(
select 
				'LogiMARK HH Kategori ' RecipeNo,
				max(hh.UnitPrice) UnitPrice
				from dbo.happyhours hh --duhet bere dinamike
				where 
				(GETDATE() BETWEEN CONVERT (DATE,CONVERT(NVARCHAR(50),StartDate)+' '+CONVERT(NVARCHAR(50),StartHour)) AND 
				CONVERT(DATE,CONVERT(NVARCHAR(50),EndDate)+' ' +CONVERT(NVARCHAR(50),EndHour)))
				--([startdate] <= CONVERT(DATE,GETDATE())and [enddate] >= CONVERT(DATE,GETDATE()))
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
				and [Type]= 2 
				and Code =@kodi1
				
UNION all
--happy hour Group
		select 
				'LogiMARK HH Grup '+MIN(hh.HHCode) AS  RecipeNo,
				max(hh.UnitPrice) UnitPrice
				from dbo.happyhours hh --duhet bere dinamike
				where 
				(GETDATE() BETWEEN CONVERT (DATE,CONVERT(NVARCHAR(50),StartDate)+' '+CONVERT(NVARCHAR(50),StartHour)) AND 
				CONVERT(DATE,CONVERT(NVARCHAR(50),EndDate)+' ' +CONVERT(NVARCHAR(50),EndHour)))
				--([startdate] <= CONVERT(DATE,GETDATE())and [enddate] >= CONVERT(DATE,GETDATE()))
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
				and [Type]= 3 
				and Code = @kodi1
		UNION ALL 
		--happyhour Category 3
		select 
				'LogiMARK HH Category 3 '+MIN(hh.HHCode) AS  RecipeNo,
				max(hh.UnitPrice) UnitPrice
				from dbo.happyhours hh --duhet bere dinamike
				where 
				(GETDATE() BETWEEN CONVERT (DATE,CONVERT(NVARCHAR(50),StartDate)+' '+CONVERT(NVARCHAR(50),StartHour)) AND 
				CONVERT(DATE,CONVERT(NVARCHAR(50),EndDate)+' ' +CONVERT(NVARCHAR(50),EndHour)))
				--([startdate] <= CONVERT(DATE,GETDATE())and [enddate] >= CONVERT(DATE,GETDATE()))
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
				and [Type]= 4 
				and Code = @kodi1		
		UNION ALL 
		--happyhour Category 4
		select 
				'LogiMARK HH Category 4 '+MIN(hh.HHCode) AS  RecipeNo,
				max(hh.UnitPrice) UnitPrice
				from dbo.happyhours hh --duhet bere dinamike
				where 
				(GETDATE() BETWEEN CONVERT (DATE,CONVERT(NVARCHAR(50),StartDate)+' '+CONVERT(NVARCHAR(50),StartHour)) AND 
				CONVERT(DATE,CONVERT(NVARCHAR(50),EndDate)+' ' +CONVERT(NVARCHAR(50),EndHour)))
				--([startdate] <= CONVERT(DATE,GETDATE())and [enddate] >= CONVERT(DATE,GETDATE()))
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
				and [Type]= 5 
				and Code = @kodi1	
				
		UNION ALL 
		--happyhour Category 5
		select 
				'LogiMARK HH Category 5 '+MIN(hh.HHCode) AS  RecipeNo,
				max(hh.UnitPrice) UnitPrice
				from dbo.happyhours hh --duhet bere dinamike
				where 
				(GETDATE() BETWEEN CONVERT (DATE,CONVERT(NVARCHAR(50),StartDate)+' '+CONVERT(NVARCHAR(50),StartHour)) AND 
				CONVERT(DATE,CONVERT(NVARCHAR(50),EndDate)+' ' +CONVERT(NVARCHAR(50),EndHour)))
				--([startdate] <= CONVERT(DATE,GETDATE())and [enddate] >= CONVERT(DATE,GETDATE()))
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
				and [Type]= 6 
				and Code = @kodi1
		UNION ALL 
		--happyhour Category 6
		select 
				'LogiMARK HH Category 6 '+MIN(hh.HHCode) AS  RecipeNo,
				max(hh.UnitPrice) UnitPrice
				from dbo.happyhours hh --duhet bere dinamike
				where 
				(GETDATE() BETWEEN CONVERT (DATE,CONVERT(NVARCHAR(50),StartDate)+' '+CONVERT(NVARCHAR(50),StartHour)) AND 
				CONVERT(DATE,CONVERT(NVARCHAR(50),EndDate)+' ' +CONVERT(NVARCHAR(50),EndHour)))
				--([startdate] <= CONVERT(DATE,GETDATE())and [enddate] >= CONVERT(DATE,GETDATE()))
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
				and [Type]= 7 
				and Code = @kodi1			
            )a
             where UnitPrice is not null
		     order by UnitPrice ASC
		     
select @skonto as UnitPrice, @RecipeNo as RecipeNo
		  
  END

GO
